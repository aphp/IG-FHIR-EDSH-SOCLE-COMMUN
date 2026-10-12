Instance: edsh-observation-laboratory-tca-example
InstanceOf: EdshObservationLaboratoryTca
Usage: #example
Description: "TCA de Madame Dupont"

* status = #final
* subject = Reference(Patient/cas1-pat-01)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"

* component[PatientTCA].code = $loinc#14979-9
* component[PatientTCA].valueQuantity = 34 's' "s"

* component[ControlTCA].code = $loinc#13488-2
* component[ControlTCA].valueQuantity = 30 's' "s"

* component[TCARatioPonC].code = $loinc#63561-5
* component[TCARatioPonC].valueQuantity.value = 1.13
