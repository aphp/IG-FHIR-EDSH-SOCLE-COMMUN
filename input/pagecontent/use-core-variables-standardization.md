{% include markdown-link-references.md %}

Les [exigences de l'usage **Variables socles pour les EDSH** (fichier MSExcel)](DocumentReference-CoreExigences.html) 
référencées issues des travaux du GT Standards & Interopérabilité. 

### Modèles standardisés (Profils FHIR)

Le tableau ci-dessous référence tous les profils FHIR résultat du processus de standardisation des données au format FHIR.

{% include data-dictionary-table.md %}

### Exemples

[Cette StructureMap](https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureMap/Q2FSL) permet de générer, à partir des QuestionnaireResponse, les ressources FHIR conformes.

#### Cas 1 : Infarctus du myocarde

Dans l'histoire du cas 1 on peut représenter plusieurs informations dans le modèle standard :

- [la patiente elle même](Patient-73ed8b6d-e761-4f71-b69d-475a1be9f487.html)
- [son séjour hopsitalier](Encounter-b3e979e5-b9e6-4ef6-b7b5-ca218cab44c7.html)
- les affections prises en charges lors de son séjour : [son Hypercholesterolemie essentielle](Condition-21031872-7e8d-42d4-a1db-7ccf4b0ea211.html), et [son Infarctus aigu du myocarde, sans precision](Condition-669ba56c-68fe-4d47-b334-47c7304b588a.html)
- sa [pression artérielle](Observation-f0be29b4-d79b-4244-8eed-1fe8ebf6eb5d.html)
- les actes dont elle a bénéficié : [Dilatation intraluminale de 2 vaisseaux coronaires avec arteriographie coronaire, avec pose d'endoprothese, par voie arterielle transcutanee](Procedure-1b310860-da98-46fa-a956-8701936db776.html) et [Electrocardiographie sur au moins 12 derivations](Procedure-94a6caed-68c0-424a-be57-c649e74f5bd5.html)
- certains des dosages biologiques dont elle a bénéficié : 
  - [creatinine [moles/volume] serum/plasma](Observation-83c65e9b-a66e-4d0d-88cc-ba7c7badbcf5.html)
  - [DFG](Observation-839160d3-4ed6-4408-8725-08810127d978.html)
  - [hemoglobine](Observation-2ca390bc-3d5f-4357-92bf-2466c53e3225.html)
  - [leucocytes](Observation-b0a9b8cd-f2a7-4aec-867c-d76a6fe6496b.html)
- ses prescriptions médicamenteuses : [aspirine](MedicationRequest-2399902c-585f-4eae-9ed8-519f9fe4da34.html), [Atorvastatine](MedicationRequest-aec11f99-dec8-49ac-bbfe-e8ebb7aa7ff6.html), [Bisoprolol](MedicationRequest-f70d0ea6-bf3f-423c-beb3-00fcff587f7f".html), [Ramipril](MedicationRequest-b7e2578f-2197-45c5-9b7c-4f52a615bb20.html) et [Ticagrelor](MedicationRequest-acb4d2b8-79cb-440b-afb1-5a875eaddb24".html)
- ses administrations médicamenteuses
  - [aspirine](MedicationAdministration-2463eb1a-0e0a-40b9-b240-218c0f118ba5.html)
  - [Atorvastatine](MedicationAdministration-4cc5d2fa-a7c3-4fbd-b33a-39b384477e22.html)
  - [Bisoprolol](MedicationAdministration-de7c7b59-1d77-4070-a355-188c5e85b8e3.html)
  - [Ramipril](MedicationAdministration-af425c3c-49ab-4f43-aaf9-177c58879e68.html)
  - [Ticagrelor](MedicationAdministration-9ea594bb-1a6c-45cf-86bc-687be3caaf78.html)

#### Cas 2 : Ulcère gastrique

à faire

#### Cas 3 : Accouchement simple

à faire

#### Cas 4 : Choc cardiogénique

à faire

#### Cas 5 : Pyélonéphrite aigue

à faire

#### Cas 6 : Suivi de cardiopathie ischémique

à faire

#### Cas 7 : État de mal migraineux

à faire

#### Cas 8 : Chirurgie d'une fracture fémorale

à faire

#### Cas 9 : Ponction évacuatrice d'ascite

Dans l'histoire du cas 9 on peut représenter plusieurs informations dans le modèle standard :

- [la patiente elle même](Patient-2d7c21fd-859a-493b-b20a-1a27237ea5ba.html)
- [son séjour hopsitalier](Encounter-74f2a55a-f256-41c2-8f2c-9677ca2df273.html)
- les affections prises en charges lors de son séjour : [son ascite](Condition-b8c8ab6c-aa1a-411e-840b-42a0a1f3667a.html), et [sa cirrhose](Condition-e4df962b-3bed-4025-a7f7-50e578b6a3ec.html)
<!--- [ses habitudes de consommation d'alcool](Observation-alcool-cas-9.html)-->
- son [poids](Observation-8a41d4d2-dbed-43a5-9135-4c9a357ecf41.html)
- les actes dont elle a bénéficié : [sa ponction d'ascite](Procedure-0a2f8750-d908-4bc4-ac31-700e91daf7b2.html) et [sa fibroscopie oeso-gastro-duodénale](Procedure-a9f6e570-d387-48a2-a137-a38feb04623e.html)
<!-- - certains des dosages biologiques dont elle a bénéficié : 
  - [asat](Observation-asat-cas-9.html)
  - [alat](Observation-alat-cas-9.html)
  - [phosphatases alcalines](Observation-phosphatases-alcalines-cas-9.html)
  - [gamma-glutamyl-transférase](Observation-ggt-cas-9.html)
  - [bilirubine totale](Observation-bilirubine-totale-cas-9.html)
  - [taux de prothrombine](Observation-tp-cas-9.html) -->
- ses prescriptions médicamenteuses : [furosémide](MedicationRequest-cdf30d04-f8f8-4394-80b1-6272019086a3.html), [spironolactone](MedicationRequest-68dcf522-b285-4d25-85ba-539e734e618e.html) et [albumine](MedicationRequest-ab3ae565-3a7f-491b-a2db-924e388ed918.html)
- ses administrations médicamenteuses
  - [J1 furosémide](MedicationAdministration-717b4d89-394b-41a6-a5c7-481cbbd8f368.html)
  - [J2 furosémide](MedicationAdministration-3831dcc6-1dae-461c-9811-9d7ee80bd645.html)
  - [J1 spironolactone](MedicationAdministration-15f7b957-f4a8-4de4-be84-4ca1887be053.html)
  - [J2 spironolactone](MedicationAdministration-9b55df99-2b8b-4f26-aff9-3e93e1cd7ee6.html)
  - [Albumine](MedicationAdministration-de43ecdc-5cab-44af-b063-71a25b3e2634.html)

#### Cas 10 : Exacerbation de BPCO

à faire