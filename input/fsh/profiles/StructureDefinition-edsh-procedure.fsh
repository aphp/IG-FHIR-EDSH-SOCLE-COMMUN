Profile: EdshProcedure
Parent: Procedure
Id: edsh-procedure
Title: "Procedure"
Description: "Procedure adapted to Data Management"

* partOf only Reference(Procedure or Observation or MedicationAdministration or EdshProcedure)
* subject only Reference(Patient or Group or EdshPatient)
* encounter only Reference(Encounter or EdshEncounter)

* performer
  * actor only Reference(Practitioner or PractitionerRole or Organization or Patient or RelatedPerson or Device or EdshPractitioner or EdshPractitionerRole or EdshOrganization)
  * onBehalfOf only Reference(Organization or EdshOrganization)

* location only Reference(Location or EdshLocation)
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
