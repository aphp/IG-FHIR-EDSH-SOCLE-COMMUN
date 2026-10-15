Instance: edsh-episode-of-care-example
InstanceOf: EdshEpisodeOfCare
Usage: #example
Description: "Exemple de EdshEpisodeOfCare : le suivi cardiologique de Paul Durand."

* status = #active
* patient = Reference(edsh-patient-example)
* managingOrganization = Reference(edsh-organization-example)
* period.start = "2024-01-10"
* careManager = Reference(edsh-practitioner-role-example)
