Profile: EdshObservationLaboratoryGeneric
Parent: Observation // pas de profil ANS (et le profil mesure glucose me semble inadapté), pas de profil FHIR, uscore propose un profil lab générique.
Id: edsh-observation-laboratory-generic
Title: "Résultat de laboratoire"
Description: """
Profil générique des résultats de laboratoire du socle commun des EDS.
"""

* ^abstract = true

// status: le GT demande un status, mais il n'y a pas de place dans OMOP pour cela.

* category 1..1
* category = $observation-category#laboratory (exactly)

* code from EdshLaboratory (required)

* subject only Reference(Patient or Group or Device or Location or FRCorePatientProfile or FRCoreLocationProfile or EdshPatient or EdshLocation)
* subject ^short = "L'observation concerne la personne que l'on analyse."
* encounter only Reference(Encounter or FRCoreEncounterProfile or EdshEncounter)
* performer only Reference(Practitioner or PractitionerRole or Organization or CareTeam or Patient or RelatedPerson or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshOrganization or EdshPatient)

* obeys dm-lab-1
* obeys dm-lab-2
* obeys dm-lab-3
* obeys dm-lab-4
* obeys dm-lab-5
* obeys dm-lab-6

* component.code from EdshLaboratory (required) // créer le VS et le CS

Instance: 1f3e2728-1d70-4ca7-ac28-a4c1b11c4b80
InstanceOf: Provenance
Title: "WIP adding EDSH vars"
Description: """WIP adding EDSH vars"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryGeneric)
* occurredDateTime = "2025-03-24"
* reason.text = """WIP adding EDSH vars"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-03-24T09:26:15+01:00"

Instance: 3d3aae22-f72c-4bcc-b221-24116eb5458b
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core) ; élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryGeneric)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core) ; élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"
