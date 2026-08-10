Cette ressource `Questionnaire` est le livrable central de l'étape **Formalisation** de la
méthode en trois étapes du guide (voir
[Standardisation du socle commun](use-core-variables-process.html)) : elle traduit le
[modèle conceptuel et le glossaire métier](use-core-variables-acquisition.html) issus de
l'étape d'acquisition en un modèle logique calculable, directement dérivé des
[exigences de l'usage **Variables socles pour les EDSH** (fichier MSExcel)](DocumentReference-CoreExigences.html)
du GT « Standards et Interopérabilité ».

Chaque item porte, dans sa hiérarchie, le concept métier qu'il capture ; les items
`display` associés portent l'intention métier (la justification du GT pour la donnée),
reprise du dictionnaire de données. Ce Questionnaire est ensuite instancié en une
`QuestionnaireResponse` par cas d'usage (voir les 10 exemples ci-dessous), et sert de
source à la StructureMap [`Q2FSL`](StructureMap-Q2FSL.html) pour l'étape de
**Standardisation** : c'est elle qui transforme mécaniquement chaque `QuestionnaireResponse`
en un `Bundle` de ressources FHIR conformes aux profils du socle.

Le Questionnaire est organisé en 5 groupes de premier niveau, reflétant les 5 catégories du
[dictionnaire de données](data-dictionary.html) :

- **Données socio-démographiques** — identité patient (dont NIR, INS, rang gémellaire) et
  environnement (géocodage, IRIS).
- **Données PMSI** — âge, sexe, code géographique de résidence, diagnostics, actes, dates
  et modes d'entrée/de sortie de séjour.
- **Biologie** — fonction rénale, hémogramme, bilan hépatique et autres analyses (glycémie
  à jeun, hémoglobine glyquée).
- **Exposition médicamenteuse** — médicament prescrit et administré, posologie et dosage.
- **Examen clinique** — dossier de soins (taille, poids, pression artérielle) et style de
  vie (tabac, alcool, autres drogues, activité physique — voir la note sur le lot 2 dans le
  [dictionnaire de données](data-dictionary.html)).
