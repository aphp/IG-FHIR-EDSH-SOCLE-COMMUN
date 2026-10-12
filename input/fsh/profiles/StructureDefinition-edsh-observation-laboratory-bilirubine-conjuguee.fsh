Profile: EdshObservationLaboratoryBilirubineConjuguee
Parent: EdshObservationLaboratoryGeneric
Id: edsh-observation-laboratory-bilirubine-conjuguee
Title: "Bilirubine conjuguée"
Description: """
Profil Bilirubine conjuguée du socle commun des EDSH
"""

* code = $loinc#29760-6 "Bilirubine conjuguée [Moles/Volume] Sérum/Plasma ; Numérique" (exactly)

* value[x] ^short = "Bilirubine conjuguée — valeur mesurée, en µmol/L"
* value[x] only Quantity
* valueQuantity.value ^short = "Valeur numérique du résultat"
* valueQuantity.system = $ucum (exactly)
* valueQuantity.code = #umol/L (exactly)
* valueQuantity.unit = "umol/L"

Instance: 8f95027b-e9fd-40fb-b8c8-7de2bd39b6f1
InstanceOf: Provenance
Title: "feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"
Description: """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryBilirubineConjuguee)
* occurredDateTime = "2025-10-14"
* reason.text = """feat(fhir-profiles): add 18 laboratory observation profiles for EDSH core variables"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-10-14T16:58:23+02:00"

Instance: 7d38bb24-9dcd-45f6-84a3-84c34b2031dd
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryBilirubineConjuguee)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
