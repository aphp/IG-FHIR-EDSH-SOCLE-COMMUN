Profile: EdshObservationLaboratoryUremie
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-uremie
Title: "Urée"
Description: """
Taux d'urée dans le sang. L'urée est un catabolite composé formé dans le foie à partir de l'ammoniac produit par la désamination des acides aminés. C'est le principal produit final du catabolisme des protéines et il constitue environ la moitié des solides urinaires totaux.
"""

* code = $loinc#22664-7 "Urée [Moles/Volume] Sérum/Plasma ; Numérique" (exactly)

* value[x] ^short = "Urée — valeur mesurée, en mmol/L"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code = #mmol/L (exactly)

Instance: a9b0c1d2-3e4f-5a6b-7c8d-9e0f1a2b3c4d
InstanceOf: Provenance
Title: "fixing QA assessment"
Description: """fixing QA assessment"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryUremie)
* occurredDateTime = "2025-03-27"
* reason.text = """fixing QA assessment"""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-03-27T18:20:06+01:00"

Instance: e2f3a4b5-6c7d-8e9f-0a1b-2c3d4e5f6a7b
InstanceOf: Provenance
Title: "WIP adding EDSH vars"
Description: """WIP adding EDSH vars"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryUremie)
* occurredDateTime = "2025-03-24"
* reason.text = """WIP adding EDSH vars"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-03-24T09:26:15+01:00"

Instance: 53770929-27c9-4598-9099-42740edea9fc
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core) ; retour à la cardinalité de base de referenceRange (#22)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryUremie)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core) ; retour à la cardinalité de base de referenceRange (#22)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"

Instance: 1be117cd-22e8-484c-a5e4-c6484956a02d
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryUremie)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"

Instance: 390de5d5-6eaa-496d-b7da-e3b861149976
InstanceOf: Provenance
Title: "Unité d'affichage non fixée (PR3)"
Description: """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryUremie)
* occurredDateTime = "2026-10-15"
* reason.text = """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-15T17:00:00+02:00"
