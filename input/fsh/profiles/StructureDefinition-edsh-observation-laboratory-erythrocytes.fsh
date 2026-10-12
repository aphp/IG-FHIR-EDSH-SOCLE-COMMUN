Profile: EdshObservationLaboratoryErythrocytes
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-erythrocytes
Title: "Erythrocytes"
Description: """
Profil Erythrocytes du socle commun des EDSH
"""

* code = $loinc#789-8 "Érythrocytes [Nombre/Volume] Sang ; Numérique ; Comptage automate" (exactly)

* value[x] ^short = "Erythrocytes — valeur mesurée, en 10*6/µL"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code = #10*6/uL (exactly)
* valueQuantity.unit = "10*6/uL"

Instance: de1f2303-d9a4-485b-80c3-94a12081776f
InstanceOf: Provenance
Title: "feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"
Description: """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryErythrocytes)
* occurredDateTime = "2025-10-14"
* reason.text = """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-10-14T16:58:23+02:00"

Instance: 9aad91b6-d933-4eab-8b6b-e1aeb5356484
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryErythrocytes)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
