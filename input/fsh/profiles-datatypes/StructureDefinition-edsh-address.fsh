Profile: EdshAddress
Parent: FRCoreAddressProfile
Id: edsh-address
Title: "Address"
Description: """
Profil Address du socle commun des EDSH. Étend FRCoreAddressProfile avec la géolocalisation,
le code géographique PMSI de résidence et le census tract, tous optionnels.
"""

* extension contains
  $geolocation named geolocation 0..1
  and EdshPmsiCodeGeo named PmsiCodeGeo 0..1
  and http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-censusTract named iso21090-ADXP-censusTract 0..1
* extension[geolocation] ^short = "Coordonnées géographiques (latitude / longitude) de l'adresse"
* extension[PmsiCodeGeo] ^short = "Code géographique PMSI de la commune de résidence"
* extension[iso21090-ADXP-censusTract] ^short = "Code IRIS de l'adresse, tel que défini par l'INSEE"

Instance: bde2c040-e464-4735-8b9a-e6ace74659ed
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshAddress)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: 631a1283-23a9-41f6-8f56-feda20cf5a50
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core)."""
Usage: #definition

* target[0] = Reference(EdshAddress)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"

Instance: d3b3c8e2-78b5-4e53-8199-6276582e91d6
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshAddress)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
