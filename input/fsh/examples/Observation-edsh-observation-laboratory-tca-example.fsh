Instance: edsh-observation-laboratory-tca-example
InstanceOf: EdshObservationLaboratoryTca
Title: "Exemple — TCA de Paul Durand"
Usage: #example
Description: "Exemple de EdshObservationLaboratoryTca : TCA de Paul Durand."

* insert EdshLaboratoryExampleContext

* component[PatientTCA].code = $loinc#14979-9
* component[PatientTCA].valueQuantity = 34 's' "s"

* component[ControlTCA].code = $loinc#13488-2
* component[ControlTCA].valueQuantity = 30 's' "s"

* component[TCARatioPonC].code = $loinc#63561-5
* component[TCARatioPonC].valueQuantity = 1.13 '1' "1"
* component[TCARatioPonC].referenceRange[0]
  * high = 1.2 '1' "1"
  * text = "< 1,2"
