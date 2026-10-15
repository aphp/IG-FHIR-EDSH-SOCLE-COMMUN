Profile: EdshCondition
Parent: Condition
Id: edsh-condition
Title: "Condition"
Description: "Condition adapted to Data Management"

* subject ^short = "Patient chez qui la condition est constatée"
* subject only Reference(Patient or Group or FRCorePatientProfile or EdshPatient)
* encounter ^short = "Venue au cours de laquelle la condition est documentée"
* encounter only Reference(Encounter or FRCoreEncounterProfile or EdshEncounter)
* recorder ^short = "Personne ayant enregistré la condition"
* recorder only Reference(Practitioner or PractitionerRole or Patient or RelatedPerson or FRCorePractitionerProfile or FRCorePractitionerRole or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshPatient)
* asserter ^short = "Personne ayant affirmé la condition"
* asserter only Reference(Practitioner or PractitionerRole or Patient or RelatedPerson or FRCorePractitionerProfile or FRCorePractitionerRole or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshPatient)

* code ^short = "Condition, codée en CIM-10"
* code from EdshCim10Vs (extensible)

Instance: d6e7f8a9-0b1c-2d3e-4f5a-6b7c8d9e0f1a
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshCondition)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: 12612c2e-ddb6-4e75-bd2a-b42da426e897
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshCondition)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"

Instance: 2531a5b2-68bc-460e-9a96-8ca084c0b08d
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshCondition)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"

Instance: 03d200b5-8aeb-40a1-b173-b414267a2559
InstanceOf: Provenance
Title: "Documentation des éléments (PR2, seconde revue)"
Description: """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
Usage: #definition

* target[0] = Reference(EdshCondition)
* occurredDateTime = "2026-10-14"
* reason.text = """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-14T16:00:00+02:00"
