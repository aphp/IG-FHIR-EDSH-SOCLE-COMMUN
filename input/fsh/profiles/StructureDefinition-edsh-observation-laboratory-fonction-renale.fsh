Profile: EdshObservationLaboratoryFonctionRenale
Parent: EdshObservationLaboratoryGeneric 
Id: edsh-observation-laboratory-fonction-renale
Title: "Fonction rénale"
Description: """
Profil des résultats de fonction rénale du socle commun des EDS
"""

* code = $loinc#45066-8 (exactly)

* component ^slicing.discriminator[0].type = #value
* component ^slicing.discriminator[=].path = "code"
* component ^slicing.rules = #open
* component ^short = "Permet de rapporter la créatininémie et l'estimation du DFG."
* component contains
    Creat 0..1 MS and
    Dfg 0..1 MS


* component[Creat] ^short = "Créatininémie"
* component[Creat]
  * code = $loinc#14682-9 (exactly)
  * value[x] only Quantity
  * valueQuantity ^short = "Valeur mesurée"
  * valueQuantity
    * system = $ucum (exactly)
    * code = #umol/L (exactly)
    * unit = "umol/L"
  * referenceRange 1..
  * referenceRange MS

* component[Dfg] ^short = "Débit de filtration glomérulaire estimé"
* component[Dfg]
  * code from EdshLaboratoryEstimatedDfg (required)
  * value[x] only Quantity
  * valueQuantity ^short = "Valeur mesurée"
  * valueQuantity
    * system = $ucum (exactly)
    * code from EdshLaboratoryEstimatedDfgUnit (extensible)
  * referenceRange 1..
  * referenceRange MS

Instance: 5958c7ef-cd8b-422d-965d-8a2524b55c08
InstanceOf: Provenance
Title: "Relax Creat/Dfg component cardinalities to 0..1"
Description: """Relax Creat/Dfg component cardinalities to 0..1"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryFonctionRenale)
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

* target[0] = Reference(EdshObservationLaboratoryFonctionRenale)
* occurredDateTime = "2025-03-24"
* reason.text = """WIP adding EDSH vars"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-03-24T09:26:15+01:00"