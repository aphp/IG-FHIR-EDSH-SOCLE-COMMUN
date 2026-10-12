Profile: EdshAddress
Parent: FRCoreAddressProfile
Id: edsh-address
Title: "Address"
Description: "Profil Address du socle commun des EDS"

* extension contains 
  $geolocation named geolocation 0..1
  and EdshPmsiCodeGeo named PmsiCodeGeo 0..1
  and http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-censusTract named iso21090-ADXP-censusTract 0..1

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
