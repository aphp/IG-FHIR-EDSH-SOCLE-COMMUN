Profile: EdshObservationLaboratoryPal
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-pal
Title: "Phosphatases alcaline"
Description: """
Profil Phosphatases alcaline du socle commun des EDSH
"""

* code = $loinc#6768-6 "Phosphatases alcalines [Catalytique/Volume] Sérum/Plasma ; Numérique" (exactly)

* value[x] ^short = "Phosphatases alcalines — valeur mesurée, en U/L"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code = #U/L (exactly)
* valueQuantity.unit = "U/L"

Instance: 36035e17-dee7-45eb-9f5a-1fa7628524da
InstanceOf: Provenance
Title: "feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"
Description: """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryPal)
* occurredDateTime = "2025-10-14"
* reason.text = """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-10-14T16:58:23+02:00"

Instance: 6d463d64-bb2f-4ba8-9476-7d8012aed167
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryPal)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
