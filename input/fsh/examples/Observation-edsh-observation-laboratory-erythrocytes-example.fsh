Instance: edsh-observation-laboratory-erythrocytes-example
InstanceOf: EdshObservationLaboratoryErythrocytes
Usage: #example
Description: "Exemple de EdshObservationLaboratoryErythrocytes : érythrocytes de Paul Durand."

* status = #final
* subject = Reference(edsh-patient-example)
* performer = Reference(edsh-organization-example)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 4.7 '10*6/uL' "10^6/µL"
