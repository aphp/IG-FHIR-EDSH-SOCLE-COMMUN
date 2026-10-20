Profile: EdshObservationLaboratoryPlaquettes
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-plaquettes
Title: "Plaquettes"
Description: """
Profil Plaquettes du socle commun des EDSH
"""

* code = $loinc#777-3 "Plaquettes [Nombre/Volume] Sang ; Numérique ; Comptage automate" (exactly)

* value[x] ^short = "Plaquettes — valeur mesurée, en 10^3/µL"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code ^comment = "Code UCUM 10*3/uL ou sa notation équivalente 10^3/uL (invariant dm-lab-unit-10e3-ul). Dans une même ressource, la valeur et les bornes de referenceRange utilisent la même notation (dm-lab-3) ; un consommateur doit traiter les deux comme une même unité."
* obeys dm-lab-unit-10e3-ul

Instance: c7ac6c79-d3ea-4e80-8859-2217c044b3ec
InstanceOf: Provenance
Title: "feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"
Description: """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryPlaquettes)
* occurredDateTime = "2025-10-14"
* reason.text = """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-10-14T16:58:23+02:00"

Instance: b7411a5f-c8ad-4da6-85e4-f04cb265f6df
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryPlaquettes)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"

Instance: fbbaf5f8-2bfb-4da9-9cd1-6d3646d24304
InstanceOf: Provenance
Title: "Documentation des éléments (PR2, seconde revue)"
Description: """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryPlaquettes)
* occurredDateTime = "2026-10-14"
* reason.text = """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-14T16:00:00+02:00"

Instance: 8bd8e249-deae-4ff6-94aa-e5aabdc33b00
InstanceOf: Provenance
Title: "Unité d'affichage non fixée (PR3)"
Description: """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryPlaquettes)
* occurredDateTime = "2026-10-15"
* reason.text = """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-15T17:00:00+02:00"

Instance: baab4ea8-c214-48ec-b522-749af6728d13
InstanceOf: Provenance
Title: "Deux notations UCUM acceptées (PR3)"
Description: """Remédiation robustesse (#19), revue PR #29 : valueQuantity.code n'est plus fixé ; l'invariant dm-lab-unit-10e3-ul accepte les deux notations UCUM équivalentes (10*3/uL et 10^3/uL)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryPlaquettes)
* occurredDateTime = "2026-10-20"
* reason.text = """Remédiation robustesse (#19), revue PR #29 : valueQuantity.code n'est plus fixé ; l'invariant dm-lab-unit-10e3-ul accepte les deux notations UCUM équivalentes (10*3/uL et 10^3/uL)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-20T10:00:00+02:00"
