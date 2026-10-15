Instance: edsh-observation-laboratory-monocytes-example
InstanceOf: EdshObservationLaboratoryMonocytes
Usage: #example
Description: "Exemple de EdshObservationLaboratoryMonocytes : monocytes de Paul Durand."

* status = #final
* subject = Reference(edsh-patient-example)
* performer = Reference(edsh-organization-example)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 0.5 '10*3/uL' "10^3/µL"
