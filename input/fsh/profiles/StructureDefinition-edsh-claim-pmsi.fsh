Profile: EdshClaimPmsi
Parent: Claim
Id: edsh-claim-pmsi
Title: "Profil de Claim pour le PMSI"
Description: "Profil abstrait pour les invariants dans les claims du PMSI."

* ^abstract = true

* type from FrClaimTypeVs (required)
* type ^short = "Champ du PMSI concerné."

* patient only Reference(Patient or FRCorePatientProfile or EdshPatient)
* payee.party only Reference(Practitioner or PractitionerRole or Organization or Patient or RelatedPerson or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshOrganization or EdshPatient)
* provider ^short = "Entité juridique émettrice"
* priority = http://terminology.hl7.org/CodeSystem/processpriority#normal
* use = #claim

* insurance.sequence = 1
* insurance.focal = true
* insurance.coverage.display = "Assurance Maladie" // base cardinality 0..1 (reverted from 1..1 per #22)

* item.encounter only Reference(Encounter or FRCoreEncounterProfile or EdshEncounter)

Instance: 00ced63e-5fff-4e7b-ab78-736c1d3bfcd8
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshClaimPmsi)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: 19d3eee0-3b02-4699-803d-492dc5952ae6
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27) ; retour à la cardinalité de base de insurance.coverage.display (#22)."""
Usage: #definition

* target[0] = Reference(EdshClaimPmsi)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27) ; retour à la cardinalité de base de insurance.coverage.display (#22)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"
