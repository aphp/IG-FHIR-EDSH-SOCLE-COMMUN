Profile: EdshCondition
Parent: Condition
Id: edsh-condition
Title: "Condition"
Description: "Condition adapted to Data Management"

* subject ^short = "Patient chez qui la condition est constatée"
* subject only Reference(Patient or Group or EdshPatient)
* encounter ^short = "Passage au cours duquel la condition est documentée"
* encounter only Reference(Encounter or EdshEncounter)

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

