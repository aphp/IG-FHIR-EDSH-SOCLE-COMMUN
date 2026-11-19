// Hook de contrôle du profil de permissions « édition de guide FHIR ».
// Spec : https://gitlab.data.aphp.fr/ID/data-strategy/tool/setup-claude-code
//        docs/specs/profil-edition-guide-fhir.md, partie 9.
//
// Node, sans dépendance. Entrée : le JSON du hook PreToolUse sur l'entrée standard.
// Sortie : rien si l'appel passe (le circuit normal des permissions continue),
//          une décision « deny » avec la raison, ou « ask » pour forcer une confirmation.
// Toute erreur fait échouer le hook ; le réglage onFailure: "block" transforme cet échec en refus.
//
// Ce hook est une garantie AU MIEUX : il ne voit que le texte de la commande. Un script, un build
// ou une commande obscurcie lui échappent (spec, partie 11).
//
// Cas d'essai : node --test .claude/hooks/
'use strict';

// ---------------------------------------------------------------- listes du profil (spec, partie 7)
const NEVER_TOUCH = ['.gitlab-ci.yml', '.claude/**', '.git/**'];
const NEVER_READ = ['.env', '.env.*', '.npmrc', '.netrc', '*.pem', '*.key', '*.p12', '*.pfx', 'fhir-settings.json'];
const WRITE_WITH_CONFIRM = ['publication-request.json', 'sushi-config.yaml', 'build.gradle.kts', 'settings.gradle',
  'settings.gradle.kts', 'gradlew', 'gradlew.bat', 'gradle/wrapper/**', 'gradle.properties', 'scripts/**', 'ig.ini',
  'input/ignoreWarnings.txt', '.gitignore', 'CLAUDE.md'];
// .gradle/ contient le Node qui exécute ce hook : jamais écrit par le shell.
const GENERATED = ['fsh-generated/**', 'fml-generated/**', 'output/**', 'temp/**', 'template/**', 'input-cache/**',
  'build/**', 'node_modules/**', '.gradle/**'];
const SINKS = new Set(['/dev/null', 'nul', '$null', '/dev/stdout', '/dev/stderr']);

const MESSAGES = {
  'temporaire général': 'Refusé : temporaire général hors du confinement. Écrire les fichiers intermédiaires dans le dossier de session.',
  '~/.claude': 'Refusé : ~/.claude est hors du confinement (mémoire, plugins, réglages). La connaissance durable va dans le dépôt du guide (CLAUDE.md).',
  'autre dépôt (~/Projects)': "Refusé : autre dépôt hors du confinement. Pour consulter un guide de référence, demander à l'utilisateur de l'ouvrir par /add-dir, puis le lire avec Read/Grep.",
  "zone d'exception d'outil": "Refusé : zone réservée aux outils de build. Pour lire un paquet FHIR, demander à l'utilisateur un /add-dir sur ce paquet.",
  'programmes installés': 'Refusé : les dossiers de programmes ne sont jamais modifiés.',
  'répertoire personnel': 'Refusé : répertoire personnel hors du confinement.',
  'autre chemin absolu': 'Refusé : chemin hors du guide et du dossier de session. Lire et écrire dans le guide, ou utiliser Read/Grep.',
  'push-remote': "Refusé : git push vers un autre remote qu'origin, ou vers une URL. Pousser la branche de travail sur origin.",
  'push-main': "Refusé : git push qui vise main. main ne change que par la fusion d'une merge request, geste de l'utilisateur. Pousser une branche de travail.",
  'push-all': 'Refusé : git push --all ou --mirror pousse aussi main. Pousser la seule branche de travail.',
  'push-force': 'Refusé : un refspec « +… » force la poussée, comme --force. Pousser sans forcer.',
  'push-delete': "Refusé : un refspec « :… » supprime une branche distante, comme --delete. C'est un geste de l'utilisateur.",
  'wrapper': 'Refusé : préfixe de commande (command, env, exec…). Écrire la commande directement, pour que les règles du profil s\'appliquent.',
  'suffix': 'Refusé : nom de programme avec extension (.exe, .cmd, .bat). L\'écrire sans extension, pour que les règles du profil s\'appliquent.',
};

