ValueSet: EdshCim10Vs
Id: edsh-cim10-vs
Title: "Liste des diagnostiques CIM-10 pour le PMSI"
Description: "ValueSet reprenant la CIM 10 ATIH"
* ^experimental = false
* ^immutable = false

* include codes from system EdshCim10Cs

Instance: 474fb0a5-93fb-4770-a8fa-082a34c1efa3
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshCim10Vs)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"