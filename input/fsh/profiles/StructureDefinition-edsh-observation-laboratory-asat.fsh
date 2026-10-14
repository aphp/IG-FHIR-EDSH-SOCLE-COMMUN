Profile: EdshObservationLaboratoryAsat
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-asat
Title: "Aspartate aminotransférase (ASAT)"
Description: """
Taux d'ASAT dans le sang. L'ASAT est une enzyme faisant partie des transaminases qui intervient dans la navette malate-aspartate de transfert des électrons du NADH cytosolique vers le NAD+ mitochondrial.
"""

* code = $loinc#30239-8 "Aspartate aminotransférase [Catalytique/Volume] Sérum/Plasma ; Numérique ; Avec phosphate de pyridoxal" (exactly)

* value[x] ^short = "Aspartate aminotransférase (ASAT) — valeur mesurée, en UI/L"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code = #[IU]/L (exactly)
* valueQuantity.unit = "[IU]/L"

Instance: 54a2948b-6ae1-4fa7-8a99-d5db61701273
InstanceOf: Provenance
Title: "feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"
Description: """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryAsat)
* occurredDateTime = "2025-10-14"
* reason.text = """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-10-14T16:58:23+02:00"

Instance: 8bc53be3-4fb8-4cf5-a481-bf15d3d4c11c
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryAsat)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"

Instance: beee7350-85de-41e0-9df7-a320e3715949
InstanceOf: Provenance
Title: "Documentation des éléments (PR2, seconde revue)"
Description: """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryAsat)
* occurredDateTime = "2026-10-14"
* reason.text = """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-14T16:00:00+02:00"
