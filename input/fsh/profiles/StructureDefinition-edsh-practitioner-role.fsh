Profile: EdshPractitionerRole
//Parent: AsPractitionerRoleProfile
Parent: PractitionerRole
Id: edsh-practitioner-role
Title: "PractitionerRole"
Description: "PractitionerRole adapted to Data Management"

* practitioner only Reference(Practitioner or FRCorePractitionerProfile or EdshPractitioner)

Instance: f0a1b2c3-4d5e-6f7a-8b9c-0d1e2f3a4b5c
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshPractitionerRole)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: dcad5ae1-bcd0-4f90-af0b-a3bb5fdbb2af
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshPractitionerRole)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"