// ---------------------------------------------------------------- chemins
const BS = String.fromCharCode(92);
const norm = (p) => {
  let s = p.split(BS).join('/');
  s = s.replace(/^\/([a-zA-Z])(\/|$)/, (_, d) => d.toUpperCase() + ':/');
  s = s.replace(/^([a-zA-Z]):/, (_, d) => d.toUpperCase() + ':');
  const head = /^[A-Z]:\//.test(s) ? s.slice(0, 3) : (s.startsWith('//') ? '//' : '');
  const out = [];
  for (const seg of s.slice(head.length).split('/')) {
    if (seg === '' || seg === '.') continue;
    if (seg === '..') { if (out.length && out[out.length - 1] !== '..') out.pop(); else out.push('..'); }
    else out.push(seg);
  }
  return head + out.join('/');
};
const lower = (s) => s.toLowerCase();
const within = (p, base) => { const a = lower(p), b = lower(base).replace(/\/$/, ''); return a === b || a.startsWith(b + '/'); };
const join = (base, rel) => norm(base + '/' + rel);

function expandVars(tok, ctx) {
  const H = ctx.home, T = ctx.temp, L = H + '/AppData/Local', R = H + '/AppData/Roaming';
  const table = [
    [/^~(?=\/|\\|$)/, H],
    [/^\$\{?(HOME|USERPROFILE)\}?/i, H], [/^\$env:(HOME|USERPROFILE)/i, H], [/^%USERPROFILE%/i, H],
    [/^\$\{?(TEMP|TMPDIR|TMP)\}?/i, T], [/^\$env:(TEMP|TMP)/i, T], [/^%(TEMP|TMP)%/i, T],
    [/^\$\{?LOCALAPPDATA\}?/i, L], [/^\$env:LOCALAPPDATA/i, L], [/^%LOCALAPPDATA%/i, L],
    [/^\$\{?APPDATA\}?/i, R], [/^\$env:APPDATA/i, R], [/^%APPDATA%/i, R],
    [/^\$\{?PWD\}?(\.Path)?/i, ctx.cwd],
  ];
  for (const [re, val] of table) if (re.test(tok)) return tok.replace(re, () => val);
  return null;
}

