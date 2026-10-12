Profile: EdshClaimRum
Parent: EdshClaimPmsiMco
Id: edsh-claim-rum
Title: "RUM du PMSI MCO"
Description: """
Profil pour les Résumés d'Unité Médicale (RUM) du PMSI MCO. Un RUM décrit le passage d'un
patient dans une unité médicale : période, diagnostics (principal, relié, associés), actes
CCAM, GHM du RUM groupé, modes d'entrée et de sortie. Les données parviennent à l'EDS
après groupage ATIH ; les cardinalités resserrées ci-dessous reflètent des champs que ce
groupage rend obligatoires.
"""

* extension contains
    EdshDrg named DRG 0..1
    and EdshItemRank named ItemRank 1..1
* extension[DRG] ^short = "Groupe homogène de malades (GHM) attribué au RUM par le groupage ATIH"
* extension[ItemRank] ^short = "Rang du RUM dans le séjour"
* extension[ItemRank] ^comment = "Cardinalité de slice 1..1 : le rang du RUM dans le séjour est un identifiant obligatoire du RUM dans le PMSI MCO (données post-groupage ATIH)."

* subType ^short = "Type de résumé : toujours RUM"
* subType ^comment = "Cardinalité resserrée à 1..1 (base FHIR 0..1) : un RUM du PMSI MCO porte toujours exactement un type de résumé. Données parvenant à l'EDS après groupage ATIH, où ce champ est réglementairement obligatoire."
* subType 1..1
* subType = FrClaimType#RUM

* billablePeriod ^short = "Période couverte par le RUM : séjour du patient dans l'unité médicale"
* billablePeriod.start ^short = "Date d'entrée dans l'unité médicale"
* billablePeriod.end ^short = "Date de sortie de l'unité médicale"

* diagnosis ^short = "Diagnostics du RUM, tranchés par type (DP, DR, DA, DAD)"
* diagnosis ^definition = "Chaque tranche fixe le type de diagnostic et le jeu de valeurs CIM-10 applicable. Le slicing est ouvert : d'autres diagnostics hors socle peuvent coexister."
* diagnosis ^slicing.discriminator[+].type = #value
* diagnosis ^slicing.discriminator[=].path = "type"
* diagnosis ^slicing.description = "slicing permettant de préciser le binding terminologique des codes diagnostics en fonction de leur type"
* diagnosis ^slicing.rules = #open
* diagnosis contains
  dp 1..1
  and dr 0..1
  and da 0..*
  and dad 0..*

* diagnosis[dp] ^short = "Diagnostic principal (DP)"
* diagnosis[dp] ^definition = "Problème de santé qui a motivé l'admission du patient dans l'unité médicale (UM), pris en charge pendant le séjour et déterminé à la sortie de celle-ci (guide méthodologique du PMSI MCO). Exactement un par RUM."
* diagnosis[dp] ^comment = "Cardinalité de slice 1..1 : tout RUM du PMSI MCO comporte exactement un diagnostic principal (DP). Contrainte réglementaire ATIH, garantie sur les données parvenant à l'EDS."
* diagnosis[dp]
  * diagnosis[x] only CodeableConcept
  * diagnosisCodeableConcept from EdshCim10DpVs
  * type = PmsiMcoDiagType#DP (exactly)

* diagnosis[dr] ^short = "Diagnostic relié (DR)"
* diagnosis[dr] ^definition = "Affection chronique ou de longue durée, ou état permanent, éclairant le contexte du DP lorsque celui-ci n'y suffit pas seul. Au plus un par RUM."
* diagnosis[dr]
  * diagnosis[x] only CodeableConcept
  * diagnosisCodeableConcept from EdshCim10DrVs
  * type = PmsiMcoDiagType#DR (exactly)

* diagnosis[da] ^short = "Diagnostic associé significatif (DAS)"
* diagnosis[da] ^definition = "Affection, symptôme ou autre motif de recours coexistant avec le DP et représentant un effort de prise en charge supplémentaire."
* diagnosis[da]
  * diagnosis[x] only CodeableConcept
  * diagnosisCodeableConcept from EdshCim10DaVs
  * type = PmsiMcoDiagType#DA (exactly)

