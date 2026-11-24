Instance: edsh-medication-request-example
InstanceOf: EdshMedicationRequest
Title: "Exemple — Paracétamol si douleur pour Paul Durand"
Usage: #example
Description: "Exemple de EdshMedicationRequest : prescription conditionnelle de paracétamol (Doliprane 1000 mg, comprimé effervescent sécable) pour Paul Durand, en cas de douleur. Le médicament est codé en ATC, granularité retenue par le socle, et en UCD. La posologie porte les trois types de données UCUM du guide : FrRangeUcum (dose par prise), FrRatioUcum (dose maximale par période) et FrSimpleQuantityUcum (bornes de cet intervalle et de ce rapport, dose maximale par administration)."

* status = #active
* intent = #order
* medicationCodeableConcept
  * coding[0] = http://www.whocc.no/atc#N02BE01 "paracetamol"
  * coding[+] = http://data.esante.gouv.fr/ansm/medicament/UCD#3400892169026 "DOLIPRANE 1000MG CPR EFFV"
  * text = "Doliprane 1000 mg, comprimé effervescent sécable"
* subject = Reference(edsh-patient-example)
* authoredOn = "2024-01-10T09:00:00+01:00"
* requester = Reference(edsh-practitioner-role-example)
* dosageInstruction[0]
  * text = "Paracétamol per os si douleur : 1/2 comprimé (500 mg) si EVA < 4, 1 comprimé (1 g) si EVA ≥ 4. Au moins 6 h entre deux prises, 1 g par prise et 3 g par 24 h au maximum."
  * asNeededCodeableConcept = $sct#22253000 "douleur"
    * text = "Si douleur : 500 mg si EVA < 4, 1 g si EVA ≥ 4"
  * timing.repeat
    * frequencyMax = 1
    * period = 6
    * periodUnit = #h
  * route = $sct#26643006 "voie orale"
  * doseAndRate[0]
    * doseRange
      * low = 500 'mg' "mg"
      * high = 1000 'mg' "mg"
  * maxDosePerPeriod
    * numerator = 3 'g' "g"
    * denominator = 24 'h' "h"
  * maxDosePerAdministration = 1000 'mg' "mg"
