Profile: EdshCondition
Parent: Condition
Id: edsh-condition
Title: "Condition"
Description: "Condition adapted to Data Management"

* subject only Reference(Patient or Group or FRCorePatientProfile or EdshPatient)
* encounter only Reference(Encounter or FRCoreEncounterProfile or EdshEncounter)
* recorder only Reference(Practitioner or PractitionerRole or Patient or RelatedPerson or FRCorePractitionerProfile or FRCorePractitionerRole or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshPatient)
* asserter only Reference(Practitioner or PractitionerRole or Patient or RelatedPerson or FRCorePractitionerProfile or FRCorePractitionerRole or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshPatient)

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
