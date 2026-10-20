Profile: EdshObservationLaboratoryLymphocytes
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-lymphocytes
Title: "Lymphocytes"
Description: """
Profil Lymphocytes du socle commun des EDSH
"""

* code = $loinc#26474-7 "Lymphocytes totaux [Nombre/Volume] Sang ; Numérique" (exactly)

* value[x] ^short = "Lymphocytes — valeur mesurée, en 10^3/µL"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code ^comment = "Code UCUM 10*3/uL ou sa notation équivalente 10^3/uL (invariant dm-lab-unit-10e3-ul). Dans une même ressource, la valeur et les bornes de referenceRange utilisent la même notation (dm-lab-3) ; un consommateur doit traiter les deux comme une même unité."
* obeys dm-lab-unit-10e3-ul

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

Instance: b6d68f47-0b56-4c09-bc7d-598c4eee0369
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryLymphocytes)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"

Instance: 199ad678-9b5a-4de3-974d-e246ae377ae9
InstanceOf: Provenance
Title: "Documentation des éléments (PR2, seconde revue)"
Description: """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryLymphocytes)
* occurredDateTime = "2026-10-14"
* reason.text = """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-14T16:00:00+02:00"

Instance: 254341c4-c2db-46aa-9cf3-10206cf2da1f
InstanceOf: Provenance
Title: "Unité d'affichage non fixée (PR3)"
Description: """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryLymphocytes)
* occurredDateTime = "2026-10-15"
* reason.text = """Remédiation robustesse (#19), revue PR #29 : retrait de la valeur fixée sur valueQuantity.unit. L'unité est imposée par valueQuantity.code (UCUM) ; le libellé d'affichage reste libre, ce qui permet une forme lisible (10^3/µL, µmol/L…)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-15T17:00:00+02:00"

Instance: f9d57c9e-1cd5-47a1-89b6-88391cb5c56f
InstanceOf: Provenance
Title: "Deux notations UCUM acceptées (PR3)"
Description: """Remédiation robustesse (#19), revue PR #29 : valueQuantity.code n'est plus fixé ; l'invariant dm-lab-unit-10e3-ul accepte les deux notations UCUM équivalentes (10*3/uL et 10^3/uL)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryLymphocytes)
* occurredDateTime = "2026-10-20"
* reason.text = """Remédiation robustesse (#19), revue PR #29 : valueQuantity.code n'est plus fixé ; l'invariant dm-lab-unit-10e3-ul accepte les deux notations UCUM équivalentes (10*3/uL et 10^3/uL)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-20T10:00:00+02:00"
