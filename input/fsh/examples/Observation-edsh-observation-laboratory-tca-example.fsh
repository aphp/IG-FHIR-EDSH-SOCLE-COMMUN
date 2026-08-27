Instance: edsh-observation-laboratory-tca-example
InstanceOf: EdshObservationLaboratoryTca
Usage: #example
Description: "Exemple de EdshObservationLaboratoryTca : panel TCA de Madame Dupont — temps patient, temps témoin et ratio."

* status = #final
* subject = Reference(Patient/cas1-pat-01)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"

* component[PatientTCA].code = $loinc#14979-9
* component[PatientTCA].valueQuantity = 34 's'
* component[PatientTCA].valueQuantity.system = "http://unitsofmeasure.org"
* component[PatientTCA].valueQuantity.code = #s

* component[ControlTCA].code = $loinc#13488-2
* component[ControlTCA].valueQuantity = 30 's'
* component[ControlTCA].valueQuantity.system = "http://unitsofmeasure.org"
* component[ControlTCA].valueQuantity.code = #s

* component[TCARatioPonC].code = $loinc#63561-5
* component[TCARatioPonC].valueQuantity = 1.13 '1'
* component[TCARatioPonC].valueQuantity.system = "http://unitsofmeasure.org"
* component[TCARatioPonC].valueQuantity.code = #1
