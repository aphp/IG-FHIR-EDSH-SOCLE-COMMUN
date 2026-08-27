Instance: edsh-observation-laboratory-vgm-example
InstanceOf: EdshObservationLaboratoryVgm
Usage: #example
Description: "Exemple de EdshObservationLaboratoryVgm : volume globulaire moyen de Madame Dupont."

* status = #final
* subject = Reference(Patient/cas1-pat-01)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 90 'fL'
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #fL
