Instance: edsh-observation-laboratory-uremie-example
InstanceOf: EdshObservationLaboratoryUremie
Usage: #example
Description: "Exemple de EdshObservationLaboratoryUremie : urée de Madame Dupont."

* status = #final
* subject = Reference(Patient/cas1-pat-01)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 5.0 'mmol/L'
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #mmol/L
