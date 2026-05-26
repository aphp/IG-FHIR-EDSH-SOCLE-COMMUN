### Introduction

Ce guide d'implémentation a pour objet de :

- lister les données sélectionnées par le groupe de travail “standards et interopérabilité” lancé en janvier 2024 
- proposer un processus de modélisation
- présenter la modélisation cible FHIR retenue pour les données du socle

Cette standardisation FHIR doit permettre de dériver les données dans les nombreux formats utiles aux différents projets de recherche (par exemple OMOP). La méthode de dérivation est décrite dans le guide d'implémentation **[Data Management with FHIR](https://aphp.github.io/IG-fhir-dm/)**

### Gouvernance

Le guide d'implémentation **Données socles des Entrepôts de Données de Santé Hospitalier** est géré par le domaine Management Stratégique des Données de la Direction des Services Numériques (DSN) de l'AP-HP.

### Outils

Pour supporter l'approche, plusieurs outils sont facilitant notamment :

* [FHIR IG Publisher](https://github.com/HL7/fhir-ig-publisher) : le FHIR IG Publisher permet la construction des guides d'implémentation notamment il valide les ressources de conformité et produit un [rapport qualité](qa.html)
* [FHIR MapBuilder](https://github.com/aphp/fhir-mapbuilder) : le FHIR MapBuilder facilite l'édition de fichier [FHIR Mapping Language (FML)](glossary.html#fml) permettant notamment de documenter le linéage colonne entre deux définition de structure (`StructureDefinition`).
* [AP-HP FormBuilder](https://github.com/aphp/formbuilder) : le AP-HP FormBuilder est un éditeur de ressource `Questionnaire` permettant notamment de définir un recceuil d'information. Dans le contexte de l'approche, deux usages sont référencés, (i) conception d'un formulaire du (pour le) SIH, (ii) édition d'un modèle logique issue d'un modèle conceptuel pour un cas d'usage.

### Organisation du guide

Le guide d'implémentation **Données socles des Entrepôts de Données de Santé Hospitalier** s'appuie sur l'outil [HL7 FHIR IG Publisher](https://github.com/HL7/fhir-ig-publisher) impactant le rendu. Dans la barre de navigation où se trouve les entrées de premier niveau du guide. Les entrées sont :

1. Accueil (cette page)
2. [Dictionnaire de données](data-dictionary.html) : présente les données du socle
3. [Variables du socle commun](use-core-variables-process.html) : présente le processus de standardisation des données du socle au format **FHIR**
4. Guide : propose plusieurs ressources d'aide
5. [Ressources FHIR](artifacts.html) : présente tous les artefacts FHIR du présent guide d'implémentation
6. Plus

### Auteurs et contributeurs

| Rôle | Nom | Organisation | Contact |
|------|-----|--------------|---------|
| **Primary Editor** | Christel Gérardin | Assistance Publique - Hôpitaux de Paris | christel.gerardin@aphp.fr |
| **Primary Editor** | David Ouagne | Assistance Publique - Hôpitaux de Paris | david.ouagne@aphp.fr |
| **Primary Editor** | Nicolas Griffon | Assistance Publique - Hôpitaux de Paris | nicolas.griffon@aphp.fr |
{: .grid}

### Dépendances

{% include dependency-table.xhtml %}
