Profile: EdshObservationLaboratoryAlat
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-alat
Title: "Alanine aminotransférase (ALAT)"
Description: """
Taux d'ALAT dans le sang. L'alanine-aminotransférase est capable de transférer le groupement amine de l'acide glutamique sur l'acide pyruvique avec formation d'une molécule d'acide α-cétoglutarique et d'alanine.
"""

* code = $loinc#1743-4 "Alanine aminotransférase [Catalytique/Volume] Sérum/Plasma ; Numérique ; Avec phosphate de pyridoxal" (exactly)

* value[x] ^short = "Alanine aminotransférase (ALAT) — valeur mesurée, en UI/L"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code = #[IU]/L (exactly)
* valueQuantity.unit = "[IU]/L"

Instance: 6b8b7a13-8482-474b-83c7-d65be26142a4
InstanceOf: Provenance
Title: "Ajout du profil pour les alat qui était manquant"
Description: """Ajout du profil pour les alat qui était manquant"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryAlat)
* occurredDateTime = "2025-10-16"
* reason.text = """Ajout du profil pour les alat qui était manquant"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "Nicolas Griffon"
* recorded = "2025-10-16T14:43:23+02:00"

Instance: 85c6cae6-be95-46d1-bd70-49564b8819b9
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryAlat)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"

Instance: a331f911-e198-4a45-8215-d44e8659fd88
InstanceOf: Provenance
Title: "Documentation des éléments (PR2, seconde revue)"
Description: """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryAlat)
* occurredDateTime = "2026-10-14"
* reason.text = """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-14T16:00:00+02:00"
