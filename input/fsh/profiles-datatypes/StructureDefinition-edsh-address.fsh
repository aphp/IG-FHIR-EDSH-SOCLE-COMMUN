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
* extension[iso21090-ADXP-censusTract] ^short = "Census tract (subdivision statistique) de l'adresse"

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
