Profile: FrSimpleQuantityUcum
Parent: SimpleQuantity
Id: fr-simple-quantity-ucum
Title: "SimpleQuantity with UCUM quantity unit"
Description: "simple quantity datatype requiring a UCUM unit"
* . ^short = "A fixed quantity (no comparator) with UCUM unit"
* . ^definition = "The comparator is not used on a SimpleQuantity. The unit SHALL be a UCUM code."
* . ^comment = "Ce profil de type de donnée est inspiré de [FrSimpleQuantityMedication](https://interop-sante.github.io/hl7.fhir.fr.medication/main/ig/StructureDefinition-FrSimpleQuantityMedication.html) du Guide d'implémentation du médicament [initié par Interop'Santé](https://github.com/Interop-Sante/hl7.fhir.fr.medication). Il sert à contraindre l'utilisation d'une unité UCUM (là où le profil de l'IG médicament permet d'utiliser également EDQM)."
* system 1..
* system = "http://unitsofmeasure.org" (exactly)
* system ^definition = "UCUM requiered for the identification of the system that provides the coded form of the unit."
* system ^requirements = "UCUM requiered."
* code 1..
* code ^comment = "UCUM code required."

Instance: f3fb1ab8-ef39-45b7-82d8-87fca1496132
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(FrSimpleQuantityUcum)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: fe3c290e-9283-4496-9040-1379665246ca
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core)."""
Usage: #definition

* target[0] = Reference(FrSimpleQuantityUcum)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"

Instance: 55edfd40-6e06-475f-8705-b602d921a4e5
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; origine du profil précisée : inspiré de FrSimpleQuantityMedication (IG médicament Interop'Santé) (revue PR #28)."""
Usage: #definition

* target[0] = Reference(FrSimpleQuantityUcum)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; origine du profil précisée : inspiré de FrSimpleQuantityMedication (IG médicament Interop'Santé) (revue PR #28)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
