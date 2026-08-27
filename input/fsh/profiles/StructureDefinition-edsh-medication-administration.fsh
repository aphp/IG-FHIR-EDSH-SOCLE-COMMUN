Profile:  EdshMedicationAdministration
Parent:   MedicationAdministration
Id: edsh-medication-administration
Title:    "Prise de médicaments"
Description: "Profil pour la prise de médicaments"
* medication[x] ^short = "Médicament administré : code (CIM/UCD/ATC…) ou référence à une ressource Medication"
* medication[x] only Reference(Medication or FrMedicationUcd or FrMedicationNonproprietaryName or FrMedicationCompound) or CodeableConcept
* subject ^short = "Patient à qui le médicament est administré"
* subject only Reference(Patient or Group or EdshPatient)
* dosage ^short = "Détail de l'administration réalisée"
* dosage 0..1 // base cardinality (reverted from 1..1 per #22)
  * route ^short = "Voie d'administration"
  * route from FrRouteOfAdministration (extensible)
  * dose ^short = "Dose administrée, avec unité UCUM"
  * dose only FrSimpleQuantityUcum
  * rate[x] ^short = "Débit d'administration, avec unité UCUM"
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