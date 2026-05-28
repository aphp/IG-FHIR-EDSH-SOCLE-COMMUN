Profile: EdshEncounter
Parent: FRCoreEncounterProfile
Id: edsh-encounter
Title: "Encounter"
Description: "Encounter adapted to Data Management"

* subject only Reference(EdshPatient)
* episodeOfCare only Reference(EdshEpisodeOfCare)
* hospitalization.preAdmissionIdentifier.assigner only Reference(EdshOrganization)
* hospitalization.origin only Reference(EdshLocation or EdshOrganization)

* serviceProvider only Reference(EdshOrganization)

* partOf only Reference(EdshEncounter)

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