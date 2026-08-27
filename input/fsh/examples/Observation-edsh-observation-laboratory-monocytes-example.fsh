Instance: edsh-observation-laboratory-monocytes-example
InstanceOf: EdshObservationLaboratoryMonocytes
Usage: #example
Description: "Exemple de EdshObservationLaboratoryMonocytes : monocytes de Madame Dupont."

* status = #final
* subject = Reference(Patient/cas1-pat-01)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 0.5 '10*3/uL'
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #10*3/uL
