Profile: EdshObservationLaboratoryCreat
Parent: EdshObservationLaboratoryGeneric 
Id: edsh-observation-laboratory-creat
Title: "Fonction rénale"
Description: """
Profil créatininémie du socle commun des EDS
"""

* code = $loinc#14682-9 "Créatinine [Moles/Volume] Sérum/Plasma ; Numérique" (exactly)

* value[x] ^short = "Créatininémie — valeur mesurée, en µmol/L"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code = #umol/L (exactly)


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

Instance: e3f7053f-845b-4110-8970-f70f69962f38
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; forme des règles valueQuantity alignée sur les autres analytes (revue PR #28)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryCreat)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; forme des règles valueQuantity alignée sur les autres analytes (revue PR #28)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"

Instance: 3957a4ab-e1eb-4a8a-93d2-8b44f41fe59e
InstanceOf: Provenance
Title: "Unité d'affichage non fixée (PR3)"
Description: """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryCreat)
* occurredDateTime = "2026-10-15"
* reason.text = """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-15T17:00:00+02:00"
