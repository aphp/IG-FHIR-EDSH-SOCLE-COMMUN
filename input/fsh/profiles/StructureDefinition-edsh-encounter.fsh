Profile: EdshEncounter
Parent: FRCoreEncounterProfile
Id: edsh-encounter
Title: "Encounter"
Description: "Encounter adapted to Data Management"

* subject only Reference(FRCorePatientProfile or EdshPatient)
* episodeOfCare only Reference(EpisodeOfCare or EdshEpisodeOfCare)
* hospitalization.preAdmissionIdentifier.assigner only Reference(FRCoreOrganizationProfile or EdshOrganization)
* hospitalization.origin only Reference(FRCoreLocationProfile or FRCoreOrganizationProfile or EdshLocation or EdshOrganization)

* serviceProvider only Reference(FRCoreOrganizationProfile or EdshOrganization)

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
