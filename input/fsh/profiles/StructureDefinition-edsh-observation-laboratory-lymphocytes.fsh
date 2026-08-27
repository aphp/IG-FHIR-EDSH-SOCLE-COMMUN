Profile: EdshObservationLaboratoryLymphocytes
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-lymphocytes
Title: "Lymphocytes"
Description: """
Profil Lymphocytes du socle commun des EDSH
"""

* code = $loinc#26474-7 "Lymphocytes totaux [Nombre/Volume] Sang ; Numérique" (exactly)

* value[x] ^short = "Lymphocytes — valeur mesurée, en 10*3/uL"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code = #10*3/uL (exactly)
* valueQuantity.unit = "10*3/uL"

Instance: ba1bd471-ffb6-444a-b983-4f97660568b5
InstanceOf: Provenance
Title: "feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"
Description: """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryLymphocytes)
* occurredDateTime = "2025-10-14"
* reason.text = """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-10-14T16:58:23+02:00"
