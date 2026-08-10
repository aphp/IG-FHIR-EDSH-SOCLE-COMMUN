Instance: edsh-practitioner-example
InstanceOf: EdshPractitioner
Description: "Exemple de EdshPractitioner"

* identifier
  * type = $fr-core-cs-v2-0203#RPPS
  * system = "https://rpps.esante.gouv.fr"
  * value = "10001234567"
* name.family = "Quenum"
* name.given[0] = "Martin"
* gender = #male

Instance: 7a6f8e2c-9b3d-4c1a-8e5f-2d9c6b4a1e7f
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(edsh-practitioner-example)
* occurredDateTime = "2026-08-10"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-08-10T00:00:00+01:00"
