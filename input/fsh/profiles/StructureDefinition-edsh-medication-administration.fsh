Profile:  EdshMedicationAdministration
Parent:   MedicationAdministration
Id: edsh-medication-administration
Title:    "Administration de médicaments"
Description: "Profil pour l'administration de médicaments"
* medication[x] ^short = "Médicament administré : code (CIM/UCD/ATC…) ou référence à une ressource Medication"
* medication[x] only Reference(Medication or FrMedicationUcd or FrMedicationNonproprietaryName or FrMedicationCompound) or CodeableConcept
* subject ^short = "Patient à qui le médicament est administré"
* subject only Reference(Patient or Group or FRCorePatientProfile or EdshPatient)
* context ^short = "Passage ou épisode de soins au cours duquel le médicament est administré"
* context only Reference(Encounter or EpisodeOfCare or FRCoreEncounterProfile or EdshEncounter or EdshEpisodeOfCare)
* performer.actor ^short = "Intervenant ayant administré le médicament"
* performer.actor only Reference(Practitioner or PractitionerRole or Patient or RelatedPerson or Device or FRCorePractitionerProfile or FRCorePractitionerRole or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshPatient)
* dosage ^short = "Détail de l'administration réalisée"
* dosage 0..1 // base cardinality (reverted from 1..1 per #22)
  * route ^short = "Voie d'administration"
  * route from FrRouteOfAdministration (extensible)
  * dose ^short = "Dose administrée, avec unité UCUM"
  * dose only FrSimpleQuantityUcum
  * rate[x] ^short = "Débit d'administration, avec unité UCUM"
  * rate[x] only FrRatioUcum or FrSimpleQuantityUcum

Instance: 57c2e039-233f-434b-9c65-3f8673f55727
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshMedicationAdministration)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: 6c74dc91-f52e-486e-a0d2-f748da6969cd
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core) ; élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27) ; retour à la cardinalité de base de dosage (#22)."""
Usage: #definition

* target[0] = Reference(EdshMedicationAdministration)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core) ; élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27) ; retour à la cardinalité de base de dosage (#22)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"

Instance: f31ede99-e1cf-4e7e-8b0b-d19b825657c1
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; titre et description : « administration » plutôt que « prise » de médicaments (revue PR #28)."""
Usage: #definition

* target[0] = Reference(EdshMedicationAdministration)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; titre et description : « administration » plutôt que « prise » de médicaments (revue PR #28)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
