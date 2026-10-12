Profile: EdshProcedure
Parent: Procedure
Id: edsh-procedure
Title: "Procedure"
Description: "Procedure adapted to Data Management"

* partOf only Reference(Procedure or Observation or MedicationAdministration or EdshProcedure or EdshMedicationAdministration)
* subject only Reference(Patient or Group or FRCorePatientProfile or EdshPatient)
* encounter only Reference(Encounter or FRCoreEncounterProfile or EdshEncounter)
* recorder only Reference(Patient or RelatedPerson or Practitioner or PractitionerRole or FRCorePatientProfile or FRCoreRelatedPersonProfile or FRCorePractitionerProfile or FRCorePractitionerRole or EdshPatient or EdshPractitioner or EdshPractitionerRole)
* asserter only Reference(Patient or RelatedPerson or Practitioner or PractitionerRole or FRCorePatientProfile or FRCoreRelatedPersonProfile or FRCorePractitionerProfile or FRCorePractitionerRole or EdshPatient or EdshPractitioner or EdshPractitionerRole)

* performer
  * actor only Reference(Practitioner or PractitionerRole or Organization or Patient or RelatedPerson or Device or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshOrganization or EdshPatient)
  * onBehalfOf only Reference(Organization or FRCoreOrganizationProfile or EdshOrganization)

* location only Reference(Location or FRCoreLocationProfile or EdshLocation)
* reasonReference only Reference(Condition or Observation or Procedure or DiagnosticReport or DocumentReference or EdshCondition or EdshProcedure)

* code from CcamVs (extensible)

Instance: e286e28b-c58b-4cc5-953d-8e6e7af22e56
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshProcedure)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: 7652720e-be40-4bf8-9c34-08813c49e5d9
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshProcedure)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"
