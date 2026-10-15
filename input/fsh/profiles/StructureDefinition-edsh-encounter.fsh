Profile: EdshEncounter
Parent: FRCoreEncounterProfile
Id: edsh-encounter
Title: "Encounter"
Description: "Encounter adapted to Data Management"

* subject ^short = "Patient concerné par la venue"
* subject only Reference(FRCorePatientProfile or EdshPatient)
* episodeOfCare ^short = "Épisode de soins auquel cette venue se rattache"
* episodeOfCare only Reference(EpisodeOfCare or EdshEpisodeOfCare)
* hospitalization.preAdmissionIdentifier.assigner ^short = "Organisation ayant attribué l'identifiant de pré-admission"
* hospitalization.preAdmissionIdentifier.assigner only Reference(FRCoreOrganizationProfile or EdshOrganization)
* hospitalization.origin ^short = "Provenance du patient (lieu ou organisation d'origine)"
* hospitalization.origin only Reference(FRCoreLocationProfile or FRCoreOrganizationProfile or EdshLocation or EdshOrganization)

* serviceProvider ^short = "Organisation en responsabilité médicale lors de la venue"
* serviceProvider only Reference(FRCoreOrganizationProfile or EdshOrganization)

* partOf ^short = "Venue englobante, quand cette venue en est une sous-partie"
* partOf only Reference(FRCoreEncounterProfile or EdshEncounter)

Instance: ceaac970-fd2b-43fc-b22c-db2a376e663c
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshEncounter)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: 8ab92c92-0c15-4057-b005-fac54552ac9c
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshEncounter)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"

Instance: edd9255b-e9a7-4363-a647-be3b1da2c98c
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
Usage: #definition

* target[0] = Reference(EdshEncounter)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"

Instance: ee291492-2d0d-49cd-bab1-9dbb939901f7
InstanceOf: Provenance
Title: "Documentation des éléments (PR2, seconde revue)"
Description: """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
Usage: #definition

* target[0] = Reference(EdshEncounter)
* occurredDateTime = "2026-10-14"
* reason.text = """Remédiation robustesse (#19), PR2, seconde revue (#28) : reformulation des ^short (« venue » au lieu de « passage », unités lisibles et homogènes, référentiels du médicament, couverture PMSI)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-14T16:00:00+02:00"
