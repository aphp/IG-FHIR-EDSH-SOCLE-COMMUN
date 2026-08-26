# Repro validation output — literal `source` group parameter

Resolves [Build and validate a minimal standalone repro of the literal source-parameter rejection](https://github.com/aphp/IG-FHIR-EDSH-SOCLE-COMMUN/issues/16), part of [Propose a Matchbox fix for literal source-parameter rejection](https://github.com/aphp/IG-FHIR-EDSH-SOCLE-COMMUN/issues/13).

## Setup

- Engine: `matchbox-engine 4.1.13` (ahdis/matchbox's latest release as of 2026-08-26), bundled in the local `aphp.fhir-mapbuilder` VS Code extension v1.6.0, driven via its REST API (`GET /api/matchbox/resetAndLoadEngine`, `GET /api/matchbox/validate`) — the same API surface `scripts/validate_with_mapbuilder.py` (from `fhir-skills:load-standards`) wraps.
- Package loaded into the engine: this repo's own `output/package.tgz` (built via `gradle buildIG`). Not actually required here — both `.fml` files below only reference the base FHIR `Patient` resource, no Logical Model or ConceptMap defined by any specific IG — but it was already built and on hand, so no need to fetch a smaller package.
- Sample instance: [`example-patient.json`](example-patient.json), a trivial `Patient`.

## Case 1 — [`repro-fails.fml`](repro-fails.fml): literal `source` parameter, unused

Two groups: `Caller` invokes `Callee` with a literal string bound to `Callee`'s second parameter, declared `source configValue : string` — a parameter never referenced anywhere in `Callee`'s body.

Request:

```
GET /api/matchbox/validate?source=<path>\repro-fails.fml&data=<path>\example-patient.json&output=fails-output
```

Response:

```
HTTP/1.1 500
Content-Type: text/plain;charset=UTF-8

Error during validation: Error during validation process inside method doValidation
```

Confirms the rejection at bind time, independent of AP-HP's `StructureMap-Q2FSL.fml` or any AP-HP-specific profile — this is the minimal two-group shape, against base `Patient` only.

## Case 2 — [`repro-fixed.fml`](repro-fixed.fml): control, same shape without the literal `source` parameter

Identical `Caller`/`Callee` pair, with the unused literal-valued `source` parameter simply removed from `Callee`'s declaration and the call site.

Request:

```
GET /api/matchbox/validate?source=<path>\repro-fixed.fml&data=<path>\example-patient.json&output=fixed-output
```

Response:

```
HTTP/1.1 200
Content-Type: text/plain;charset=UTF-8

Validation and transformation are OK
```

## Conclusion

The only difference between the two `.fml` files is the presence of the unused, literal-valued `source` parameter on `Callee`. Removing it is the sole change between a `500` and a clean `200` — isolating the literal `source` argument itself, not anything else about the two-group call shape, as the cause. This corroborates [Does the HL7 reference engine accept a literal source group parameter?](https://github.com/aphp/IG-FHIR-EDSH-SOCLE-COMMUN/issues/14) (the HL7 reference implementation has the same restriction, for the same reason — its group-call binding logic resolves every argument as a variable-name lookup) and [Cite the mapping.g4 grammar production allowing a literal-valued source parameter](https://github.com/aphp/IG-FHIR-EDSH-SOCLE-COMMUN/issues/15) (the grammar itself places no such restriction on a `source` parameter's call-site argument).
