Profile: EdshObservationLaboratoryDfg
Parent: EdshObservationLaboratoryGeneric 
Id: edsh-observation-laboratory-dfg
Title: "Débit de filtration glomérulaire estimé"
Description: """
Profil Débit de filtration glomérulaire estimé du socle commun des EDS
"""

* code from EdshLaboratoryEstimatedDfg (required)

* value[x] ^short = "Débit de filtration glomérulaire estimé — valeur mesurée"
* value[x] only Quantity
* valueQuantity ^short = "Valeur mesurée"
* valueQuantity
  * system = $ucum (exactly)
  * code from EdshLaboratoryEstimatedDfgUnit (extensible)


Instance: f847f299-16aa-45c3-bd87-563d4e70fced
InstanceOf: Provenance
Title: "Séparation du profil fonction rénale en deux profils, un pour la créatininémie, un pour le débit de filtration glomérulaire"
Description: """Séparation du profil fonction rénale en deux profils, un pour la créatininémie, un pour le débit de filtration glomérulaire"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryDfg)
* occurredDateTime = "2026-08-26"
* reason.text = """La structuration actuelle du Questionnaire UsageCore ne permet pas de réconcilier les créat et les dfg."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "Nicolas Griffon"
* recorded = "2026-08-26T15:20:00+02:00"

Instance: 5958c7ef-cd8b-422d-965d-8a2524b55c08
InstanceOf: Provenance
Title: "Relax Creat/Dfg component cardinalities to 0..1"
Description: """Relax Creat/Dfg component cardinalities to 0..1"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryDfg)
* occurredDateTime = "2026-08-26"
* reason.text = """Les 10 vignettes réelles montrent que le DFG n'accompagne la créatininémie que dans 1 cas sur 6 non vides (et peut être mesuré plusieurs fois sans DFG associé) : la cardinalité 1..1/1..1 des deux components empêchait Q2FSL de produire une Observation fonction-rénale conforme dès que l'un des deux résultats manquait ou était répété. Relâchée en 0..1/0..1 (élargissement, conforme au principe de robustesse) pour permettre un panel à un seul component quand l'autre résultat est absent, sans perdre de données."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-08-26T06:36:15+02:00"

Instance: 02323e68-3c00-4304-88a8-3b9ffdc1f8ec
InstanceOf: Provenance
Title: "WIP adding EDSH vars"
Description: """WIP adding EDSH vars"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryDfg)
* occurredDateTime = "2025-03-24"
* reason.text = """WIP adding EDSH vars"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-03-24T09:26:15+01:00"