// Un jeton est-il un chemin, et lequel ? (spec, partie 9, points 1 et 2)
function asPath(raw, ctx) {
  let t = raw.replace(/^['"]|['"]$/g, '').replace(/^\\\\\?\\/, '');
  if (!t || SINKS.has(lower(t))) return null;
  if (/^[a-z][a-z0-9+.-]*:\/\//i.test(t) || /^git@[^:]+:/.test(t)) return null;
  const v = expandVars(t, ctx);
  if (v !== null) return { path: norm(v), kind: 'variable' };
  if (/^[a-zA-Z]:[\\/]/.test(t)) return { path: norm(t), kind: 'absolu' };
  if (/^\\\\[A-Za-z0-9._$-]+\\[^\\]/.test(t)) return { path: norm(t), kind: 'absolu' };
  if (/^\/[a-zA-Z]\//.test(t)) return { path: norm(t), kind: 'absolu' };
  if (/^\/(tmp|etc|usr|var|home|mnt|opt|proc|Users|root)(\/|$)/i.test(t)) {
    return { path: t === '/tmp' || t.startsWith('/tmp/') ? norm(ctx.temp + t.slice(4)) : t, kind: 'absolu', unix: true };
  }
  if (/(^|[\\/])\.\.([\\/]|$)/.test(t)) return { path: join(ctx.cwd, t), kind: 'remontée' };
  return null;
}

// ---------------------------------------------------------------- texte libre
// Les corps de heredoc et de chaînes multi-lignes PowerShell (@'…'@) sont du texte : leurs
// apostrophes, < et > n'ouvrent ni guillemet ni redirection. keepBody : garder le texte, neutralisé,
// pour y chercher des chemins ; sinon le retirer (recherche des noms de programme).
const NEUTRAL = /['"`<>;|&(){}]/g;
function textBodies(cmd, keepBody) {
  const body = (b) => (keepBody ? b.replace(NEUTRAL, ' ') : '');
  return cmd
    .replace(/<<-?[ \t]*(['"]?)([A-Za-z_]\w*)\1([^\n]*)\n([\s\S]*?)\n[ \t]*\2[ \t]*(?=\r?\n|$)/g,
      (_, q, tag, rest, b) => ' ' + rest + '\n' + body(b) + '\n')
    .replace(/@(['"])[ \t]*\r?\n([\s\S]*?)\r?\n\1@/g, (_, q, b) => ' ' + body(b) + ' ');
}

// ---------------------------------------------------------------- découpage
function tokenize(cmd, newlineIsOp) {
  const toks = []; let cur = '', q = null, quoted = false;
  const push = () => { if (cur !== '' || quoted) toks.push({ t: cur, quoted }); cur = ''; quoted = false; };
  for (let i = 0; i < cmd.length; i++) {
    const c = cmd[i];
    if (q) { if (c === q) q = null; else cur += c; continue; }
    if (c === '"' || c === "'") { q = c; quoted = true; continue; }
    if (newlineIsOp && c === '\n') { push(); toks.push({ t: ';', op: true }); continue; }
    if (/\s/.test(c)) { push(); continue; }
    if (';|&(){}'.includes(c)) { push(); toks.push({ t: c, op: true }); continue; }
    if (c === '>' || c === '<') {
      // « 2>&1 » : le chiffre collé devant est un numéro de descripteur, pas un mot
      if (/^\d$/.test(cur)) cur = '';
      push(); let op = c; while (cmd[i + 1] === '>' || cmd[i + 1] === '&') op += cmd[++i];
      // « >&1 » duplique un descripteur : ce n'est pas une écriture dans un fichier
      const dup = op.includes('&') && /^\d/.test(cmd.slice(i + 1));
      if (dup) { while (/\d/.test(cmd[i + 1] || '')) i++; toks.push({ t: op, op: true, fd: true }); }
      else toks.push({ t: op, op: true, redir: c === '>', input: c === '<' });
      continue;
    }
    if (c === '=' && cur && !cur.includes('=') && /^[-A-Za-z_][\w-]*$/.test(cur)) { cur += c; push(); continue; }
    cur += c;
  }
  push();
  return toks;
}

// Commandes simples : coupées aux opérateurs, redirections gardées dans la commande.
function segments(toks) {
  const segs = []; let cur = [];
  for (const tk of toks) {
    if (tk.op && !tk.fd && !tk.redir && !tk.input) { if (cur.length) segs.push(cur); cur = []; continue; }
    cur.push(tk);
  }
  if (cur.length) segs.push(cur);
  return segs;
}

const KEYWORDS = new Set(['then', 'do', 'else', '!']);
// Préfixes qui lancent une autre commande : les règles du profil ne voient que le premier mot.
const WRAPPERS = new Set(['command', 'exec', 'env', 'time', 'nohup', 'sudo', 'builtin']);
const progName = (t) => t.replace(/^.*[\\/]/, '').replace(/\.(exe|cmd|bat)$/i, '').toLowerCase();
// Programmes visés par des règles deny ou ask : « git.exe push --force » échapperait à « git push --force* ».
const RULED = new Set(['git', 'glab', 'gh', 'rm', 'mv', 'cp', 'mkdir', 'curl', 'wget', 'certutil', 'bitsadmin', 'cmd', 'rd',
  'rmdir', 'sed', 'awk', 'find', 'xargs', 'jq', 'sushi', 'java', 'python', 'python3', 'py', 'node', 'npm', 'npx', 'bash',
  'sh', 'pwsh', 'powershell', 'claude']);

// Les règles Bash(...) sont sensibles à la casse, alors que Windows lance « GIT » comme « git » :
// un nom de programme en majuscules échapperait aux règles deny et ask.
function findUppercaseProgram(cmd) {
  const keywords = new Set(['then', 'do', 'else', 'if', 'elif', 'while', 'until', '!', 'time', 'exec', 'command', 'env', 'sudo', 'for', 'case', 'in']);
  let prog = null, afterAssign = false, skipTarget = false;
  for (const tk of tokenize(textBodies(cmd, false), true)) {
    if (tk.op) { if (tk.fd) continue; if (tk.redir || tk.input) skipTarget = true; else { prog = null; afterAssign = false; } continue; }
    if (skipTarget) { skipTarget = false; continue; }
    if (prog !== null) continue;
    const t = tk.t;
    if (/^[A-Za-z_]\w*=$/.test(t)) { afterAssign = true; continue; }
    if (afterAssign) { afterAssign = false; continue; }
    if (keywords.has(t)) { if (t === 'for' || t === 'case') prog = t; continue; }
    prog = t;
    const leaf = t.replace(/^.*[\\/]/, '').replace(/\.(exe|cmd|bat)$/i, '');
    if (/[A-Z]/.test(leaf) && /^[A-Za-z][\w.-]*$/.test(leaf)) return leaf;
  }
  return null;
}

const glob2re = (g) => new RegExp('^' + g.replace(/[.+^${}()|[\]\\]/g, '\\$&').replace(/\*\*/g, '\u0000').replace(/\*/g, '[^/]*').replace(/\u0000/g, '.*') + '$', 'i');
const matchList = (rel, list) => list.find((g) => glob2re(g).test(rel) || (!g.includes('/') && glob2re(g).test(rel.split('/').pop())));

const WRITERS = /^(set-content|add-content|out-file|tee|tee-object|sc|ac)$/i;
const COPYMOVE = /^(cp|mv|copy-item|move-item|copy|move|cpi|mi)$/i;
const MOVE = /^(mv|move-item|move|mi)$/i;
const CD = /^(cd|set-location|sl|pushd|chdir|push-location)$/i;

// ---------------------------------------------------------------- verdict sur un chemin
function judgePath(p, ctx, how) {
  // Dossier de session : le parent de scratchpad_dir, et %TEMP%/claude/<hachage>/<session_id>/.
  // Après un /clear, session_id change alors que scratchpad_dir reste : les deux sont acceptés.
  if (ctx.sessionDir && within(p.path, ctx.sessionDir)) return { ok: true, zone: 'dossier de session' };
  if (ctx.sessionId && within(p.path, ctx.temp + '/claude') && lower(p.path).split('/').includes(lower(ctx.sessionId))) return { ok: true, zone: 'dossier de session' };
  if (how !== 'write') {
    if (ctx.toolResults && within(p.path, ctx.toolResults)) return { ok: true, zone: 'sorties d’outils de la session' };
    const name = p.path.split('/').pop();
    if (/^handoff-.*\.md$/i.test(name) && (within(p.path, ctx.temp + '/claude') || lower(p.path) === lower(ctx.temp + '/' + name))) return { ok: true, zone: 'handoff' };
    if (/^c:\/program files( \(x86\))?(\/|$)/i.test(p.path)) return { ok: true, zone: 'programmes installés' };
  }
  if (!within(p.path, ctx.guideRoot)) {
    let zone = 'autre chemin absolu';
    const P = lower(p.path), H = ctx.home;
    if (/^c:\/program files/i.test(p.path)) zone = 'programmes installés';
    else if (within(p.path, H + '/.claude')) zone = '~/.claude';
    else if (within(p.path, ctx.temp) || P === 'c:/temp' || P.startsWith('c:/temp/') || (p.unix && P.startsWith('/tmp'))) zone = 'temporaire général';
    else if (within(p.path, H + '/Projects')) zone = 'autre dépôt (~/Projects)';
    else if (within(p.path, H + '/.fhir') || within(p.path, H + '/.gradle') || within(p.path, H + '/AppData')) zone = "zone d'exception d'outil";
    else if (within(p.path, H)) zone = 'répertoire personnel';
    return { ok: false, zone, reason: MESSAGES[zone] };
  }
  const rel = p.path.slice(ctx.guideRoot.length).replace(/^\//, '');
  const l3 = matchList(rel, NEVER_READ);
  if (l3) return { ok: false, zone: 'fichier protégé', reason: `Refusé : ${l3} peut contenir un secret ; ni le shell ni Claude ne le lisent.` };
  if (how === 'write') {
    const l1 = matchList(rel, NEVER_TOUCH);
    if (l1) return { ok: false, zone: 'fichier protégé', reason: `Refusé : ${l1} n'est jamais modifié par Claude ; c'est un geste de l'utilisateur.` };
    const l4 = matchList(rel, GENERATED);
    if (l4) return { ok: false, zone: 'fichier protégé', reason: `Refusé : ${l4} est généré par le build ; modifier sa source dans input/.` };
    const l2 = matchList(rel, WRITE_WITH_CONFIRM);
    if (l2) return { ok: false, zone: 'fichier protégé', reason: `Refusé : écriture par le shell dans ${l2} ; utiliser Edit, qui demande confirmation.` };
  }
  return { ok: true, zone: 'guide' };
}

// ---------------------------------------------------------------- git push (spec, partie 9, point 9)
// Le premier argument positionnel doit être origin ; aucune destination ne doit être main.
const GIT_OPT_WITH_VALUE = new Set(['-c', '-C', '--git-dir', '--work-tree', '--namespace', '--exec-path']);
const PUSH_OPT_WITH_VALUE = new Set(['-o', '--push-option', '--receive-pack', '--exec']);
function checkGitPush(args, deny) {
  let i = 0;
  while (i < args.length && args[i].startsWith('-')) { i += GIT_OPT_WITH_VALUE.has(args[i]) ? 2 : 1; }
  if (args[i] !== 'push') return;
  const positional = [];
  for (i++; i < args.length; i++) {
    const a = args[i];
    if (a === '--repo') { deny.push(MESSAGES['push-remote']); i++; continue; }
    if (/^--repo=/.test(a)) { deny.push(MESSAGES['push-remote']); continue; }
    if (a === '--all' || a === '--mirror') { deny.push(MESSAGES['push-all']); continue; }
    if (PUSH_OPT_WITH_VALUE.has(a)) { i++; continue; }
    if (a.startsWith('-')) continue;
    positional.push(a);
  }
  if (positional.length && positional[0] !== 'origin') deny.push(MESSAGES['push-remote']);
  for (const spec of positional.slice(1)) {
    if (spec.startsWith('+')) deny.push(MESSAGES['push-force']);
    if (spec.startsWith(':')) deny.push(MESSAGES['push-delete']);
    const dst = spec.replace(/^\+/, '').split(':').pop();
    if (/^(refs\/heads\/)?main$/i.test(dst)) deny.push(MESSAGES['push-main']);
  }
}

// ---------------------------------------------------------------- décision
// input : le JSON du hook ; env : { guideRoot, home, temp }
function check(input, env) {
  const ctx = {
    guideRoot: norm(env.guideRoot), home: norm(env.home), temp: norm(env.temp),
    cwd: norm(input.cwd || env.guideRoot), sessionId: input.session_id || null,
    sessionDir: input.scratchpad_dir ? norm(norm(input.scratchpad_dir) + '/..') : null,
    toolResults: input.transcript_path ? norm(input.transcript_path).replace(/\.jsonl$/i, '') : null,
  };
  const deny = [], ask = [];
  const tool = input.tool_name, ti = input.tool_input || {};

  if (/^(Edit|Write|NotebookEdit)$/.test(tool)) {
    const fp = ti.file_path || ti.notebook_path || '';
    const abs = /^[a-zA-Z]:|^[\\/]/.test(fp) ? norm(fp) : join(ctx.cwd, fp);
    const j = judgePath({ path: abs }, ctx, 'write');
    // Les fichiers protégés du guide relèvent des règles Edit du profil, pas du hook.
    if (!j.ok && j.zone !== 'fichier protégé') deny.push(j.reason);
    return decide(deny, ask);
  }
  if (tool !== 'Bash' && tool !== 'PowerShell') return decide(deny, ask);

  const command = ti.command || '';
  if (tool === 'Bash') {
    const upper = findUppercaseProgram(command);
    if (upper) deny.push(`Refusé : le nom de programme « ${upper} » contient des majuscules. L'écrire en minuscules, pour que les règles du profil s'appliquent.`);
  }

  let cwd = ctx.cwd;
  const judge = (tk, how, isRedir) => {
    let t = tk.t;
    // VAR=valeur, $var='valeur', --opt=valeur, -Path:valeur : on juge la valeur
    const eq = t.search(/[=:](?![\\/])/);
    if (eq > 0 && /^[-$]?[A-Za-z_][\w-]*$/.test(t.slice(0, eq)) && !/^\$env$/i.test(t.slice(0, eq))) t = t.slice(eq + 1);
    if (!t || (isRedir && SINKS.has(lower(t)))) return null;
    const c = { ...ctx, cwd };
    const p = asPath(t, c);
    if (p) {
      const j = judgePath(p, ctx, how);
      if (!j.ok) deny.push(j.reason);
      else if (isRedir && j.zone === 'guide') ask.push(`Écriture par redirection shell dans le guide (${t}).`);
      return p.path;
    }
    // Texte entre guillemets (message de commit, corps de heredoc…) : on y cherche les chemins
    // absolus, les variables et les remontées. Un « ~ » isolé y est du texte.
    if (tk.quoted && /\s/.test(t) && !isRedir) {
      for (const w of t.split(/[\s,;]+/)) {
        if (!w || w === '~') continue;
        const pw = asPath(w, c);
        if (pw) { const j = judgePath(pw, ctx, 'read'); if (!j.ok) deny.push(j.reason); }
      }
      return null;
    }
    // Chemin relatif simple : ne compte que s'il vise un fichier protégé.
    const j = judgePath({ path: join(cwd, t) }, ctx, how);
    if (!j.ok) deny.push(j.reason);
    else if (isRedir && j.zone === 'guide') ask.push(`Écriture par redirection shell dans le guide (${t}).`);
    return join(cwd, t);
  };

  for (const seg of segments(tokenize(textBodies(command, true), false))) {
    // Mots de la commande, cibles de redirection et fichiers lus par « < ».
    const words = [], redirs = [], inputs = [];
    for (let i = 0; i < seg.length; i++) {
      const tk = seg[i];
      if (tk.fd) continue;
      if (tk.op) { const next = seg[i + 1]; if (next && !next.op) { (tk.redir ? redirs : inputs).push(next); i++; } continue; }
      words.push(tk);
    }
    // Affectations de tête et préfixes (command, env…) avant le nom de programme.
    let k = 0;
    while (k < words.length) {
      if (/^[A-Za-z_]\w*=$/.test(words[k].t)) { judge(words[k + 1] || { t: '' }, 'read', false); k += 2; continue; }
      if (KEYWORDS.has(words[k].t)) { k++; continue; }
      if (WRAPPERS.has(lower(words[k].t))) { deny.push(MESSAGES.wrapper); k++; continue; }
      break;
    }
    const progTok = words[k];
    const prog = progTok ? progName(progTok.t) : '';
    if (progTok && RULED.has(prog) && /\.(exe|cmd|bat)$/i.test(progTok.t)) deny.push(MESSAGES.suffix);
    const args = words.slice(k + 1);
    if (progTok && /[\\/]/.test(progTok.t)) judge(progTok, 'read', false);

    const writesAll = WRITERS.test(prog) || (prog === 'sed' && args.some((a) => /^-i/.test(a.t)));
    const operands = args.filter((a) => !a.t.startsWith('-'));
    const dest = COPYMOVE.test(prog) ? operands[operands.length - 1] : null;
    for (const a of args) {
      const isWrite = writesAll || a === dest || (MOVE.test(prog) && operands.includes(a));
      judge(a, isWrite ? 'write' : 'read', false);
    }
    for (const r of redirs) judge(r, 'write', true);
    for (const r of inputs) judge(r, 'read', false);

    if (prog === 'git') checkGitPush(args.map((a) => a.t), deny);
    if (CD.test(prog) && operands[0]) {
      const p = asPath(operands[0].t, { ...ctx, cwd });
      cwd = p ? p.path : join(cwd, operands[0].t);
    }
  }
  return decide(deny, ask);
}

function decide(deny, ask) {
  if (deny.length) return { decision: 'deny', reason: [...new Set(deny)].join(' ') };
  if (ask.length) return { decision: 'ask', reason: [...new Set(ask)].join(' ') };
  return { decision: 'allow', reason: '' };
}

// ---------------------------------------------------------------- entrée
if (require.main === module) {
  let raw = '';
  process.stdin.setEncoding('utf8');
  process.stdin.on('data', (d) => { raw += d; });
  process.stdin.on('end', () => {
    const guideRoot = process.env.CLAUDE_PROJECT_DIR;
    if (!guideRoot) throw new Error('CLAUDE_PROJECT_DIR absent : le hook ne connaît pas la racine du guide.');
    if (!process.env.USERPROFILE || !process.env.TEMP) throw new Error('USERPROFILE ou TEMP absent.');
    const r = check(JSON.parse(raw), { guideRoot, home: process.env.USERPROFILE, temp: process.env.TEMP });
    if (r.decision !== 'allow') {
      const out = JSON.stringify({ hookSpecificOutput: { hookEventName: 'PreToolUse', permissionDecision: r.decision, permissionDecisionReason: r.reason } });
      // ASCII pur : les caractères accentués sont échappés, quel que soit l'encodage de la console.
      process.stdout.write(out.replace(/[^\x00-\x7F]/g, (c) => '\\u' + c.charCodeAt(0).toString(16).padStart(4, '0')));
    }
  });
} else {
  module.exports = { check };
}
