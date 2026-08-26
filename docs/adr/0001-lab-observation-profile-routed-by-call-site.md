# Route each lab Observation's profile and code by FML call site, not by dynamic LOINC lookup

`StructureMap-Q2FSL.fml`'s `CreateLabObservation` group currently reads the LOINC code
dynamically from each `QuestionnaireResponse` item's "code loinc" sub-item and hardcodes
`obs.meta.profile` to the abstract `edsh-observation-laboratory-generic`, so every
generated Observation ends up on the generic profile regardless of analyte. We're fixing
this by having each of `CreateLaboratoryObservations`'s 22 call sites pass its target
[[simple-lab-profile|simple lab profile]]'s canonical URL and fixed LOINC code as explicit
parameters into a now-parameterized `CreateLabObservation`, rather than inferring the
profile from the QR's own LOINC text at runtime. The [[panel-lab-profile|panel lab
profile]] case (fonction rénale: Créat + DFG combined into one Observation with two
components) gets its own dedicated FML group instead, since its shape — two sibling QR
items feeding one target Observation — doesn't fit the 1:1 `CreateLabObservation` contract
at all. The DFG component's code stays dynamically read from the QR, since its profile
binds a value set (`EdshLaboratoryEstimatedDfg`) rather than fixing one exact code — the
routing principle is "hardcode where the profile fixes an exact code, keep it dynamic
where the profile only binds a value set."

## Considered Options

- **Dynamic lookup table** (LOINC code → profile URL, resolved inside the shared group):
  keeps call sites untouched, but adds an indirection that must be kept in sync with the
  22 profiles by hand, and doesn't help with the panel case's different arity anyway.
- **20+ fully separate per-analyte groups**: maximally explicit, but duplicates the entire
  Observation-building logic (id, category, subject, effective, referenceRange) 20+ times
  for no structural difference between the simple cases.
- **Parameterize the existing shared group** (chosen): each call site states its own
  profile/code explicitly, matching what the profile already asserts; the shared group
  keeps owning everything structurally identical across the simple cases.
