# Grammar citation: is a literal-valued `source` parameter argument legal?

## Verdict

**Yes.** Per the current, actively-maintained ANTLR grammar for the FHIR Mapping Language
(`mapping.g4`), a group-invocation argument bound to a `source` parameter is **not**
grammar-restricted to a navigable/resolvable path. The call-site argument list
(`groupParamList` / `groupParam`) accepts a bare `literal` (string, number, boolean,
date, quantity, etc.) in any parameter position, with no distinction in the
context-free grammar between positions bound to `source`-mode versus `target`-mode
declared parameters. That distinction (`source` vs `target`) exists only in the
*declaration* grammar (`parameter : parameterMode ID typeIdentifier?`); it plays no part
in the *call-site* grammar (`groupInvocation`/`groupParamList`/`groupParam`), which is
purely positional and mode-agnostic.

The companion prose in the spec's `fml.md` corroborates this by omission: it states a
mode-matching rule for **target** arguments only ("inputs that are targets must be target
variables") and says nothing constraining what a `source` argument may be — consistent
with the grammar allowing an arbitrary literal there.

## Primary source

**Repository**: [`HL7/mapping-language-ig`](https://github.com/HL7/mapping-language-ig) —
the dedicated, actively-maintained IG repository for the FHIR Mapping Language
specification, published at
[`build.fhir.org/ig/HL7/mapping-language-ig/fml.html`](https://build.fhir.org/ig/HL7/mapping-language-ig/fml.html)
(the page `build.fhir.org/mapping-language.html` now redirects here: *"The FHIR Mapping
Language has been moved to the Mapping Language Implementation Guide"*). Commit history
shows ongoing R6-cycle grammar maintenance through June 2026 (e.g. `FHIR-57524 FML grammar
doesn't support 'evaluate' fhirpath parameter`, `FHIR-54477 Simple Identity transform`),
confirming this is the live, currently-maintained copy rather than a stale mirror.

Pinned commit: [`b7d096625194021c237fdcc7bbca2d983351b279`](https://github.com/HL7/mapping-language-ig/commit/b7d096625194021c237fdcc7bbca2d983351b279)
(2026-06-09, Brian Postlethwaite, `FHIR-54477 Simple Identity transform - no FML grammar
support`) — the most recent commit touching `input/images/mapping.g4` as of this writing,
and identical to the repository's `main`-branch tip copy of the file (verified by diff).

A second, older copy of the same file lives in the base spec repo,
[`HL7/fhir`](https://github.com/HL7/fhir) at `images/mapping.g4`, pinned at commit
[`db673c36e89512edf663e0675ab12bbdbb80704e`](https://github.com/HL7/fhir/commit/db673c36e89512edf663e0675ab12bbdbb80704e)
(2025-11-07). `HL7/fhir`'s `publish.ini` now comments this asset out
(`;mapping.g4 =`), consistent with the content having moved to the dedicated IG repo above.
The two copies are **identical** on every production cited below (`parameters`,
`parameter`, `parameterMode`, `groupInvocation`, `groupParamList`) — they diverge only on
unrelated, newer additions (`evaluate`-transform support, batch-identity copy rules,
delimited identifiers, `share`'s list-rule id) that don't touch call-argument or
parameter-mode grammar. This citation uses the newer `mapping-language-ig` copy as
primary and notes the older copy as corroboration.

Note on engine implementation: HAPI's `org.hl7.fhir.core` (which Matchbox embeds) does
**not** generate its parser from this `.g4` file — it hand-implements a recursive-descent
FML parser (`FmlParser.java` / `StructureMapUtilities.java`) that is expected to conform
to this grammar, not literally generated from it. That's a separate question (ticket #14
territory: does the *implementation* conform to the *grammar*); this ticket only concerns
what the grammar itself permits.

## Grammar productions

### 1. Parameter *declaration* — where `source`/`target` mode is attached

The mode keyword is part of declaring a group's formal parameter, not part of supplying
an argument at a call site:

[`input/images/mapping.g4#L82-L88`](https://github.com/HL7/mapping-language-ig/blob/b7d096625194021c237fdcc7bbca2d983351b279/input/images/mapping.g4#L82-L88)

```antlr
parameters
  : '(' parameter (',' parameter)+ ')'
  ;

parameter
  : parameterMode ID typeIdentifier?
  ;
```

[`input/images/mapping.g4#L293-L295`](https://github.com/HL7/mapping-language-ig/blob/b7d096625194021c237fdcc7bbca2d983351b279/input/images/mapping.g4#L293-L295)

```antlr
parameterMode
    : 'source' | 'target'
    ;
```

(Identical in the older copy: [`images/mapping.g4#L86-L88`](https://github.com/HL7/fhir/blob/db673c36e89512edf663e0675ab12bbdbb80704e/images/mapping.g4#L86-L88) and
[`#L284-L286`](https://github.com/HL7/fhir/blob/db673c36e89512edf663e0675ab12bbdbb80704e/images/mapping.g4#L284-L286).)

### 2. Group invocation — how a call site supplies arguments

This is the rule that governs `Callee(ans, 'https://example.org/some-literal-string',
obs)`-style calls. Crucially, `groupParam` offers `literal` as a first-class alternative,
on equal footing with `ID` (a variable reference), for **every** argument position —
there is no separate, more restrictive production for arguments landing in a `source`
parameter slot:

[`input/images/mapping.g4#L201-L213`](https://github.com/HL7/mapping-language-ig/blob/b7d096625194021c237fdcc7bbca2d983351b279/input/images/mapping.g4#L201-L213)

```antlr
groupInvocation
  : identifier '(' groupParamList? ')'
  ;

groupParamList
  : groupParam (',' groupParam)*
  ;

groupParam
  : literal
  | ID
  | fpExpression   // this is to support the `evaluate` transform, parser validation/visitor should check that this is only used there.
  ;
```

The older `HL7/fhir` copy has the same `groupInvocation`/`groupParamList`/`groupParam`
shape minus the newer `fpExpression` alternative (added for the unrelated `evaluate`
transform), confirming `literal` has been legal here throughout:
[`images/mapping.g4#L196-L207`](https://github.com/HL7/fhir/blob/db673c36e89512edf663e0675ab12bbdbb80704e/images/mapping.g4#L196-L207)

```antlr
groupInvocation
  : identifier '(' groupParamList? ')'
  ;

groupParamList
  : groupParam (',' groupParam)*
  ;

groupParam
  : literal
  | ID
  ;
```

`literal` itself covers string, boolean, numeric, date/time, and quantity constants (not
reproduced in full here — see `mapping.g4`'s `literal` rule), so the reproduction's
`'https://example.org/some-literal-string'` argument is an ordinary `stringLiteral`
alternative of `literal`, and therefore a syntactically valid `groupParam`.

### 3. No grammar-level link between call-site argument and callee parameter mode

Nothing in `groupInvocation`/`groupParamList`/`groupParam` looks up or is parameterized
by the callee group's declared `parameterMode` for the corresponding position. The
context-free grammar cannot express "this argument binds to a `source` parameter, so it
must be a resolvable path" — that would require a semantic (not syntactic) check, applied
after parsing, against the resolved group signature. No such semantic constraint is
documented for `source` parameters (see prose cross-check below).

## Spec prose cross-check

[`input/pagecontent/fml.md#L836-L838`](https://github.com/HL7/mapping-language-ig/blob/b7d096625194021c237fdcc7bbca2d983351b279/input/pagecontent/fml.md#L836-L838)
(section: *Dependent Rules*):

> The parameters provided must match the parameters required by the dependent group, in
> order. In addition, the mode of the variable must match - inputs that are targets must
> be target variables. Note, though, that target variables can be treated as source for a
> group.

This is the only prose statement of a call-site matching rule, and it is scoped
specifically to **target** arguments ("inputs that are targets must be target
variables"). It says nothing requiring a `source` argument to be a "source variable" or a
navigable path — and separately confirms the language's general looseness on the source
side by noting target variables may themselves be passed where a source is expected.

[`input/pagecontent/fml.md#L278`](https://github.com/HL7/mapping-language-ig/blob/b7d096625194021c237fdcc7bbca2d983351b279/input/pagecontent/fml.md#L278)
(section describing group parameter declarations):

> All input variables have a mode, which may be one of source or target (see above).

This confirms `source`/`target` mode is a property of the group's *declared* parameter
list — matching the `parameterMode` production above — not a property enforced on the
call-site argument expression's own grammar.

## Conclusion

Grammar and prose agree: a `source` parameter's call-site argument is not restricted to a
navigable/resolvable expression. `groupParam : literal | ID | fpExpression` makes a
literal syntactically legal in any call-site argument position, source or target alike;
only `target` arguments carry a documented (semantic, not grammatical) restriction to
"target variables." Matchbox rejecting a literal-valued `source` parameter argument at
bind time is therefore not required, and does not appear to be justified, by the FML
grammar.
