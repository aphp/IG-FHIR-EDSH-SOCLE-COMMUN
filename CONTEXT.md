# aphp.fhir.fr.edsh

Domain vocabulary for the FHIR Implementation Guide describing the socle commun of EDSH
data variables. See `CLAUDE.md` for repo structure and build commands; this file is a
glossary only.

## Language

**Simple lab profile**:
A lab analyte profile (child of `EdshObservationLaboratoryGeneric`) that fixes a single
`code` to one exact LOINC and carries its result directly on `Observation.value[x]`. Maps
1:1 from one `QuestionnaireResponse` item to one `Observation`. 20 of the 22 lab profiles
are this shape.
_Avoid_: "standard profile", "regular profile"

**Panel lab profile**:
A lab analyte profile whose top-level `code` identifies a panel (not a single result) and
which carries its actual results as sliced `component`s, each with its own fixed or
value-set-bound code. `EdshObservationLaboratoryFonctionRenale` (Créat + DFG components)
and `EdshObservationLaboratoryTca` (Patient/Témoin/Ratio components) are the only two
panel lab profiles; `Observation.value[x]` stays unpopulated at the top level. A panel
profile's components may be sourced from several sibling `QuestionnaireResponse` items
(fonction rénale) or may need a `QuestionnaireResponse` item structure that doesn't exist
yet (TCA — see the TCA panel decision tracked on the wayfinder map for
`StructureMap-Q2FSL.fml` lab-profile routing).
_Avoid_: "grouped profile", "composite profile"

**`Fr*` profile family**:
The datatype and medication modelling layer — `FrSimpleQuantityUcum`, `FrRangeUcum`,
`FrRatioUcum`, and `FrMedicationCompound` / `FrMedicationNonproprietaryName` /
`FrMedicationUcdPart` / `FrMedicationUcd` — adapted from the ANS e-prescription IG
(`ans.fhir.fr.eprescription`), not authored for the socle. Carries local Provenance
("first import") but tracks upstream conceptually. Its internal constraints (a UCUM
quantity mandating `system`/`code`; a compound `Medication` zeroing `batch` and
`ingredient.strength`) are part of the borrowed datatype definition, so socle-level
robustness remediation treats the family as a block, not element-by-element.
_Avoid_: calling these "socle profiles" or "EDSH profiles".

**PMSI structural invariant**:
A field the socle keeps mandatory on a PMSI-MCO profile (`EdshClaimRum` `subType`,
`diagnosis[dp]`, `modifier[MDE]` / `[MDS]`, the `ItemRank` extension) because PMSI data
reaches an EDS *after* ATIH grouping, where those fields are regulatorily obligatory — a
record lacking them is not a well-formed RUM. Distinguished from an *incidental*
over-constraint (a tightened cardinality with no domain rule behind it), which socle
remediation reverts to the FHIR base.
_Avoid_: "PMSI rule", "ATIH constraint" used loosely for both kinds.

**Core IG**:
What this guide is (ADR 0002): a base other IGs derive from, so the robustness
principle applies in full — no `Must Support`, `Reference` bounds widened not narrowed,
no cardinality tightened without a documented domain invariant. The obligation that an
EDS hold the socle items is documented, not encoded as `Must Support`; that belongs in a
deriving project IG.
_Avoid_: "socle IG" used to mean a project/conformance IG.
