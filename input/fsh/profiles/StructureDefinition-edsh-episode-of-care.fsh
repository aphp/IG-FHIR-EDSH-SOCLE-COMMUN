Profile: EdshEpisodeOfCare
Parent: EpisodeOfCare
Id: edsh-episode-of-care
Title: "Episode of care"
Description: "Episode of care adapted to Data Management"

* patient ^short = "Patient suivi dans cet épisode de soins"
* patient only Reference(Patient or FRCorePatientProfile or EdshPatient)
* managingOrganization ^short = "Organisation responsable de l'épisode de soins"
* managingOrganization only Reference(Organization or FRCoreOrganizationProfile or EdshOrganization)

Instance: c4a1cf2f-5519-421d-9040-461a2598c8cb
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshEpisodeOfCare)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: d8b99279-ae31-4307-8d70-c36f25786cbd
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshEpisodeOfCare)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"
