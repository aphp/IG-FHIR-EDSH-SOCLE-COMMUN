Profile: EdshObservationLaboratoryBilirubineTotale
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-bilirubine-totale
Title: "Bilirubine totale"
Description: """
Taux de bilirubine sanguin. La bilirubine est un pigment jaune produit de la dégradation de l'hémoglobine, et d'autres hémoprotéines (cytochrome ou catalases).
"""

* code = $loinc#14631-6 "Bilirubine [Moles/Volume] Sérum/Plasma ; Numérique" (exactly)

* value[x] ^short = "Bilirubine totale — valeur mesurée, en µmol/L"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code = #umol/L (exactly)

Instance: 34ca9da4-4ca3-418a-aa45-9e001241d6e8
InstanceOf: Provenance
Title: "feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"
Description: """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryBilirubineTotale)
* occurredDateTime = "2025-10-14"
* reason.text = """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-10-14T16:58:23+02:00"

Instance: 4ea4c431-a590-46af-87e4-0d751bea2fd1
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryBilirubineTotale)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"

Instance: 6c755111-616e-4b25-9249-112cbaaa3e36
InstanceOf: Provenance
Title: "Unité d'affichage non fixée (PR3)"
Description: """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryBilirubineTotale)
* occurredDateTime = "2026-10-15"
* reason.text = """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-15T17:00:00+02:00"
