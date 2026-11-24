Instance: edsh-observation-laboratory-glycemie-a-jeun-example
InstanceOf: EdshObservationLaboratoryGlycemieAJeun
Title: "Exemple — la glycémie à jeun"
Usage: #example
Description: "Exemple de EdshObservationLaboratoryGlycemieAJeun : glycémie à jeun de Paul Durand."

* status = #final
* subject = Reference(edsh-patient-example)
* performer = Reference(edsh-organization-example)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
* valueQuantity = 5.2 'mmol/L' "mmol/L"
* referenceRange[0]
  * low = 3.9 'mmol/L' "mmol/L"
  * high = 6.1 'mmol/L' "mmol/L"
  * text = "3,9 à 6,1 mmol/L"
