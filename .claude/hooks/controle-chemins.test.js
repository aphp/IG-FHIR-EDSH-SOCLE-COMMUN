// Cas d'essai du hook de contrôle (spec, partie 12, critère 13).
// Lancer : node --test .claude/hooks/
'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const { check } = require('./controle-chemins.js');

const ENV = { guideRoot: 'C:\\g\\fig-x', home: 'C:\\Users\\u', temp: 'C:\\Users\\u\\AppData\\Local\\Temp' };
const SID = '11111111-2222-3333-4444-555555555555';
const SESSION = `C:\\Users\\u\\AppData\\Local\\Temp\\claude\\hash\\${SID}`;
const BASE = {
  session_id: SID,
  cwd: 'C:\\g\\fig-x',
  scratchpad_dir: `${SESSION}\\scratchpad`,
  transcript_path: `C:\\Users\\u\\.claude\\projects\\C--g-fig-x\\${SID}.jsonl`,
};
const sh = (command, tool = 'Bash', extra = {}) => check({ ...BASE, ...extra, tool_name: tool, tool_input: { command } }, ENV).decision;
const ed = (file_path, tool = 'Write') => check({ ...BASE, tool_name: tool, tool_input: { file_path } }, ENV).decision;

const cases = (title, expected, list, tool) => test(`${title} → ${expected}`, () => {
  for (const c of list) assert.equal(sh(c, tool), expected, c);
});

// ---------------------------------------------------------------- passent
cases('commandes ordinaires dans le guide', 'allow', [
  'git status',
  'git --no-pager log --oneline -5',
  'git diff HEAD~1 -- input/fsh/patient.fsh',
  'ls input/fsh && cat input/fsh/aliases.fsh | head -20',
  './gradlew sushiBuild 2>&1 | tail -50',
  'git push origin feat/ma-branche',
  'git push -u origin HEAD',
  'git push',
  'echo ok > /dev/null',
  'grep -rn "Patient" input/fsh',
  'git commit -m "docs: corrige la page d\'accueil"',
  'cd input && ls fsh',
  'cat .claude/hooks/controle-chemins.js',
  'cat sushi-config.yaml',
]);
cases('commandes PowerShell ordinaires', 'allow', [
  'Get-ChildItem input\\fsh',
  'Get-Content sushi-config.yaml -TotalCount 20',
  'git push origin feat/x; git status',
], 'PowerShell');

test('heredoc de message de commit avec apostrophes → allow', () => {
  const cmd = "git commit -m \"$(cat <<'EOF'\nfeat: ajoute l'entrée « Poids »\n\nC'est l'essai d'un <titre> & (note) ; fin\nEOF\n)\"";
  assert.equal(sh(cmd), 'allow');
});
test('chaîne multi-lignes PowerShell avec apostrophes → allow', () => {
  const cmd = "git commit -m @'\nfix: l'apostrophe n'ouvre rien > ni < redirection\n'@";
  assert.equal(sh(cmd, 'PowerShell'), 'allow');
});
test('heredoc : un nom capitalisé en début de ligne n\'est pas un programme', () => {
  assert.equal(sh("cat <<'EOF' > input/pagecontent/x.md\nTitre\nGIT est cité\nEOF"), 'ask');
});

// ---------------------------------------------------------------- dossier de session, sorties d'outils, handoff
cases('dossier de session', 'allow', [
  `cat ${SESSION}\\scratchpad\\notes.txt`,
  `echo x > "${SESSION}\\scratchpad\\out.txt"`,
  `cat /c/Users/u/AppData/Local/Temp/claude/hash/${SID}/scratchpad/a.json`,
]);
test('dossier de session reconnu par scratchpad_dir après /clear', () => {
  assert.equal(sh(`cat ${SESSION}\\scratchpad\\a.txt`, 'Bash', { session_id: 'autre-id' }), 'allow');
});
cases('lectures en exception', 'allow', [
  `cat C:\\Users\\u\\.claude\\projects\\C--g-fig-x\\${SID}\\tool-results\\abc.txt`,
  'cat C:\\Users\\u\\AppData\\Local\\Temp\\claude\\h2\\autre-session\\handoff-profil.md',
  'cat C:\\Users\\u\\AppData\\Local\\Temp\\handoff-profil.md',
  '"C:\\Program Files\\Java\\bin\\keytool.exe" -help',
]);

// ---------------------------------------------------------------- refus : chemins hors du confinement
cases('chemins hors du confinement', 'deny', [
  'cat C:\\Users\\u\\Projects\\fig-y\\sushi-config.yaml',
  'cat ../fig-y/sushi-config.yaml',
  'cd .. && cat fig-y/README.md',
  'ls ~/.fhir/packages',
  'cat ~/.claude/settings.json',
  'echo x > /tmp/a.txt',
  'echo x > $TEMP/a.txt',
  'echo x > C:\\temp\\a.txt',
  'cat $HOME/.npmrc',
  'cat %USERPROFILE%\\x',
  'cat \\\\serveur\\partage\\x',
  'cat \\\\?\\C:\\autre\\x',
  'cat /etc/passwd',
  'X=C:\\autre\\f.txt cat x',
  'cat --file=C:\\autre\\x',
  'cat C:\\Users\\u\\AppData\\Local\\Temp\\claude\\h2\\autre-session\\notes.txt',
  `cat C:\\Users\\u\\.claude\\projects\\C--g-fig-x\\autre-session\\tool-results\\x.txt`,
  'cp input/a.fsh "C:\\Program Files\\x\\a.fsh"',
  'git commit -m "voir ~/.claude/memory"',
]);
cases('chemins hors du confinement, PowerShell', 'deny', [
  'Get-Content $env:USERPROFILE\\.gitconfig',
  'Set-Content -Path:C:\\autre\\x.txt -Value 1',
  'Get-ChildItem $env:LOCALAPPDATA\\glab-cli',
  'Set-Location ..; Get-Content fig-y\\x',
], 'PowerShell');

