Profile:  EdshMedicationAdministration
Parent:   MedicationAdministration
Id: edsh-medication-administration
Title:    "Prise de médicaments"
Description: "Profil pour la prise de médicaments"
* medication[x] only Reference(Medication or FrMedicationUcd or FrMedicationNonproprietaryName or FrMedicationCompound) or CodeableConcept
* subject only Reference(Patient or Group or EdshPatient)
* dosage 0..1 // base cardinality (reverted from 1..1 per #22)
  * route from FrRouteOfAdministration (extensible)
  * dose only FrSimpleQuantityUcum
  * rate[x] only FrRatioUcum or FrSimpleQuantityUcum

Instance: 57c2e039-233f-434b-9c65-3f8673f55727
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshMedicationAdministration)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"