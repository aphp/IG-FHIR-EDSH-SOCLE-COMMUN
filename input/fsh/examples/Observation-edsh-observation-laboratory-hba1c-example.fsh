Instance: edsh-observation-laboratory-hba1c-example
InstanceOf: EdshObservationLaboratoryHba1c
Usage: #example
Description: "Exemple de EdshObservationLaboratoryHba1c : hémoglobine glyquée (hba1c) de Madame Dupont."

* status = #final
* subject = Reference(Patient/cas1-pat-01)
* performer = Reference(edsh-organization-example)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 6.1 '%' "%"