// ---------------------------------------------------------------- refus : fichiers protégés
cases('secrets nommés', 'deny', ['cat .env', 'cat ".env"', 'cat config/.env.local', 'cat certs/a.pem', 'Get-Content fhir-settings.json']);
cases('écritures shell dans les fichiers protégés', 'deny', [
  'echo x > .gitlab-ci.yml',
  'echo x >> .claude/settings.json',
  'cp a.json .claude/settings.json',
  'mv sushi-config.yaml old.yaml',
  'echo x > output/qa.html',
  'echo x > fsh-generated/resources/a.json',
  "sed -i 's/a/b/' sushi-config.yaml",
  'tee CLAUDE.md < x.txt',
  'echo x > .gradle/x',
  'echo x > .git/config',
]);
cases('écritures shell dans les fichiers protégés, PowerShell', 'deny', [
  'Set-Content .gitlab-ci.yml x',
  'Out-File -FilePath scripts/x.ps1',
  'Copy-Item a.txt gradle.properties',
], 'PowerShell');

// ---------------------------------------------------------------- confirmation : redirection dans le guide
cases('redirection vers un fichier du guide', 'ask', ['echo x > input/pagecontent/a.md', 'git log >> notes.txt']);
cases('redirection vers un fichier du guide, PowerShell', 'ask', ['git log > notes.txt'], 'PowerShell');

// ---------------------------------------------------------------- noms de programme en majuscules (Bash)
cases('majuscules dans Bash', 'deny', ['GIT push --force', 'Git status', 'ls && RM -rf x', 'FOO=1 Git status', 'GIT.exe status']);
test('majuscules en PowerShell → allow (règles insensibles à la casse)', () => {
  assert.equal(sh('Get-ChildItem input', 'PowerShell'), 'allow');
});

// ---------------------------------------------------------------- git push
cases('git push refusés', 'deny', [
  'git push origin main',
  'git push origin HEAD:main',
  'git push origin feat:main',
  'git push origin :main',
  'git push origin refs/heads/main',
  'git push origin HEAD:refs/heads/main',
  'git push origin +main',
  'git push fork feat/x',
  'git push https://gitlab.eds.aphp.fr/x/y.git feat/x',
  'git push --repo=fork feat/x',
  'git push --all origin',
  'git push --mirror origin',
  'git --no-pager push origin main',
  'git push origin +feat/x',
  'git push origin :feat/x',
  'git status && git push fork feat/x',
]);
cases('préfixes et extensions qui échappent aux règles', 'deny', [
  'command git push --force',
  'env git reset --hard',
  'git.exe push --force',
  'ls && curl.exe https://exemple.org',
  'cmd.exe /c rd /s /q build',
]);
cases('extensions sans règle visée', 'allow', ['.\\gradlew.bat sushiBuild', 'gradlew.bat buildIG']);
cases('git push refusés, PowerShell', 'deny', ['git push origin main', '& git push fork x'], 'PowerShell');
cases('git push permis par le hook (confirmés par les règles)', 'allow', [
  'git push origin feat/main-menu',
  'git push -u origin feat/x',
  'git push --set-upstream origin feat/x',
  'git push -o ci.skip origin feat/x',
]);

// ---------------------------------------------------------------- outils d'édition
test('Edit/Write dans le guide et le dossier de session → allow', () => {
  assert.equal(ed('C:\\g\\fig-x\\input\\fsh\\a.fsh', 'Edit'), 'allow');
  assert.equal(ed(`${SESSION}\\scratchpad\\handoff-x.md`), 'allow');
  // Fichiers protégés du guide : laissés aux règles Edit du profil.
  assert.equal(ed('C:\\g\\fig-x\\.gitlab-ci.yml', 'Edit'), 'allow');
});
test('Edit/Write hors du confinement → deny', () => {
  for (const p of [
    'C:\\g\\fig-y\\input\\fsh\\a.fsh',            // guide de référence ouvert par /add-dir
    'C:\\Users\\u\\.claude\\projects\\p\\memory\\x.md',
    'C:\\Users\\u\\AppData\\Local\\Temp\\x.txt',
    'C:\\temp\\x.txt',
    'C:\\Users\\u\\.fhir\\packages\\x\\package.json',
    `C:\\Users\\u\\.claude\\projects\\C--g-fig-x\\${SID}\\tool-results\\x.txt`,
  ]) assert.equal(ed(p), 'deny', p);
  assert.equal(ed('C:\\g\\fig-y\\x.ipynb', 'NotebookEdit'), 'deny');
});

test('outil non contrôlé → allow', () => {
  assert.equal(check({ ...BASE, tool_name: 'Read', tool_input: { file_path: 'C:\\autre' } }, ENV).decision, 'allow');
});
