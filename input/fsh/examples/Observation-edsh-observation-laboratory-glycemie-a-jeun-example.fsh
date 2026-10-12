Instance: edsh-observation-laboratory-glycemie-a-jeun-example
InstanceOf: EdshObservationLaboratoryGlycemieAJeun
Usage: #example
Description: "Exemple de EdshObservationLaboratoryGlycemieAJeun : glycémie à jeun de Madame Dupont."

* status = #final
* subject = Reference(Patient/cas1-pat-01)
* performer = Reference(edsh-organization-example)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 5.2 'mmol/L' "mmol/L"