* diagnosis[dad] ^short = "Donnée à visée documentaire (DAD)"
* diagnosis[dad] ^definition = "Code CIM-10 porté pour la traçabilité, sans effet sur le groupage."
* diagnosis[dad]
  * diagnosis[x] only CodeableConcept
  * diagnosisCodeableConcept from EdshCim10Vs
  * type = PmsiMcoDiagType#DAD (exactly)

* procedure ^short = "Actes CCAM réalisés pendant le séjour dans l'unité médicale"
* procedure
  * procedure[x] only CodeableConcept
  * procedureCodeableConcept from CcamVs

* item ^short = "Lignes du RUM, tranchées par catégorie : le RUM groupé (GHM) et les actes CCAM"
* item.category ^short = "Catégorie de la ligne : RUM groupé ou acte CCAM"
* item.category from FrMcoClaimItemCategoryVs (required)

* item ^slicing.discriminator[+].type = #value
* item ^slicing.discriminator[=].path = "category"
* item ^slicing.rules = #open
* item ^slicing.description = "Slicing des items de claim"
* item contains
    RUMGrouped 0..1
    and CCAMProcedure 0..*

* item[RUMGrouped] ^short = "Ligne du RUM groupé : porte le GHM et les modes d'entrée / sortie"
* item[CCAMProcedure] ^short = "Ligne d'acte CCAM"

* item[RUMGrouped]
  * category ^comment = "Cardinalité resserrée à 1..1 (base FHIR 0..1) : `category` est l'élément discriminant du slicing de `item` et sa valeur est figée pour cette slice. Le 1..1 est requis par la mécanique de slicing par valeur, non par un choix métier."
  * category 1..1
  * category = FrMcoClaimItemCategory#1    //RUM
  * productOrService ^short = "GHM attribué au RUM groupé"
  * productOrService from GhmVs (extensible)

  * modifier ^short = "Modes d'entrée et de sortie du patient dans l'unité médicale"
  * modifier ^slicing.discriminator[+].type = #value
  * modifier ^slicing.discriminator[=].path = "coding.system"
  * modifier ^slicing.rules = #open
  * modifier ^slicing.description = "Slicing des modifier pour les items de type RUM"
  * modifier contains
    MDE 1..1 and
    MDS 1..1

  * modifier[MDE] ^short = "Mode d'entrée du patient"
  * modifier[MDE] ^comment = "Cardinalité de slice 1..1 : le mode d'entrée du patient dans l'unité médicale est un attribut obligatoire du RUM dans le PMSI MCO (données post-groupage ATIH)."
  * modifier[MDE].coding.system = "https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/CodeSystem/PmsiMcoMde"
  * modifier[MDE] from PmsiMcoMdeVs (required)

  * modifier[MDS] ^short = "Mode de sortie du patient"
  * modifier[MDS] ^comment = "Cardinalité de slice 1..1 : le mode de sortie du patient de l'unité médicale est un attribut obligatoire du RUM dans le PMSI MCO (données post-groupage ATIH)."
  * modifier[MDS].coding.system = "https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/CodeSystem/PmsiMcoMds"
  * modifier[MDS] from PmsiMcoMdsVs (required)



* item[CCAMProcedure]
  * category ^comment = "Cardinalité resserrée à 1..1 (base FHIR 0..1) : `category` est l'élément discriminant du slicing de `item` et sa valeur est figée pour cette slice. Le 1..1 est requis par la mécanique de slicing par valeur, non par un choix métier."
  * category 1..1
  * category = FrMcoClaimItemCategory#0    //Procédure
  * productOrService ^short = "Code CCAM de l'acte"
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

Instance: c23a84d4-852c-4a76-b7be-d173cc71cd9d
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core)."""
Usage: #definition

* target[0] = Reference(EdshClaimRum)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"

Instance: 2643f6f1-5ef0-4854-b165-a3e82c22442e
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; justification des cardinalités conservées (#22) ; définitions du DP et du DR alignées sur le guide méthodologique du PMSI MCO ; billablePeriod ramené à l'unité médicale (revue PR #28)."""
Usage: #definition

* target[0] = Reference(EdshClaimRum)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; justification des cardinalités conservées (#22) ; définitions du DP et du DR alignées sur le guide méthodologique du PMSI MCO ; billablePeriod ramené à l'unité médicale (revue PR #28)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
