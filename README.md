# Guide d'Implémentation FHIR — Données socles des Entrepôts de Données de Santé Hospitalier (EDSH)

Ce référentiel contient le guide d'implémentation (IG) **`aphp.fhir.fr.edsh`**, publié à
<https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN>. Un IG est « un ensemble de règles sur
comment les ressources FHIR sont utilisées (ou devraient être utilisées) pour résoudre un
problème particulier, avec la documentation associée pour supporter et clarifier les
usages » ([source](https://www.hl7.org/fhir/implementationguide.html)).

Ce guide décrit : (i) les données socles sélectionnées par le groupe de travail sur les
EDSH, (ii) la méthode de modélisation de ces données et, (iii) les profils FHIR cible. La
dérivation de ces données vers d'autres formats utiles à la recherche (par exemple OMOP)
est traitée séparément dans le guide d'implémentation
**[Data Management with FHIR](https://aphp.github.io/IG-fhir-dm/)**, qui dépend de ce
guide.

## Contexte

### Contexte métier du projet

Le développement de l'usage secondaire des données de soins en France, porté notamment par
les Entrepôts de Données de Santé Hospitalier (EDSH), justifie l'harmonisation d'un socle
de données commun entre établissements — une étape vers la consolidation d'un patrimoine
national des données de santé et un rapprochement avec le Système National des Données de
Santé (SNDS).

Le **groupe de travail « Standards et Interopérabilité »**, mandaté en janvier 2023 par le
comité stratégique des données de santé, propose que l'ensemble des EDS hospitaliers du
territoire national adoptent un **socle commun de 51 items**, permettant de caractériser
tout patient et tout séjour, quel que soit le motif de recours aux soins. Ce socle est
découpé en deux lots :

- **Lot 1 (prioritaire)** — les catégories de données jugées suffisamment structurées et
  fiables dans les systèmes d'information hospitaliers (SIH) :
  - **PMSI** : 9 items génériques issus des recueils PMSI, dont la collecte doit rester
    durable et indépendante du modèle de financement des hôpitaux ;
  - **Socio-démographiques** : NIR, INS, adresse géocodée — des clés d'appariement direct
    avec le SNDS et les bases environnementales/sociales, pour l'analyse des déterminants
    sociaux ou environnementaux de santé ;
  - **Prescription et administration médicamenteuses** : une vision de l'exposition
    médicamenteuse sur le parcours, en complément des données de ville du SNDS ;
  - **Résultats de biologie médicale** : 23 items d'examens de routine, dont l'hémogramme,
    une caractérisation des fonctions rénale et hépatique et du bilan glycémique ;
  - **Examen clinique** : un nombre volontairement limité d'items (taille, poids, pression
    artérielle), non disponibles ailleurs dans les grandes bases nationales.
- **Lot 2** — 4 items de comportements à risque (consommation de tabac, consommation
  d'alcool, autres addictions, activité physique). Le recueil de ces données reste
  aujourd'hui insuffisamment structuré dans les SIH ; leur formalisation nécessite des
  travaux complémentaires s'appuyant sur EHIS (enquête européenne) et le baromètre de Santé
  publique France. **Ce lot ne peut donc pas être mis en œuvre simultanément avec le
  lot 1** (voir « Travaux en cours et limites connues » ci-dessous).

### Contexte technique du projet

Le guide est développé en **FHIR R4 (4.0.1)** et dépend de trois IG publics : le module
**Structured Data Capture** (`hl7.fhir.uv.sdc`, pour la ressource `Questionnaire`), le
**FR Core** de l'ANS (`hl7.fhir.fr.core`) et l'**annuaire ANS** (`ans.fhir.fr.annuaire`,
pour les profils `Organization`/`Practitioner`/`Location`). Les versions exactes figurent
dans `sushi-config.yaml`.

Le guide s'inscrit dans la méthode **« Data Management with FHIR »**, également utilisée
par le guide [IG-fhir-dm](https://aphp.github.io/IG-fhir-dm/), qui en est à la fois
l'origine méthodologique et un guide consommateur (il dépend de `aphp.fhir.fr.edsh`).

## Contenu du guide

### Les données socles

Les 51 items du socle sont regroupés en 6 catégories, chacune étant standardisée sous la
forme d'un ou plusieurs profils FHIR (voir le
[dictionnaire de données](https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/data-dictionary.html)
publié pour le détail complet) :

| Groupe | Nb. de variables | Exemples |
| --- | --- | --- |
| Identité patient | 1 | Patient (seule donnée classée « donnée maître ») |
| PMSI | 3 | Séjour, Diagnostic CIM-10, Acte CCAM |
| Résultats d'examens biologiques | 23 | Hémogramme, fonction rénale, bilan hépatique, bilan glycémique |
| Exposition médicamenteuse | 2 | Médicament prescrit, médicament administré |
| Dossier de soin | 3 | Poids, taille, pression artérielle |
| Style de vie (lot 2) | 4 | Tabac, alcool, autres drogues, activité physique |

### La méthode en trois étapes

La méthodologie **Data Management with FHIR** s'appuie sur l'**ingénierie dirigée par les
modèles (Model-Driven Engineering)** appliquée aux données de santé. Elle se déroule en
trois étapes, chacune produisant des livrables publiés dans ce guide :

| Étape | Objet | Livrables publiés |
| --- | --- | --- |
| **1. [Acquisition](https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/use-core-variables-acquisition.html)** | Recueillir le besoin avec les experts métier | Modèle conceptuel, glossaire métier (40 concepts), 10 exemples cliniques annotés |
| **2. [Formalisation](https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/use-core-variables-formalization.html)** | Traduire le modèle conceptuel en modèle logique calculable | Ressource `Questionnaire/UsageCore` (5 groupes de variables), 10 `QuestionnaireResponse` |
| **3. [Standardisation](https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/use-core-variables-standardization.html)** | Aligner le modèle logique sur des profils FHIR cible | 52 profils FHIR, `StructureMap/Q2FSL`, exemples de conformité générés |

Le `Questionnaire/UsageCore` (« Questionnaire usage Variables socles pour les EDSH ») a été
édité avec l'[AP-HP FormBuilder](https://github.com/aphp/formbuilder). La transformation
d'une `QuestionnaireResponse` en ressources FHIR conformes aux profils du socle est
automatisée par une **StructureMap FML nommée `Q2FSL`** (« Questionnaire to FHIR Semantic
Layer », `input/fml/StructureMap-Q2FSL.fml`), éditée avec le
[FHIR MapBuilder](https://github.com/aphp/fhir-mapbuilder).

### Les artefacts FHIR

Les profils du guide (`input/fsh/profiles/`) se regroupent en sept familles :

- **Administratif** — `EdshPatient` (avec identifiant INS-NIR), `EdshEncounter`,
  `EdshEpisodeOfCare`, `EdshOrganization`, `EdshLocation`, `EdshPractitioner(Role)` —
  dérivés des profils FR Core et de l'annuaire ANS.
- **PMSI** — une hiérarchie de `Claim` (`EdshClaimPmsi` → `EdshClaimPmsiMco` →
  `EdshClaimRum`) modélisant un Résumé d'Unité Médicale (RUM), avec diagnostics tranchés
  par type (DP/DR/DA/DAD), actes CCAM et groupage GHM.
- **Biologie** — un profil abstrait `EdshObservationLaboratoryGeneric` spécialisé en
  22 profils par analyte (hémogramme, hémostase, bilan hépatique, fonction rénale,
  métabolisme glucidique), liés à un ValueSet LOINC de 31 codes et soumis à 6 invariants
  imposant l'unité UCUM.
- **Signes vitaux** — taille, poids, pression artérielle (dérivés de FR Core).
- **Style de vie** — tabac, alcool, autres drogues, activité physique (lot 2).
- **Médicament** — `EdshMedicationRequest`/`EdshMedicationAdministration`, et quatre
  profils `FrMedication*` (UCD, dénomination commune, préparation, partie d'UCD multiple).
- **Types de données** — une `EdshAddress` (géolocalisation, IRIS, code géographique PMSI)
  et trois types quantitatifs contraints en UCUM.

Terminologies mobilisées : **SNOMED CT, LOINC, UCUM, CIM-10** (OMS et ATIH), **CCAM,
GHM**, et **UCD** (via PHAST), complétées par 14 CodeSystems locaux à l'IG (dont un
CodeSystem des codes géographiques de résidence PMSI, à 6 665 concepts).

### Les dix cas d'usage

Dix scénarios cliniques (`cas-1` à `cas-10`, un patient et une prise en charge par cas —
infarctus du myocarde, ulcère gastrique, accouchement, choc cardiogénique, pyélonéphrite
aiguë, suivi de cardiopathie ischémique, état de mal migraineux, fracture fémorale,
ponction d'ascite, exacerbation de BPCO) servent de fil rouge tout au long des trois
étapes : rédigés en prose annotée à l'étape d'acquisition, saisis comme
`QuestionnaireResponse` à l'étape de formalisation, puis transformés par `Q2FSL` en
ressources FHIR conformes à l'étape de standardisation. Ils constituent le jeu de test de
bout en bout du guide.

## Construction de l'IG

« Construction de l'IG » signifie générer une représentation web, lisible par un humain, des
informations structurées et de la documentation d'accompagnement définies dans ce
référentiel. Cela se fait via le
[FHIR Implementation Guide Publisher](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation)
(« IG Publisher »), un programme Java fourni par l'équipe FHIR pour la construction de
guides d'implémentation dans une présentation standardisée.

### Prérequis

1. Vous avez besoin d'[installer Java 21](https://adoptium.net/) ;
2. Vous avez besoin d'[installer Jekyll](https://jekyllrb.com/docs/installation/).

Contrairement à d'autres IG AP-HP, ce guide **ne dépend d'aucun package privé** : ses trois
dépendances (`hl7.fhir.uv.sdc`, `hl7.fhir.fr.core`, `ans.fhir.fr.annuaire`) sont toutes
publiques. Aucune configuration de registre FHIR AP-HP (`$USER/.fhir/fhir-settings.json`)
n'est donc nécessaire pour construire ce guide.

Si vous souhaitez le générer localement, ouvrez une fenêtre de commande et naviguez où le
référentiel a été cloné. Exécutez ensuite cette commande :

- Linux/macOS : `./gradlew buildIG`
- Windows : `.\gradlew.bat buildIG`

Ce script fera automatiquement deux choses pour vous :

1. Exécuter [SUSHI](https://fshschool.org/docs/sushi/). Ce guide est développé en
   [FHIR Shorthand (FSH)](http://build.fhir.org/ig/HL7/fhir-shorthand/), un langage
   spécifique de domaine (DSL) permettant de définir le contenu des FHIR IG. SUSHI
   transpile les fichiers FSH en fichiers JSON attendus par IG Publisher ;
2. Exécuter IG Publisher.

Vous aurez besoin d'une connexion Internet active pour construire l'IG. Cela prend jusqu'à
30 minutes pour la première construction ; les versions suivantes devraient être plus
rapides une fois le cache local établi.

Lorsque la construction est terminée, vous pouvez ouvrir `output/index.html` dans votre
navigateur pour voir l'IG construit localement.

### Exécution de SUSHI indépendamment de l'IG Publisher

Si vous souhaitez exécuter SUSHI sans construire l'intégralité de l'IG, vous pouvez
exécuter la tâche gradle `sushiBuild`.

### Obtenir une version propre

Bien que cela ne soit normalement pas nécessaire, vous pouvez exécuter la tâche gradle
`cleanIG` (ou `reBuildIG`, qui l'enchaîne avec un `buildIG`) pour supprimer les dossiers
générés/mis en cache : `fml-generated/`, `fsh-generated/`, `output/`, `temp/`, `template/`,
ainsi que **l'intégralité de `input-cache/`**, les artefacts Node (`node_modules/`,
`package.json`, `package-lock.json`) et le cache Gradle Node (`.gradle/nodejs`). Notez que
la suppression complète d'`input-cache/` augmente sensiblement le temps de la prochaine
construction.

### Répertoires et fichiers clés dans l'IG

- Les fichiers FHIR Shorthand (`.fsh`) définissant les ressources se trouvent dans
  `input/fsh/`, répartis par type d'artefact : `profiles/`, `profiles-datatypes/`,
  `extensions/`, `codesystems/`, `valueset/`, `invariants/`, `examples/`, `usages/`, ainsi
  que `aliases.fsh` et `provenances.fsh`.
  - Il existe une [extension de coloration syntaxique FSH](https://marketplace.visualstudio.com/items?itemName=MITRE-Health.vscode-language-fsh)
    pour [VSCode](https://code.visualstudio.com).
- `input/fml/StructureMap-Q2FSL.fml` : la StructureMap (FML) transformant une
  `QuestionnaireResponse` en `Bundle` de ressources conformes aux profils du socle.
- Les pages principales de l'IG construit sont générées à partir de
  [Markdown](https://daringfireball.net/projects/markdown/) trouvé dans
  `input/pagecontent/`. Ces pages doivent également être incluses dans `sushi-config.yaml`
  pour être compilées en HTML par l'IG Publisher.
- `input/resources/usages/core/` : les ressources JSON hand-authored, dont le
  `Questionnaire/UsageCore` et les 10 `QuestionnaireResponse` des cas d'usage ; les
  sous-dossiers `cas1/` à `cas10/` contiennent les ressources FHIR **générées par
  `Q2FSL`** à partir de ces `QuestionnaireResponse`.
- La source des diagrammes UML se trouve dans `input/images-source/` et DOIT avoir une
  extension `.plantuml`. Ceux-ci sont automatiquement convertis en SVG par l'IG Publisher
  et insérés en ligne dans les fichiers Markdown à l'aide de
  `{%include some-diagram.svg%}`.
- Il existe un certain nombre d'autres options de configuration importantes dans
  `sushi-config.yaml`, y compris le contenu du menu de l'IG construit.

### Dépendances du guide d'implémentation

Vous trouverez la liste des dépendances dans `sushi-config.yaml`, section `dependencies`.

## Validation des StructureMap

Dans les IG FHIR de l'AP-HP, les StructureMap sont rédigées en FML, disponibles dans le
dossier `input/fml`. Pour ce guide, il s'agit de `Q2FSL`.

La validation de ces FML recouvre :

- la transformation en ressource `StructureMap` ;
- la validation de la conformité de la ressource `StructureMap` ;
- l'exécution de l'opération `$transform` appliquant la ressource `StructureMap` à une
  source, et l'obtention d'une cible (`target`) ;
- la validation de la conformité de la cible au profil correspondant.

Plusieurs options permettent de couvrir ces niveaux de validation :

- le [plugin VSCode « FHIR MapBuilder »](https://github.com/aphp/fhir-mapbuilder) couvre
  les trois premiers niveaux de validation (sous réserve de disposer d'une source
  testable) et facilite la rédaction des maps grâce à ses fonctions de coloration
  syntaxique et d'aide au codage ;
- la [construction de l'IG](#construction-de-lig) génère la ressource `StructureMap` et
  valide la conformité des ressources (la `StructureMap`, et, si disponibles, les
  ressources source et cible) ;
- l'utilisation de la solution [Matchbox](https://github.com/ahdis/matchbox), plus
  complexe à mettre en œuvre.

## Travaux en cours et limites connues

- **Lot 2 (style de vie)** : la formalisation des variables de comportements à risque
  (tabac, alcool, autres drogues, activité physique) n'est pas achevée — leur définition
  précise nécessite des travaux complémentaires (voir « Contexte métier »). Les profils
  FHIR correspondants existent, mais aucun exemple conforme n'est encore publié.
- **Posologie** : les métadonnées de posologie médicamenteuse dépendent de travaux de
  l'ANS non encore livrés au moment de la rédaction de ce guide.
- **OMOP** : ce guide ne couvre pas la dérivation vers OMOP ; elle est décrite dans le
  guide [Data Management with FHIR](https://aphp.github.io/IG-fhir-dm/).

## Gouvernance et contributeurs

Ce guide d'implémentation est géré par le domaine **Management Stratégique des Données**
de la **Direction des Services Numériques (DSN)** de l'AP-HP.

| Rôle | Nom | Organisation |
| --- | --- | --- |
| Primary Editor | Christel Gérardin | AP-HP |
| Primary Editor | David Ouagne | AP-HP |
| Primary Editor | Nicolas Griffon | AP-HP |

## Acronymes

- IG : Implementation Guide
- FHIR : Fast Healthcare Interoperability Resources
- FIG : FHIR Implementation Guide
- HL7 : Health Level Seven
- AP-HP : Assistance Publique - Hôpitaux de Paris
- EDS : Entrepôt de Données de Santé
- EDSH : Entrepôt de Données de Santé Hospitalier
- GT : Groupe de Travail
- PMSI : Programme de Médicalisation des Systèmes d'Information
- SNDS : Système National des Données de Santé
