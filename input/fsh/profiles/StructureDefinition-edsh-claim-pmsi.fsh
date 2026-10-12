Profile: EdshClaimPmsi
Parent: Claim
Id: edsh-claim-pmsi
Title: "Profil de Claim pour le PMSI"
Description: "Profil abstrait pour les invariants dans les claims du PMSI."

* ^abstract = true

* type from FrClaimTypeVs (required)
* type ^short = "Champ du PMSI concerné."

* patient ^short = "Patient objet du séjour facturé"
* patient only Reference(Patient or FRCorePatientProfile or EdshPatient)
* payee.party ^short = "Bénéficiaire du remboursement"
* payee.party only Reference(Practitioner or PractitionerRole or Organization or Patient or RelatedPerson or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshOrganization or EdshPatient)
* provider ^short = "Entité juridique émettrice"
* priority ^short = "Priorité de traitement : toujours « normal » pour le PMSI"
* priority = http://terminology.hl7.org/CodeSystem/processpriority#normal
* use ^short = "Usage de la ressource : toujours « claim » pour le PMSI"
* use = #claim

* insurance ^short = "Couverture : le PMSI ne renseigne que l'Assurance Maladie"
* insurance.sequence = 1
* insurance.focal = true
* insurance.coverage.display 1..1
* insurance.coverage.display = "Assurance Maladie"
* insurance.coverage.display ^comment = "Invariant PMSI conservé : Claim.insurance (1..*) et Claim.insurance.coverage (1..1) sont obligatoires en FHIR R4 mais sans objet pour le PMSI. Imposer ce display fixe garantit une Reference non vide sans exiger de ressource Coverage."

* item.encounter ^short = "Passage auquel se rattache la ligne"
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
Description: """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27) ; documentation de l'invariant PMSI insurance.coverage.display 1..1 (conservé, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshClaimPmsi)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27) ; documentation de l'invariant PMSI insurance.coverage.display 1..1 (conservé, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"

Instance: 029088e7-1c03-4d99-b117-02cda746fc3a
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshClaimPmsi)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
