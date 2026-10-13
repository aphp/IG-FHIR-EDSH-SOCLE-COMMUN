# `aphp.fhir.fr.edsh` is a Core IG: the robustness principle applies in full

The AP-HP conventions distinguish **Core IGs** (a base other IGs derive from, constraining
only what is true of the data everywhere) from **project IGs** (a specification of what one
system must exchange or store for one use case). The two have opposite rules on
`Must Support`, `Reference` bounds and cardinalities, and nothing in `sushi-config.yaml`
said which one this guide is. We decide it is a **Core IG**: it models the socle commun
shared by every French hospital EDS, and it is consumed as a base by downstream IGs
(`IG-fhir-dm` depends on `aphp.fhir.fr.edsh: dev`) that add their own use-case
constraints. Consequently, every profile follows the robustness principle: **no
`Must Support`**, **`Reference` bounds widened, never narrowed** (parent-allowed targets,
then the FR Core profile when one exists, then the Edsh profile), and **no cardinality
tightened** unless it encodes a domain invariant that holds for every conformant instance
— in which case it is kept and justified with a `^comment` (today: the
[[pmsi-structural-invariant|PMSI structural invariants]] of `EdshClaimRum`, slicing
discriminators such as `item[*].category`, lab `category`, the 3 TCA components, and the
[[fr-profile-family|`Fr*` family]] as a borrowed block).

The obligation that every EDSH hold the 51 socle items is real, but it is a *conformance
requirement on systems*, not a property of the data. It is expressed by the guide's
documentation and by `Questionnaire/UsageCore`; a project IG (an EDS-specific or
exchange-specific IG deriving from these profiles) is where `Must Support` and narrower
references belong.

This decision lifts **Gate 0** of the robustness remediation (map #19), which #27 (PR1),
#28 (PR2) and #29 (PR3) execute. Lot 2 profiles (`edsh-observation-*-status`) still carry
`Must Support` and narrowed references; they are deferred, not exempt, and will be
brought in line when Lot 2 is formalised.

## Considered Options

- **Project IG**: keep `Must Support` to express "an EDS must handle this element" and
  keep references narrowed to Edsh profiles. Rejected: it would force every downstream
  IG to inherit EDS-specific obligations and would prevent it from accepting plain FR Core
  or R4 resources; it also conflicts with the guide's role as a base for `IG-fhir-dm`.
- **Core IG with a separate conformance layer now**: split the socle into Core profiles
  plus a project IG carrying the `Must Support` flags. Not needed yet: nothing currently
  consumes such a layer, so it is left for when a concrete use case asks for it.
- **Core IG** (chosen): constraints limited to domain invariants, everything else left
  open, obligations documented rather than encoded as `Must Support`.

## Consequences

- New profiles must be created and reviewed against the Core rules
  (`fhir-skills:create-profile`, `fhir-skills:analyze-compliance` with the IG type set to
  Core).
- Removing a constraint from a Core profile is non-breaking for producers but may be
  breaking for consumers that relied on it; changes are recorded in `changelog.md` and in
  per-artifact Provenance (see #32 for the versioning policy).
