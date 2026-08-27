Instance: edsh-episode-of-care-example
InstanceOf: EdshEpisodeOfCare
Usage: #example
Description: "Exemple de EdshEpisodeOfCare : le suivi cardiologique de Madame Dupont."

* status = #active
* patient = Reference(Patient/cas1-pat-01)
* managingOrganization = Reference(edsh-organization-example)
* period.start = "2024-01-10"
