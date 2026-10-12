Profile: EdshProcedure
Parent: Procedure
Id: edsh-procedure
Title: "Procedure"
Description: "Procedure adapted to Data Management"

* partOf ^short = "Acte englobant, quand cet acte en est une étape"
* partOf only Reference(Procedure or Observation or MedicationAdministration or EdshProcedure or EdshMedicationAdministration)
* subject ^short = "Patient ayant bénéficié de l'acte"
* subject only Reference(Patient or Group or FRCorePatientProfile or EdshPatient)
* encounter ^short = "Passage au cours duquel l'acte est réalisé"
* encounter only Reference(Encounter or FRCoreEncounterProfile or EdshEncounter)

* performer
  * actor ^short = "Intervenant ayant réalisé l'acte"
  * actor only Reference(Practitioner or PractitionerRole or Organization or Patient or RelatedPerson or Device or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshOrganization or EdshPatient)
  * onBehalfOf ^short = "Organisation pour le compte de laquelle l'intervenant a agi"
  * onBehalfOf only Reference(Organization or FRCoreOrganizationProfile or EdshOrganization)

* location ^short = "Lieu de réalisation de l'acte"
* location only Reference(Location or FRCoreLocationProfile or EdshLocation)
* recorder ^short = "Personne ayant enregistré l'acte"
* recorder only Reference(Patient or RelatedPerson or Practitioner or PractitionerRole or FRCorePatientProfile or FRCoreRelatedPersonProfile or FRCorePractitionerProfile or FRCorePractitionerRole or EdshPatient or EdshPractitioner or EdshPractitionerRole)
* asserter ^short = "Personne ayant rapporté l'acte"
* asserter only Reference(Patient or RelatedPerson or Practitioner or PractitionerRole or FRCorePatientProfile or FRCoreRelatedPersonProfile or FRCorePractitionerProfile or FRCorePractitionerRole or EdshPatient or EdshPractitioner or EdshPractitionerRole)
* reasonReference ^short = "Motif de l'acte, exprimé comme référence à une condition, un résultat ou un autre acte"
* reasonReference only Reference(Condition or Observation or Procedure or DiagnosticReport or DocumentReference or EdshCondition or EdshProcedure)

* code ^short = "Acte, codé en CCAM"
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

Instance: 0e858898-e6b8-4519-a3cf-7609b1302ef8
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshProcedure)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
