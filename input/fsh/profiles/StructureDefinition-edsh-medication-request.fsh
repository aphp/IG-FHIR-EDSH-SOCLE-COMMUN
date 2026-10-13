Profile:  EdshMedicationRequest
Parent:   MedicationRequest
Id: edsh-medication-request
Title:    "Prescription de médicaments"
Description:  "Profil pour les prescriptions médicamenteuses"
* medication[x] only Reference(Medication or FrMedicationUcd or FrMedicationNonproprietaryName or FrMedicationCompound) or CodeableConcept
* subject only Reference(Patient or Group or FRCorePatientProfile or EdshPatient)
* encounter only Reference(Encounter or FRCoreEncounterProfile or EdshEncounter)
* reported[x] only boolean or Reference(Patient or Practitioner or PractitionerRole or RelatedPerson or Organization or FRCorePatientProfile or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreRelatedPersonProfile or FRCoreOrganizationProfile or EdshPatient or EdshPractitioner or EdshPractitionerRole or EdshOrganization)
* requester only Reference(Practitioner or PractitionerRole or Organization or Patient or RelatedPerson or Device or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshOrganization or EdshPatient)
* performer only Reference(Practitioner or PractitionerRole or Organization or Patient or Device or RelatedPerson or CareTeam or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshOrganization or EdshPatient)
* dosageInstruction 0..* // base cardinality (reverted from 1.. per #22)
  * route from FrRouteOfAdministration (extensible)
  * doseAndRate
    * dose[x] only FrRangeUcum or FrSimpleQuantityUcum
    * rate[x] only FrRatioUcum or FrRangeUcum or FrSimpleQuantityUcum
    * rate[x] ^definition = "Amount of medication per unit of time. Using a ratio, the denominator SHALL be a quantity of time. Using a simple quantity the UCUM unit SHALL be a unit of rate."
  * maxDosePerPeriod
    * numerator only FrSimpleQuantityUcum
    * denominator only FrSimpleQuantityUcum
  * maxDosePerAdministration only FrSimpleQuantityUcum
  * maxDosePerLifetime only FrSimpleQuantityUcum

Instance: f99b5bbd-3144-4bd0-b0f3-9f6e061ed363
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshMedicationRequest)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: 3e82a8e8-1e3f-4687-9c1a-bf902e0897dc
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core) ; élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27) ; retour à la cardinalité de base de dosageInstruction (#22)."""
Usage: #definition

* target[0] = Reference(EdshMedicationRequest)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core) ; élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27) ; retour à la cardinalité de base de dosageInstruction (#22)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"
