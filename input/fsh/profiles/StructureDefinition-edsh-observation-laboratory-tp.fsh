Profile: EdshObservationLaboratoryTp
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-tp
Title: "Taux prothrombine (TP)"
Description: """
Profil Taux prothrombine (TP) du socle commun des EDSH
"""

* code = $loinc#5894-1 "Temps de quick Patient (%) [Temps relatif] Plasma pauvre en plaquettes ; Numérique ; Coagulation" (exactly)

* value[x] ^short = "Taux prothrombine (TP) — valeur mesurée, en %"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code = #% (exactly)
* valueQuantity.unit = "%"

Instance: 8f3edd54-5bca-4003-b07f-c665d6d0b788
InstanceOf: Provenance
Title: "feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"
Description: """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryTp)
* occurredDateTime = "2025-10-14"
* reason.text = """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-10-14T16:58:23+02:00"
