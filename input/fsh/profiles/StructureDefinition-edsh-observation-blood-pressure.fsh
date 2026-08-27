Profile: EdshObservationBloodPressure
Parent: FRCoreObservationBpProfile
Id: edsh-observation-blood-pressure
Title: "Pression artérielle"
Description: "Profil de la pression artérielle du socle commun des EDS"

* subject only Reference(Patient or FRCorePatientProfile or EdshPatient)
* subject ^short = "L'observation concerne la personne que l'on analyse."

* encounter only Reference(FRCoreEncounterProfile or EdshEncounter)
* encounter ^short = "NDA (Numéro de Dossier Administratif) associé à la mesure"
* encounter ^definition = "Le NDA peut correspondre à une hospitalisation complète, un dossier de consultation, d'hospitalisation de jour..."

* performer ^short = "Intervenant ayant réalisé la mesure"
* performer only Reference(CareTeam or PractitionerRole or FRCorePatientProfile or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCoreRelatedPersonProfile or EdshPatient or EdshPractitioner or EdshPractitionerRole or EdshOrganization)

* effective[x] only dateTime
* effective[x] ^short = "Date de réalisation de la mesure"

* bodySite ^short = "Site anatomique de la mesure"
* bodySite from BloodPressureMeasurementBodyLocationPrecoordinated (example)
* method ^short = "Méthode de mesure de la pression artérielle"
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

Instance: 24380e45-14fb-4650-89d5-c5e357804e38
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshObservationBloodPressure)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"
