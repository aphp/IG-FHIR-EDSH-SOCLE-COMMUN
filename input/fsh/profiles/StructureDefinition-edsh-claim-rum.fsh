Profile: EdshClaimRum
Parent: EdshClaimPmsiMco
Id: edsh-claim-rum
Title: "RUM du PMSI MCO"
Description: "Profil pour les Résumés d'Unité Médicale (RUM) du PMSI MCO."

* extension contains
    EdshDrg named DRG 0..1
    and EdshItemRank named ItemRank 1..1

* subType 1..1
* subType = FrClaimType#RUM

* billablePeriod.start ^short = "date d'entrée dans la première unité médicale visitée"
* billablePeriod.end ^short = "date de sortie de la dernière unité médicale visitée"
* billablePeriod MS

* diagnosis MS
* diagnosis ^slicing.discriminator[+].type = #value
* diagnosis ^slicing.discriminator[=].path = "type"
* diagnosis ^slicing.description = "slicing permettant de préciser le binding terminologique des codes diagnostics en fonction de leur type"
* diagnosis ^slicing.rules = #open
* diagnosis contains
  dp 1..1 MS
  and dr 0..1 MS
  and da 0..* MS
  and dad 0..* MS

* diagnosis[dp]
  * diagnosis[x] only CodeableConcept
  * diagnosisCodeableConcept from EdshCim10DpVs
  * type = PmsiMcoDiagType#DP (exactly)

* diagnosis[dr]
  * diagnosis[x] only CodeableConcept
  * diagnosisCodeableConcept from EdshCim10DrVs
  * type = PmsiMcoDiagType#DR (exactly)

* diagnosis[da]
  * diagnosis[x] only CodeableConcept
  * diagnosisCodeableConcept from EdshCim10DaVs
  * type = PmsiMcoDiagType#DA (exactly)

* diagnosis[dad]
  * diagnosis[x] only CodeableConcept
  * diagnosisCodeableConcept from EdshCim10Vs
  * type = PmsiMcoDiagType#DAD (exactly)

* procedure MS
* procedure
  * procedure[x] only CodeableConcept
  * procedureCodeableConcept from CcamVs

* item.category from FrMcoClaimItemCategoryVs (required)

* item ^slicing.discriminator[+].type = #value
* item ^slicing.discriminator[=].path = "category"
* item ^slicing.rules = #open
* item ^slicing.description = "Slicing des items de claim"
* item contains
    RUMGrouped 0..1 MS
    and CCAMProcedure 0..* MS

* item[RUMGrouped]
  * category 1..1 
  * category = FrMcoClaimItemCategory#1    //RUM
  * productOrService from GhmVs (extensible)

  * modifier ^slicing.discriminator[+].type = #value
  * modifier ^slicing.discriminator[=].path = "coding.system"
  * modifier ^slicing.rules = #open
  * modifier ^slicing.description = "Slicing des modifier pour les items de type RUM"
  * modifier contains
    MDE 1..1 MS and
    MDS 1..1 MS

  * modifier[MDE] ^short = "Mode d'entrée du patient"
  * modifier[MDE].coding.system = "https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/CodeSystem/PmsiMcoMde"
  * modifier[MDE] from PmsiMcoMdeVs (required)

  * modifier[MDS] ^short = "Mode de sortie du patient"
  * modifier[MDS].coding.system = "https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/CodeSystem/PmsiMcoMds"
  * modifier[MDS] from PmsiMcoMdsVs (required)



* item[CCAMProcedure]
  * category 1..1
  * category = FrMcoClaimItemCategory#0    //Procédure
  * productOrService from CcamVs (extensible)

Instance: 6f9a35f2-9752-4a11-a4a1-027e0e34433a
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshClaimRum)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

