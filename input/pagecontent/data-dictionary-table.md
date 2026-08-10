
| Groupe | Données | Caractéristiques |
| ------ | ------- | ---------------- |
| Identité patient | [Patient](StructureDefinition-edsh-patient.html) | Données maîtres |
| PMSI | [Séjour](StructureDefinition-edsh-encounter.html) | Données d'intérêt |
| PMSI | [Diagnostic CIM10](StructureDefinition-edsh-condition.html) | Données d'intérêt |
| PMSI | [Acte CCAM](StructureDefinition-edsh-procedure.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Urémie](StructureDefinition-edsh-observation-laboratory-uremie.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Créatininémie](StructureDefinition-edsh-observation-laboratory-fonction-renale.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Débit de filtration glomérulaire (DFG)](StructureDefinition-edsh-observation-laboratory-fonction-renale.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Leucocytes](StructureDefinition-edsh-observation-laboratory-leucocytes.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Hémoglobine](StructureDefinition-edsh-observation-laboratory-hemoglobine.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Hématocrite](StructureDefinition-edsh-observation-laboratory-hematocrite.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Globules rouges](StructureDefinition-edsh-observation-laboratory-erythrocytes.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Volume Globulaire Moyen (VGM)](StructureDefinition-edsh-observation-laboratory-vgm.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Plaquettes](StructureDefinition-edsh-observation-laboratory-plaquettes.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Neutrophiles](StructureDefinition-edsh-observation-laboratory-neutrophiles.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Lymphocytes](StructureDefinition-edsh-observation-laboratory-lymphocytes.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Eosinophiles](StructureDefinition-edsh-observation-laboratory-eosinophiles.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Monocytes](StructureDefinition-edsh-observation-laboratory-monocytes.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Taux de prothrombine (TP)](StructureDefinition-edsh-observation-laboratory-tp.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Temps de céphaline activée (TCA)](StructureDefinition-edsh-observation-laboratory-tca.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Aspartate aminotransférase (AST)](StructureDefinition-edsh-observation-laboratory-asat.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Aspartate aminotransférase (ALT)](StructureDefinition-edsh-observation-laboratory-alat.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Gamma-glutamyl transférase (GGT)](StructureDefinition-edsh-observation-laboratory-ggt.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Phosphatases alcalines (PAL)](StructureDefinition-edsh-observation-laboratory-pal.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Bilirubine totale](StructureDefinition-edsh-observation-laboratory-bilirubine-totale.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Bilirubine conjuguée](StructureDefinition-edsh-observation-laboratory-bilirubine-conjuguee.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Glycémie à jeun](StructureDefinition-edsh-observation-laboratory-glycemie-a-jeun.html) | Données d'intérêt |
| Résultats d'examens biologiques | [Hémoglobine glyquée](StructureDefinition-edsh-observation-laboratory-hba1c.html) | Données d'intérêt |
| Exposition médicamenteuse | [Médicament prescrit](StructureDefinition-edsh-medication-request.html) | Données d'intérêt |
| Exposition médicamenteuse | [Médicament administré](StructureDefinition-edsh-medication-administration.html) | Données d'intérêt |
| Dossier de soin | [Poids](StructureDefinition-edsh-observation-body-weight.html) | Données d'intérêt |
| Dossier de soin | [Taille](StructureDefinition-edsh-observation-body-height.html) | Données d'intérêt |
| Dossier de soin | [Pression artérielle](StructureDefinition-edsh-observation-blood-pressure.html) | Données d'intérêt |
| Style de vie | [Consommation de tabac](StructureDefinition-edsh-observation-smoking-status.html) | Données d'intérêt |
| Style de vie | [Consommation d'alcool](StructureDefinition-edsh-observation-alcohol-use-status.html) | Données d'intérêt |
| Style de vie | [Consommation d'autres drogues](StructureDefinition-edsh-observation-substance-use-status.html) | Données d'intérêt |
| Style de vie | [Activité physique](StructureDefinition-edsh-observation-exercice-status.html) | Données d'intérêt |
{: .grid}

Indications de lecture :

- Colonne "Groupe" : Il s'agit d'une information issue du fichier du [GT socle de données](DocumentReference-CoreExigences.html).
- Colonne "Données" : Nom et référence du profil FHIR.
- Colonne "Caractéristiques" :
  - Données transactionnelles: données qui représentent l'achèvement d'une action ou d'un plan d'action « métier ».  il ne s’agit pas ici de « transaction » au sens informatique de « suite d’opérations modifiant l’état d’une base de données », mais de transaction au sens commercial ; dans notre contexte, un épisode de soin, par exemple, représente une transaction. On distingue :
    - **Données issues de formulaire** : ces données sont restituées sous la forme sous laquelle elles ont été saisies. Leur forte adhérence à des processus de production spécifiques les rend difficilement utilisables pour des agents non au fait desdits processus.
    - **Données d'intérêt** : ces données ont bénéficié d'une étape de standardisation lors de leur intégration dans le Hub de donnée, ce qui favorise leur réutilisabilité.
  - **Données de références** : il s'agit des données utilisées pour organiser ou catégoriser d'autres données, ou pour relier des données à des informations à l'intérieur et à l'extérieur des limites de l'hôpital. Il s'agit généralement de codes et de descriptions ou de définitions.
  - **Données maîtres** : elles fournissent le contexte des données relatives à l'activité métier sous la forme de concepts communs et abstraits qui se rapportent à l'activité. Elles comprennent les détails (définitions et identifiants) des objets internes et externes impliqués dans les transactions métier, tels que les clients, les produits, les employés, les fournisseurs et les domaines contrôlés (valeurs de code).
