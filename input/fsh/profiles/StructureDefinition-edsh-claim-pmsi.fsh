Profile: EdshClaimPmsi
Parent: Claim
Id: edsh-claim-pmsi
Title: "Profil de Claim pour le PMSI"
Description: "Profil abstrait pour les invariants dans les claims du PMSI."

* ^abstract = true

* type from FrClaimTypeVs (required)
* type ^short = "Champ du PMSI concerné."

* patient ^short = "Patient objet du séjour facturé"
* patient only Reference(Patient or EdshPatient)
* provider ^short = "Entité juridique émettrice"
* priority ^short = "Priorité de traitement : toujours « normal » pour le PMSI"
* priority = http://terminology.hl7.org/CodeSystem/processpriority#normal
* use ^short = "Usage de la ressource : toujours « claim » pour le PMSI"
* use = #claim

* insurance ^short = "Couverture : le PMSI ne renseigne que l'Assurance Maladie"
* insurance.sequence = 1
* insurance.focal = true
* insurance.coverage.display = "Assurance Maladie" // base cardinality 0..1 (reverted from 1..1 per #22)

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