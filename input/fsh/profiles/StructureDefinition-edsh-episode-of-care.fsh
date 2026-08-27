Profile: EdshEpisodeOfCare
Parent: EpisodeOfCare
Id: edsh-episode-of-care
Title: "Episode of care"
Description: "Episode of care adapted to Data Management"

* patient only Reference(Patient or EdshPatient)
* managingOrganization only Reference(Organization or EdshOrganization)

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