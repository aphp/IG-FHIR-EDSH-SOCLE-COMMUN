Profile: EdshObservationLaboratoryGeneric
Parent: Observation // pas de profil ANS (et le profil mesure glucose me semble inadapté), pas de profil FHIR, uscore propose un profil lab générique.
Id: edsh-observation-laboratory-generic
Title: "Résultat de laboratoire"
Description: """
Profil générique des résultats de laboratoire du socle commun des EDS.
"""

* ^abstract = true

// status: le GT demande un status, mais il n'y a pas de place dans OMOP pour cela.

* category 1..1
* category = $observation-category#laboratory (exactly)

* code from EdshLaboratory (required)

* subject only Reference(Patient or Group or Device or Location or EdshPatient)
* subject ^short = "L'observation concerne la personne que l'on analyse."

* obeys dm-lab-1
* obeys dm-lab-2
* obeys dm-lab-3
* obeys dm-lab-4
* obeys dm-lab-5
* obeys dm-lab-6

* component.code from EdshLaboratory (required) // créer le VS et le CS

Instance: 1f3e2728-1d70-4ca7-ac28-a4c1b11c4b80
InstanceOf: Provenance
Title: "WIP adding EDSH vars"
Description: """WIP adding EDSH vars"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryGeneric)
* occurredDateTime = "2025-03-24"
* reason.text = """WIP adding EDSH vars"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-03-24T09:26:15+01:00"