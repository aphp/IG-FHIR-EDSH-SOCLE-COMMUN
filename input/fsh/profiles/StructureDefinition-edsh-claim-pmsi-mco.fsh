Profile: EdshClaimPmsiMco
Parent: EdshClaimPmsi
Id: edsh-claim-pmsi-mco
Title: "Profil de Claim pour le champ MCO du PMSI"
Description: "Profil abstrait pour les invariants dans les claims du champs MCO du PMSI."

* ^abstract = true

* type = FrClaimType#PMSIMCO
* subType ^short = "Sous-type de résumé MCO (RUM, RSS…)"
* subType from FrMcoClaimSubType (required)

Instance: ec3b0504-7d75-4601-87b1-b9143672cbf0
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshClaimPmsiMco)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: fb138a5a-ce94-4a61-b03c-ab8370a09d73
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; suppression du ^short de type, déjà hérité de EdshClaimPmsi (revue PR #28)."""
Usage: #definition

* target[0] = Reference(EdshClaimPmsiMco)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; suppression du ^short de type, déjà hérité de EdshClaimPmsi (revue PR #28)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
