Instance: edsh-observation-laboratory-erythrocytes-example
InstanceOf: EdshObservationLaboratoryErythrocytes
Usage: #example
Description: "Exemple de EdshObservationLaboratoryErythrocytes : érythrocytes de Madame Dupont."

* status = #final
* subject = Reference(Patient/cas1-pat-01)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 4.7 '10*6/uL'
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #10*6/uL
