Profile: EdshObservationBloodPressure
Parent: FRCoreObservationBpProfile
Id: edsh-observation-blood-pressure
Title: "Pression artérielle"
Description: "Profil de la pression artérielle du socle commun des EDS"

* subject only Reference(Patient or EdshPatient)
* subject ^short = "L'observation concerne la personne que l'on analyse."

* encounter only Reference(FRCoreEncounterProfile or EdshEncounter)
* encounter ^short = "NDA (Numéro de Dossier Administratif) associé à la mesure"
* encounter ^definition = "Le NDA peut correspondre à une hospitalisation complète, un dossier de consultation, d'hospitalisation de jour..."

* performer only Reference(CareTeam or FRCorePatientProfile or FRCorePractitionerProfile or PractitionerRole or FRCoreOrganizationProfile or FRCoreRelatedPersonProfile or EdshPatient or EdshPractitioner or EdshPractitionerRole or EdshOrganization)

* effective[x] only dateTime
* effective[x] ^short = "Date de réalisation de la mesure"

* bodySite from BloodPressureMeasurementBodyLocationPrecoordinated (example)
* method from BloodPressureMeasurementMethod (example)

Instance: 5236693c-8f6f-46fc-8ba6-63665228922e
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshObservationBloodPressure)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"
