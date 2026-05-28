Profile: EdshProcedure
Parent: Procedure
Id: edsh-procedure
Title: "Procedure"
Description: "Procedure adapted to Data Management"

* partOf only Reference(EdshProcedure)
* subject only Reference(EdshPatient)
* encounter only Reference(EdshEncounter)

* performer
  * actor only Reference(EdshPractitioner or EdshPractitionerRole or EdshOrganization)
  * onBehalfOf only Reference(EdshOrganization)

* location only Reference(EdshLocation)
* reasonReference only Reference(EdshCondition or Observation or EdshProcedure)

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
