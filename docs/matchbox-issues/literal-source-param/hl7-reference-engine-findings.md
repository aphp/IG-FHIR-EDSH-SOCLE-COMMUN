# Does the HL7 reference engine accept a literal `source` group parameter?

## Verdict

**No — the reference implementation (`org.hl7.fhir.core`'s `StructureMapUtilities`) does not
accept a literal-valued `source` parameter at a dependent-group call site either.** It has the
same restriction as Matchbox, just surfaced differently: the *parser* happily accepts the
grammar-legal literal (confirmed — this is not a syntax rejection), but the *runtime execution*
engine unconditionally treats every argument in a `then Group(arg1, arg2, ...)` invocation —
regardless of whether it was parsed as an identifier or as a string/numeric/boolean literal — as
the **name of a variable to look up** in the current rule's variable scope. A literal constant is
never itself bound as a value; it is used as a lookup key, that key is (almost always) not a
variable name that exists, and the lookup throws `FHIRException`.

This means **ticket #13's framing needs revision**: this is not "Matchbox is stricter than the
reference engine." The reference engine's own `executeDependency`/dependent-rule execution path
would throw on the same reproduction case for the same underlying reason (failed variable-name
lookup), which is presumably what surfaces as Matchbox's HTTP 500. The grammar-legality argument
(ticket #15's territory) still stands, but "the HL7 reference engine accepts this and Matchbox
doesn't" is not supported by the code.

## Primary evidence: runtime binding in `StructureMapUtilities` (R5)

Commit inspected: [`7e0c79dcae7c8c483e9ef67e118e48835ea4dcb9`](https://github.com/hapifhir/org.hl7.fhir.core/commit/7e0c79dcae7c8c483e9ef67e118e48835ea4dcb9)
(`hapifhir/org.hl7.fhir.core`, merge of PR #2561, dated 2026-08-26 — current `master` at time of
research).

File:
[`org.hl7.fhir.r5/src/main/java/org/hl7/fhir/r5/utils/structuremap/StructureMapUtilities.java`](https://github.com/hapifhir/org.hl7.fhir.core/blob/7e0c79dcae7c8c483e9ef67e118e48835ea4dcb9/org.hl7.fhir.r5/src/main/java/org/hl7/fhir/r5/utils/structuremap/StructureMapUtilities.java)

### The real execution entry point

`public void transform(...)` (line 1681) is the actual runtime transform method (as opposed to
the separate static-analysis/profiling machinery in `VariablesForProfiling`). It calls
`executeGroup` at line 1695, which recurses into `executeRule` (line 1737), which — when a rule
has a `then Group(...)` clause — calls `executeDependency` for each dependent
(line 1752-1755):

```java
} else if (rule.hasDependent()) {
  for (StructureMapGroupRuleDependentComponent dependent : rule.getDependent()) {
    executeDependency(indent + "  ", context, map, v, group, dependent);
  }
}
```

### `executeDependency` — the group-parameter binding logic

Lines 1775-1795
([permalink](https://github.com/hapifhir/org.hl7.fhir.core/blob/7e0c79dcae7c8c483e9ef67e118e48835ea4dcb9/org.hl7.fhir.r5/src/main/java/org/hl7/fhir/r5/utils/structuremap/StructureMapUtilities.java#L1775-L1795)):

```java
private void executeDependency(String indent, TransformContext context, StructureMap map, Variables vin, StructureMapGroupComponent group, StructureMapGroupRuleDependentComponent dependent) throws FHIRException {
    ResolvedGroup rg = resolveGroupReference(map, group, dependent.getName());

    if (rg.getTargetGroup().getInput().size() != dependent.getParameter().size()) {
      throw new FHIRException("Rule '" + dependent.getName() + "' has " + rg.getTargetGroup().getInput().size() + " but the invocation has " + dependent.getParameter().size() + " variables");
    }
    Variables v = new Variables();
    for (int i = 0; i < rg.getTargetGroup().getInput().size(); i++) {
      StructureMapGroupInputComponent input = rg.getTargetGroup().getInput().get(i);
      StructureMapGroupRuleTargetParameterComponent rdp = dependent.getParameter().get(i);
      String var = rdp.getValue().primitiveValue();
      VariableMode mode = input.getMode() == StructureMapInputMode.SOURCE ? VariableMode.INPUT : VariableMode.OUTPUT;
      Base vv = vin.get(mode, var);
      if (vv == null && mode == VariableMode.INPUT) //* once source, always source. but target can be treated as source at user convenient
        vv = vin.get(VariableMode.OUTPUT, var);
      if (vv == null)
        throw new FHIRException("Rule '" + dependent.getName() + "' " + mode.toString() + " variable '" + input.getName() + "' named as '" + var + "' has no value (vars = " + vin.summary() + ")");
      v.add(mode, input.getName(), vv);
    }
    executeGroup(indent + "  ", context, rg.getTargetMap(), v, rg.getTargetGroup(), false);
  }
```

Key point: `String var = rdp.getValue().primitiveValue();` — whatever the call-site argument's
parsed type (`IdType` for an identifier, `StringType`/`IntegerType`/etc. for a literal — see
below), its `primitiveValue()` string form is used **only as a variable name**, then looked up
with `vin.get(mode, var)` against the *current rule's* variable scope. There is no branch that
checks "is this argument a literal constant — if so, bind it directly as the parameter's value
instead of doing a variable lookup." Applied to the reproduction in issue #14/#13:

```
group Caller(source ans, target obs : Observation) {
  ans -> obs then Callee(ans, 'https://example.org/some-literal-string', obs) "call-callee";
}
group Callee(source ans, source configValue : string, target obs : Observation) { ... }
```

For the second call-site argument (`'https://example.org/some-literal-string'`, bound to
`Callee`'s `configValue` source parameter): `var` becomes the literal string
`"https://example.org/some-literal-string"`, and the engine looks for a variable of that exact
*name* in the caller's scope. No such variable exists (it's not a name anyone declared), the
`INPUT`→`OUTPUT` fallback also fails, and the method throws:

```
FHIRException("Rule 'Callee' INPUT variable 'configValue' named as 'https://example.org/some-literal-string' has no value (vars = ...)")
```

This is functionally the same failure mode as Matchbox's HTTP 500 — an unhandled exception from
group-parameter binding — not a case where the reference engine successfully binds the literal
and Matchbox alone chokes on it.

### The parser *does* accept a literal here — confirming this is a runtime gap, not a grammar gap

`parseParameter(StructureMapGroupRuleDependentComponent ref, FHIRLexer lexer)`, lines 1602-1610
([permalink](https://github.com/hapifhir/org.hl7.fhir.core/blob/7e0c79dcae7c8c483e9ef67e118e48835ea4dcb9/org.hl7.fhir.r5/src/main/java/org/hl7/fhir/r5/utils/structuremap/StructureMapUtilities.java#L1602-L1610)):

```java
private void parseParameter(StructureMapGroupRuleDependentComponent ref, FHIRLexer lexer) throws FHIRLexerException, FHIRFormatError {
    if (!lexer.isConstant()) {
      ref.addParameter().setValue(new IdType(lexer.take()));
    } else if (lexer.isStringConstant())
      ref.addParameter().setValue(new StringType(lexer.readConstant("??")));
    else {
      ref.addParameter().setValue(readConstant(lexer.take(), lexer));
    }
}
```

This confirms the parser has no problem with a literal string constant as a dependent-group
call-site argument — it stores it as a `StringType` rather than an `IdType`, exactly as the
grammar (`mapping.g4`) allows. The rejection happens strictly downstream, in
`executeDependency`'s variable-name lookup, which discards the type distinction entirely
(`rdp.getValue().primitiveValue()` — a plain string either way) and treats both `IdType` and
`StringType` values identically as lookup keys.

### R4's model is even more literal-hostile — same restriction, no type distinction at all

File:
[`org.hl7.fhir.r4/src/main/java/org/hl7/fhir/r4/utils/StructureMapUtilities.java`](https://github.com/hapifhir/org.hl7.fhir.core/blob/7e0c79dcae7c8c483e9ef67e118e48835ea4dcb9/org.hl7.fhir.r4/src/main/java/org/hl7/fhir/r4/utils/StructureMapUtilities.java#L1503-L1523)
(same commit), `executeDependency`, lines 1503-1523:

```java
private void executeDependency(String indent, TransformContext context, StructureMap map, Variables vin,
    StructureMapGroupComponent group, StructureMapGroupRuleDependentComponent dependent) throws FHIRException {
  ResolvedGroup rg = resolveGroupReference(map, group, dependent.getName());

  if (rg.target.getInput().size() != dependent.getVariable().size()) {
    throw new FHIRException("Rule '" + dependent.getName() + "' has " + Integer.toString(rg.target.getInput().size())
        + " but the invocation has " + Integer.toString(dependent.getVariable().size()) + " variables");
  }
  Variables v = new Variables();
  for (int i = 0; i < rg.target.getInput().size(); i++) {
    StructureMapGroupInputComponent input = rg.target.getInput().get(i);
    StringType rdp = dependent.getVariable().get(i);
    String var = rdp.asStringValue();
    VariableMode mode = input.getMode() == StructureMapInputMode.SOURCE ? VariableMode.INPUT : VariableMode.OUTPUT;
    Base vv = vin.get(mode, var);
    if (vv == null && mode == VariableMode.INPUT) // * once source, always source. but target can be treated as source
                                                  // at user convenient
      vv = vin.get(VariableMode.OUTPUT, var);
    if (vv == null)
      throw new FHIRException("Rule '" + dependent.getName() + "' " + mode.toString() + " variable '"
          + input.getName() + "' named as '" + var + "' has no value (vars = " + vin.summary() + ")");
```

In R4's `StructureMap` resource model, `StructureMapGroupRuleDependentComponent.getVariable()`
returns a plain `List<StringType>` — there is no `IdType`/`StringType` distinction at the model
level at all for dependent-rule parameters (unlike R5's richer
`StructureMapGroupRuleTargetParameterComponent`). Every dependent-call argument is *just a
string*, used *only* as a variable name. This is the same failure mode as R5, just with even less
room for a literal to ever be treated as anything but a lookup key.

## Test-suite check: no example of a literal argument to a dependent-group call

`org.hl7.fhir.core`'s own JUnit tests for `StructureMapUtilities`
(`org.hl7.fhir.r5/src/test/java/org/hl7/fhir/r5/test/StructureMapUtilitiesTest.java`) load their
FML fixtures from the external `FHIR/fhir-test-cases` repository
(`org.hl7.fhir.utilities/src/main/java/org/hl7/fhir/utilities/tests/BaseTestingUtilities.java`,
`loadTestResource`). I inspected every `.map` fixture under `r5/structure-mapping/` in
[`FHIR/fhir-test-cases`](https://github.com/FHIR/fhir-test-cases/tree/master/r5/structure-mapping)
that contains a `then` dependent-rule invocation. The only one with parameterized `then` calls is
`qr2pat-humannameshared.map`:

```
group entry(source src : QuestionnaireResponse, target tgt : Patient) {
  src.item as item then item(item, tgt);
}
group item(source src, target tgt) {
  src.item as item then item(item, tgt);
  src.item as item where linkId.value = 'patient.lastname' -> tgt.name as name share patientName then humanNameFamily(item, name);
  src.item as item where linkId.value = 'patient.firstname' -> tgt.name as name share patientName then humanNameGiven(item, name);
  ...
}
```

Every dependent-call argument here (`item`, `tgt`, `name`) is a variable reference, never a
literal. **No fixture in the reference implementation's own test suite passes a literal/constant
value to a dependent-group call parameter (source or target).** This is negative evidence — it
doesn't prove the engine would reject it (that's established directly by the code above), but it
confirms the pattern is untested and unsupported in practice, consistent with the code reading.

## Spec prose (secondary, for ticket #15's benefit)

`https://build.fhir.org/mapping-language.html` now redirects to
`https://build.fhir.org/ig/HL7/mapping-language-ig/fml.html`. Under that page's **"Dependent
Rules"** section, the spec prose states:

> "The parameters provided must match the parameters required by the dependent group, in order.
> In addition, the mode of the variable must match - inputs that are targets must be target
> variables."

The prose consistently refers to dependent-rule call-site arguments as **"variables"**, and does
not describe or carve out any literal/constant-argument case. This is consistent with (though
does not by itself prove) the runtime behavior found in the code: the spec's own mental model for
`then Group(...)` invocation is "pass variables," not "pass expressions." This is circumstantial
support, not a grammar-level statement — ticket #15 owns the grammar-legality question itself
(`mapping.g4` parses a literal here regardless of what the prose emphasizes).

## Summary for the bug report

- The grammar (`mapping.g4`) and the reference parser both accept a literal-valued `source`
  parameter at a `then Group(...)` call site — this part of the original ticket's premise holds.
- The reference engine's **runtime** group-invocation binding (`executeDependency`, both R4 and
  R5) does not special-case literals at all: every call-site argument is resolved purely as a
  variable-name lookup against the caller's current variable scope, so a literal argument almost
  always fails that lookup and throws `FHIRException`.
- This means the correct framing for the upstream Matchbox report is **not** "Matchbox is
  stricter than the HL7 reference implementation" — the reference implementation has the
  functionally same restriction, just expressed as a different exception/HTTP status. The
  Matchbox-specific angle (if any remains) would need to be about *how* Matchbox surfaces this
  failure (HTTP 500 / bind-time vs. execution-time) rather than about accepting/rejecting the
  literal itself.
- Recommend revisiting ticket #13's destination: either (a) reframe as a documentation/DX issue
  (Matchbox could give a clearer error, or reject earlier, or the workaround should be documented
  as the correct pattern rather than a bug to fix upstream), or (b) treat this as feedback for the
  HL7 FML spec/engine itself (org.hl7.fhir.core), not Matchbox specifically.
