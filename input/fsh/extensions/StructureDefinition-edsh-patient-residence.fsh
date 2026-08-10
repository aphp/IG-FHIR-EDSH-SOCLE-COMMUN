Extension: EdshPatientResidence
Id: edsh-patient-residence
Title: "Lieu de résidence du patient"
Description: "Cette extension permet de référencer le lieu de résidence du patient (Location) construit à partir des données de géolocalisation et d'IRIS."
* ^status = #draft
* ^context[0].type = #element
* ^context[=].expression = "Patient"
* . 0..1
* value[x] only Reference(EdshLocation)

Instance: c3f6b6d1-8f8a-4a6a-9a3e-9b6c6a4e2b3f
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshPatientResidence)
* occurredDateTime = "2026-08-10"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-08-10T00:00:00+01:00"
