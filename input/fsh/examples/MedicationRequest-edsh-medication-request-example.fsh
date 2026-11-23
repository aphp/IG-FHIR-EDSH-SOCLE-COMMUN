Instance: edsh-medication-request-example
InstanceOf: EdshMedicationRequest
Title: "Exemple — Paracétamol IV pour Paul Durand"
Usage: #example
Description: "Exemple de EdshMedicationRequest : prescription de paracétamol intraveineux pour Paul Durand. La posologie porte les trois types de données UCUM du guide : FrRangeUcum (dose par prise), FrRatioUcum (débit, dose maximale par période) et FrSimpleQuantityUcum (bornes de ces intervalles et rapports, dose maximale par administration)."

* status = #active
* intent = #order
* medicationCodeableConcept = http://www.whocc.no/atc#N02BE01 "paracetamol"
* subject = Reference(edsh-patient-example)
* authoredOn = "2024-01-10T09:00:00+01:00"
* requester = Reference(edsh-practitioner-role-example)
* dosageInstruction[0]
  * text = "Paracétamol IV, 500 à 1000 mg par perfusion de 15 min, toutes les 6 h ; 1 g par administration et 4 g par 24 h au maximum."
  * timing.repeat
    * frequency = 1
    * period = 6
    * periodUnit = #h
  * route = $sct#47625008 "Intravenous route (qualifier value)"
  * doseAndRate[0]
    * doseRange
      * low = 500 'mg' "mg"
      * high = 1000 'mg' "mg"
    * rateRatio
      * numerator = 1000 'mg' "mg"
      * denominator = 15 'min' "min"
  * maxDosePerPeriod
    * numerator = 4 'g' "g"
    * denominator = 24 'h' "h"
  * maxDosePerAdministration = 1000 'mg' "mg"
