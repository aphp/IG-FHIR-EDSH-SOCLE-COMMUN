Instance: edsh-observation-laboratory-lymphocytes-example
InstanceOf: EdshObservationLaboratoryLymphocytes
Usage: #example
Description: "Exemple de EdshObservationLaboratoryLymphocytes : lymphocytes totaux de Paul Durand."

* status = #final
* subject = Reference(edsh-patient-example)
* performer = Reference(edsh-organization-example)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 2.1 '10*3/uL' "10^3/µL"
