Profile: EdshObservationBodyHeight
Parent: FRCoreObservationBodyHeightProfile
Id: edsh-observation-body-height
Title: "Taille du patient"
Description: "Ce profil définit la manière de représenter les observations de taille corporelle en utilisant un code LOINC standard et des unités de mesure UCUM."

* subject only Reference(FRCorePatientProfile or EdshPatient)
* subject ^short = "Patient dont la taille est mesurée"

* encounter only Reference(FRCoreEncounterProfile or EdshEncounter)
* encounter ^short = "NDA (Numéro de Dossier Administratif) associé à la mesure"
* encounter ^definition = "Le NDA peut correspondre à une hospitalisation complète, un dossier de consultation, d'hospitalisation de jour..."
* performer only Reference(CareTeam or RelatedPerson or PractitionerRole or FRCorePatientProfile or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCoreRelatedPersonProfile or EdshPatient or EdshPractitioner or EdshPractitionerRole or EdshOrganization)

* code ^short = "Code standardisé pour 'Taille'"
* code ^definition = "Taille, codé en LOINC, en cohérence avec le cadre d'interopérabilité des systèmes d'information en santé (CI-SIS)."

* effective[x] only dateTime
* effective[x] ^short = "Date de réalisation de la mesure"
* value[x] ^short = "Valeur de la mesure. Les signes vitaux sont enregistrés sous forme de quantité, exprimés en unité du Système International."

* method from HeightLengthMeasurementMethod (example)

Instance: 9be02e59-c737-45b0-a64a-53484a5b79d4
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshObservationBodyHeight)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: 79d6621e-9b8d-4983-a52c-b1b9117e48eb
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshObservationBodyHeight)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"
