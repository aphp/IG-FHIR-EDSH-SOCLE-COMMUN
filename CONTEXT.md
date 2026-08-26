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
