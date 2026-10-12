Profile: EdshObservationLaboratoryGeneric
Parent: Observation // pas de profil ANS (et le profil mesure glucose me semble inadapté), pas de profil FHIR, uscore propose un profil lab générique.
Id: edsh-observation-laboratory-generic
Title: "Résultat de laboratoire"
Description: """
Profil générique des résultats de laboratoire du socle commun des EDSH. Parent abstrait
de tous les profils analytes (hémoglobine, créatininémie, TCA…). Il porte les contraintes
et la documentation communes à tout résultat de biologie : catégorie `laboratory`, code
LOINC, patient, date de prélèvement, valeur, et structure `component` pour les panels.
Un profil analyte enfant ne redocumente pas ces éléments : il ne documente que le code
LOINC qu'il fixe et l'unité de résultat qu'il impose.
"""

* ^abstract = true

// status : le GT socle demande la transmission du statut du résultat ; il n'est pas
// restreint ici car le modèle cible OMOP n'a pas d'emplacement équivalent.

* category ^short = "Catégorie de l'observation : toujours « laboratory »"
* category ^comment = "Cardinalité resserrée à 1..1 (base FHIR 0..*) : tout résultat de laboratoire du socle est catégorisé « laboratory », exactement une fois. Contrainte structurante du profil générique dont dérivent tous les profils analytes."
* category 1..1
* category = $observation-category#laboratory (exactly)

* code ^short = "Analyte mesuré, codé en LOINC"
* code ^definition = "Code LOINC identifiant l'analyte. Chaque profil analyte enfant fixe ce code à une valeur exacte ; le jeu de valeurs `EdshLaboratory` liste l'ensemble des analytes du socle."
* code from EdshLaboratory (required)

* subject ^short = "Patient sur lequel porte l'analyse"
* subject only Reference(Patient or Group or Device or Location or FRCorePatientProfile or FRCoreLocationProfile or EdshPatient or EdshLocation)
* encounter ^short = "Passage au cours duquel le prélèvement est réalisé"
* encounter only Reference(Encounter or FRCoreEncounterProfile or EdshEncounter)
* performer ^short = "Laboratoire ou intervenant responsable du résultat"
* performer only Reference(Practitioner or PractitionerRole or Organization or CareTeam or Patient or RelatedPerson or FRCorePractitionerProfile or FRCorePractitionerRole or FRCoreOrganizationProfile or FRCorePatientProfile or FRCoreRelatedPersonProfile or EdshPractitioner or EdshPractitionerRole or EdshOrganization or EdshPatient)

* effective[x] ^short = "Date, et heure si connue, du prélèvement"

* value[x] ^short = "Résultat mesuré. Reste vide au niveau racine pour un profil de panel — voir `component`."
* referenceRange ^short = "Intervalle de référence, tel que fourni par le laboratoire"

* obeys dm-lab-1
* obeys dm-lab-2
* obeys dm-lab-3
* obeys dm-lab-4
* obeys dm-lab-5
* obeys dm-lab-6

* component ^short = "Résultats élémentaires d'un panel (ex. temps patient / témoin / ratio d'un TCA)"
* component.code ^short = "Analyte du composant, codé en LOINC"
* component.code from EdshLaboratory (required)
* component.value[x] ^short = "Résultat mesuré du composant"
* component.referenceRange ^short = "Intervalle de référence du composant, tel que fourni par le laboratoire"

Instance: 1f3e2728-1d70-4ca7-ac28-a4c1b11c4b80
InstanceOf: Provenance
Title: "WIP adding EDSH vars"
Description: """WIP adding EDSH vars"""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryGeneric)
* occurredDateTime = "2025-03-24"
* reason.text = """WIP adding EDSH vars"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2025-03-24T09:26:15+01:00"

Instance: 3d3aae22-f72c-4bcc-b221-24116eb5458b
InstanceOf: Provenance
Title: "Remédiation robustesse Core (PR1)"
Description: """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core) ; élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryGeneric)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19) : retrait des Must Support (principe de robustesse d'un IG Core) ; élargissement des bornes Reference : cibles autorisées par le parent, puis profil FR Core s'il existe, puis profil Edsh (#21, revue PR #27)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"

Instance: 196f8a2a-afe0-418a-a999-c65c523d5b07
InstanceOf: Provenance
Title: "Documentation des éléments (PR2)"
Description: """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; justification de la cardinalité de category (#22) ; referenceRange documenté comme component.referenceRange (revue PR #28)."""
Usage: #definition

* target[0] = Reference(EdshObservationLaboratoryGeneric)
* occurredDateTime = "2026-10-12"
* reason.text = """Remédiation robustesse (#19), PR2 : Documentation des éléments contraints au niveau B2 (#23 : ^short, ^definition, ^comment) ; justification de la cardinalité de category (#22) ; referenceRange documenté comme component.referenceRange (revue PR #28)."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T14:00:00+02:00"
