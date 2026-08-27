Profile: EdshProcedure
Parent: Procedure
Id: edsh-procedure
Title: "Procedure"
Description: "Procedure adapted to Data Management"

* partOf ^short = "Acte englobant, quand cet acte en est une étape"
* partOf only Reference(Procedure or Observation or MedicationAdministration or EdshProcedure)
* subject ^short = "Patient ayant bénéficié de l'acte"
* subject only Reference(Patient or Group or EdshPatient)
* encounter ^short = "Passage au cours duquel l'acte est réalisé"
* encounter only Reference(Encounter or EdshEncounter)

* performer
  * actor ^short = "Intervenant ayant réalisé l'acte"
  * actor only Reference(Practitioner or PractitionerRole or Organization or Patient or RelatedPerson or Device or EdshPractitioner or EdshPractitionerRole or EdshOrganization)
  * onBehalfOf ^short = "Organisation pour le compte de laquelle l'intervenant a agi"
  * onBehalfOf only Reference(Organization or EdshOrganization)

* location ^short = "Lieu de réalisation de l'acte"
* location only Reference(Location or EdshLocation)
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
