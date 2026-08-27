Instance: edsh-observation-laboratory-bilirubine-conjuguee-example
InstanceOf: EdshObservationLaboratoryBilirubineConjuguee
Usage: #example
Description: "Exemple de EdshObservationLaboratoryBilirubineConjuguee : bilirubine conjuguée de Madame Dupont."

* status = #final
* subject = Reference(Patient/cas1-pat-01)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 3.4 'umol/L'
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #umol/L
