Profile: EdshObservationLaboratoryErythrocytes
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-erythrocytes
Title: "Erythrocytes"
Description: """
Profil Erythrocytes du socle commun des EDSH
"""

* code = $loinc#789-8 "Érythrocytes [Nombre/Volume] Sang ; Numérique ; Comptage automate" (exactly)

* value[x] ^short = "Erythrocytes — valeur mesurée, en 10^6/µL"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code ^comment = "Code UCUM 10*6/uL ou sa notation équivalente 10^6/uL (invariant dm-lab-unit-10e6-ul). Dans une même ressource, la valeur et les bornes de referenceRange utilisent la même notation (dm-lab-3) ; un consommateur doit traiter les deux comme une même unité."
* obeys dm-lab-unit-10e6-ul

Instance: b8b64da7-a5d4-4bc7-ab3c-1c675a734996
InstanceOf: Provenance
Title: "Deux notations UCUM acceptées (PR3)"
Description: """Remédiation robustesse (#19), revue PR #29 : valueQuantity.code n'est plus fixé ; l'invariant dm-lab-unit-10e6-ul accepte les deux notations UCUM équivalentes (10*6/uL et 10^6/uL)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryErythrocytes)
* occurredDateTime = "2026-10-20"
* reason.text = """Remédiation robustesse (#19), revue PR #29 : valueQuantity.code n'est plus fixé ; l'invariant dm-lab-unit-10e6-ul accepte les deux notations UCUM équivalentes (10*6/uL et 10^6/uL)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-20T10:00:00+02:00"

Instance: 8bf638d2-465f-47ee-9016-0d7021d71d0d
InstanceOf: Provenance
Title: "Unité d'affichage non fixée (PR3)"
Description: """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryErythrocytes)
* occurredDateTime = "2026-10-15"
* reason.text = """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-15T17:00:00+02:00"

Instance: 5f84fead-3557-4eb2-a5e0-7f03cfaa14c6
InstanceOf: Provenance
Title: "Documentation des éléments (PR2, seconde revue)"
Description: """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryErythrocytes)
* occurredDateTime = "2026-10-14"
* reason.text = """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-14T16:00:00+02:00"

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
