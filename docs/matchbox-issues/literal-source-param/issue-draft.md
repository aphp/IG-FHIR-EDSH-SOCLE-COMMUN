# Draft — ready to post to ahdis/matchbox

Resolves [Draft and finalize the ahdis/matchbox issue text](https://github.com/aphp/IG-FHIR-EDSH-SOCLE-COMMUN/issues/17), the last ticket on [Propose a Matchbox fix for literal source-parameter rejection](https://github.com/aphp/IG-FHIR-EDSH-SOCLE-COMMUN/issues/13).

Suggested labels: `enhancement`, `mapping`

---

## Title

```
FML: literal source-parameter binding fails at runtime (HTTP 500), not at parse
```

## Body

```markdown
## Summary

Calling a group with a literal value bound to a **`source`** parameter fails at
runtime with a generic HTTP 500, even when that parameter is never referenced
inside the callee's body. The FML grammar allows this (`groupParam : literal |
ID | fpExpression`, with no source/target distinction at the call site), and
the parser accepts it fine — the failure is specifically in the runtime
group-invocation binding.

## Repro

Two groups: `Caller` invokes `Callee` with a literal string bound to
`Callee`'s second parameter, `configValue`, which is never used in the body.

**Fails** — literal bound to a `source` parameter:

\`\`\`
group Caller(source src : SrcPatient, target tgt : TgtPatient) {
  src -> tgt then Callee(src, 'a literal string, never used by Callee', tgt) "call-callee";
}

// `configValue` is declared as a `source` parameter but bound to a literal string
// constant at the call site above, and is never referenced anywhere in this body.
group Callee(source src : SrcPatient, source configValue : string, target tgt : TgtPatient) {
  src.id as srcId -> tgt.id = srcId "copy-id";
}
\`\`\`

Against a trivial `Patient` instance (`{"resourceType":"Patient","id":"example","active":true}`),
`GET /api/matchbox/validate` returns:

\`\`\`
HTTP/1.1 500
Content-Type: text/plain;charset=UTF-8

Error during validation: Error during validation process inside method doValidation
\`\`\`

**Succeeds** — control, identical except the unused parameter is removed:

\`\`\`
group Caller(source src : SrcPatient, target tgt : TgtPatient) {
  src -> tgt then Callee(src, tgt) "call-callee";
}

group Callee(source src : SrcPatient, target tgt : TgtPatient) {
  src.id as srcId -> tgt.id = srcId "copy-id";
}
\`\`\`

Same instance, same engine state: `HTTP 200`, `Validation and transformation
are OK`. The only difference between the two files is the unused literal
`source` parameter — isolating it as the sole cause.

Tested against `matchbox-engine 4.1.13` (latest release as of 2026-08-26).

## Root cause (as far as I can tell from the embedded org.hl7.fhir.core)

This doesn't look like a Matchbox-specific check. In `org.hl7.fhir.core`
(both R4 and R5's `StructureMapUtilities`), the parser accepts a literal
`groupParam` without complaint — it's stored as a distinct `StringType`
rather than `IdType`. But `executeDependency`'s runtime binding discards
that distinction entirely: every call-site argument, literal or identifier
alike, is resolved with `rdp.getValue().primitiveValue()` and used purely
as a **variable-name lookup** against the caller's scope
(`vin.get(mode, var)`). A literal never matches an existing variable name,
so the lookup fails and throws. Since Matchbox embeds this library rather
than implementing its own group-binding logic, this looks like inherited
behavior rather than something Matchbox added on top.

Given that, two separate, more targeted asks:

1. **On Matchbox specifically**: fail earlier and more clearly. This binding
   mismatch is knowable from the group's declared signature at bind/compile
   time — bind-time seems like the right place to reject it, with a message
   naming the offending parameter, rather than a generic
   `Error during validation process inside method doValidation` surfacing at
   HTTP 500.
2. **Upstream, in `org.hl7.fhir.core`**: the actual fix — binding a literal
   `source` argument directly as a value instead of a lookup key — belongs
   in `executeDependency` there, since that's where the grammar/runtime gap
   actually lives. Not filing that separately yet since I wanted to raise it
   here first, but happy to if that's the right split.

## Why this matters

Without this, a shared group can't take a piece of call-site configuration
(a profile URL, a fixed code, ...) as a plain parameter — every workaround
I've found means building the group's *target* resource in the caller and
passing it in as a `target` override instead, so each call site can layer
its own trailing rules on top. It works, but it means duplicating the
target-construction boilerplate at every call site instead of just passing
a value in.

## Environment

- matchbox-engine 4.1.13 (via `aphp/fhir-mapbuilder`'s bundled backend)
```
