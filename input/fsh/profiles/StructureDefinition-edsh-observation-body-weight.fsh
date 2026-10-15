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

* performer ^short = "Intervenant ayant réalisé la mesure"
* performer only Reference(CareTeam or RelatedPerson or PractitionerRole or FRCorePatientProfile or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCoreRelatedPersonProfile or EdshPatient or EdshPractitioner or EdshPractitionerRole or EdshOrganization)

* effective[x] only dateTime
* effective[x] ^short = "Date de réalisation de la mesure"

* value[x] ^short = "Valeur de la mesure. Les signes vitaux sont enregistrés sous forme de quantité, exprimés en unité du Système International."

* method ^short = "Méthode de mesure du poids"
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

Instance: d612521d-9a6e-4645-bd7e-8bee5685990b
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshObservationBodyWeight)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"

Instance: e02a5617-3e80-480d-8633-8838d833c0d1
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshObservationBodyWeight)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
