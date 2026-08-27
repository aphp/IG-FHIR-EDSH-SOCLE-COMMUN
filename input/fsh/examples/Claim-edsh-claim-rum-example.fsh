Instance: edsh-claim-rum-example
InstanceOf: EdshClaimRum
Usage: #example
Description: "Exemple de EdshClaimRum : RUM du séjour de Madame Dupont dans l'unité de cardiologie — un diagnostic principal, un diagnostic associé, un acte CCAM, GHM du RUM groupé, modes d'entrée et de sortie."

* status = #active
* type = FrClaimType#PMSIMCO
* subType = FrClaimType#RUM
* use = #claim
* patient = Reference(Patient/cas1-pat-01)
* created = "2024-01-14"
* provider.display = "AP-HP"
* priority = http://terminology.hl7.org/CodeSystem/processpriority#normal

* insurance.sequence = 1
* insurance.focal = true
* insurance.coverage.display = "Assurance Maladie"

* billablePeriod.start = "2024-01-10"
* billablePeriod.end = "2024-01-14"

* extension[ItemRank].valuePositiveInt = 1
* extension[DRG].extension[GHM].valueCodeableConcept = Ghm#05M09 "Insuffisances cardiaques et états de choc circulatoire"
* extension[DRG].extension[vClassif].valueString = "2024"

* diagnosis[dp].sequence = 1
* diagnosis[dp].diagnosisCodeableConcept = EdshCim10Cs#I10 "Hypertension essentielle"
* diagnosis[dp].type = PmsiMcoDiagType#DP

* diagnosis[da][0].sequence = 2
* diagnosis[da][0].diagnosisCodeableConcept = EdshCim10Cs#J41.1 "Bronchite chronique mucopurulente"
* diagnosis[da][0].type = PmsiMcoDiagType#DA

* procedure[0].sequence = 1
* procedure[0].procedureCodeableConcept = EdshCcamCs#DEQP003 "Électrocardiographie sur au moins 12 dérivations"

* item[RUMGrouped].sequence = 1
* item[RUMGrouped].category = FrMcoClaimItemCategory#1
* item[RUMGrouped].productOrService = Ghm#05M09 "Insuffisances cardiaques et états de choc circulatoire"
* item[RUMGrouped].modifier[MDE].coding.system = "https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/CodeSystem/PmsiMcoMde"
* item[RUMGrouped].modifier[MDE].coding.code = #6
* item[RUMGrouped].modifier[MDE].coding.display = "Mutation"
* item[RUMGrouped].modifier[MDS].coding.system = "https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/CodeSystem/PmsiMcoMds"
* item[RUMGrouped].modifier[MDS].coding.code = #8
* item[RUMGrouped].modifier[MDS].coding.display = "Domicile"

* item[CCAMProcedure].sequence = 2
* item[CCAMProcedure].category = FrMcoClaimItemCategory#0
* item[CCAMProcedure].productOrService = EdshCcamCs#DEQP003 "Électrocardiographie sur au moins 12 dérivations"
