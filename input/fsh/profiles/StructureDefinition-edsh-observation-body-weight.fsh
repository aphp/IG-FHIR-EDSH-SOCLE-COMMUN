Profile: EdshObservationBodyWeight
Parent: FRCoreObservationBodyWeightProfile
Id: edsh-observation-body-weight
Title: "Poids du patient"
Description: "Ce profil définit la manière de représenter les observations de poids corporel en utilisant un code LOINC standard et des unités de mesure UCUM."

* code ^short = "Code standardisé pour 'Poids'"
* code ^definition = "Poids, codé en LOINC, en cohérence avec le cadre d'interopérabilité des systèmes d'information en santé (CI-SIS)."

* subject only Reference(FRCorePatientProfile or EdshPatient)
* subject ^short = "Patient dont le poids est mesuré"

* encounter only Reference(FRCoreEncounterProfile or EdshEncounter)
* encounter ^short = "NDA (Numéro de Dossier Administratif) associé à la mesure"
* encounter ^definition = "Le NDA peut correspondre à une hospitalisation complète, un dossier de consultation, d'hospitalisation de jour..."

* performer only Reference(CareTeam or RelatedPerson or FRCorePractitionerProfile or PractitionerRole or FRCoreOrganizationProfile or FRCorePatientProfile or EdshPatient or EdshPractitioner or EdshPractitionerRole or EdshOrganization)

* effective[x] only dateTime
* effective[x] ^short = "Date de réalisation de la mesure"

* value[x] ^short = "Valeur de la mesure. Les signes vitaux sont enregistrés sous forme de quantité, exprimés en unité du Système International."

* method from WeightMeasurementMethod (example)

Instance: 44b5a472-6a1e-4d9b-b02f-0f3cc2e74393
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshObservationBodyWeight)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"