Profile: EdshObservationLaboratoryCreat
Parent: EdshObservationLaboratoryGeneric 
Id: edsh-observation-laboratory-creat
Title: "Fonction rénale"
Description: """
Profil créatininémie du socle commun des EDS
"""

* code = $loinc#14682-9 "Créatinine [Moles/Volume] Sérum/Plasma ; Numérique" (exactly)

* value[x] only Quantity
* valueQuantity ^short = "Valeur mesurée"
* valueQuantity
  * system = $ucum (exactly)
  * code = #umol/L (exactly)
  * unit = "umol/L"


Instance: 31e47753-0b65-47ac-a51c-9bd219378094
InstanceOf: Provenance
Title: "Séparation du profil fonction rénale en deux profils, un pour la créatininémie, un pour le débit de filtration glomérulaire"
Description: """Séparation du profil fonction rénale en deux profils, un pour la créatininémie, un pour le débit de filtration glomérulaire"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryCreat)
* occurredDateTime = "2026-08-26"
* reason.text = """La structuration actuelle du Questionnaire UsageCore ne permet pas de réconcilier les créat et les dfg."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "Nicolas Griffon"
* recorded = "2026-08-26T15:17:00+02:00"

Instance: 8615ed6d-73a5-4168-a470-c6d3e38aa31c
InstanceOf: Provenance
Title: "Relax Creat/Dfg component cardinalities to 0..1"
Description: """Relax Creat/Dfg component cardinalities to 0..1"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryCreat)
* occurredDateTime = "2026-08-26"
* reason.text = """Les 10 vignettes réelles montrent que le DFG n'accompagne la créatininémie que dans 1 cas sur 6 non vides (et peut être mesuré plusieurs fois sans DFG associé) : la cardinalité 1..1/1..1 des deux components empêchait Q2FSL de produire une Observation fonction-rénale conforme dès que l'un des deux résultats manquait ou était répété. Relâchée en 0..1/0..1 (élargissement, conforme au principe de robustesse) pour permettre un panel à un seul component quand l'autre résultat est absent, sans perdre de données."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-08-26T06:36:15+02:00"

Instance: 612d840b-0c27-4f63-9af1-abbb03ee03fb
InstanceOf: Provenance
Title: "WIP adding EDSH vars"
Description: """WIP adding EDSH vars"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryCreat)
* occurredDateTime = "2025-03-24"
* reason.text = """WIP adding EDSH vars"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-03-24T09:26:15+01:00"