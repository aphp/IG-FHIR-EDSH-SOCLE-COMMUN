{% include markdown-link-references.md %}

Les [exigences de l'usage **Variables socles pour les EDSH** (fichier MSExcel)](DocumentReference-CoreExigences.html)
référencées issues des travaux du GT Standards & Interopérabilité.

### Modèles standardisés (Profils FHIR)

Le tableau ci-dessous référence tous les profils FHIR résultat du processus de standardisation des données au format FHIR.

{% include data-dictionary-table.md %}

### Exemples

[Cette StructureMap](https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureMap/Q2FSL) permet de générer, à partir des QuestionnaireResponse, les ressources FHIR conformes.

#### Cas 1 : Infarctus du myocarde

[Marie Dupont, née le 21 septembre 1965](Patient-cas1-pat-01.html), a été [hospitalisée du 10 au 14 janvier 2024](Encounter-cas1-sej-01.html) dans le service de cardiologie de l'hôpital Lariboisière pour un [infarctus du myocarde](Condition-cas1-diag-01.html) pris en charge par [coronarographie avec pose de stents](Procedure-cas1-acte-01.html).

Histoire de la maladie :

La patiente, âgée de 59 ans, s'est présentée aux urgences le 10 janvier 2024 pour une douleur thoracique intense d'apparition brutale au travail plus tôt dans la journée, accompagnée de sueurs et de dyspnée. A l'arrivée du SAMU, [l'ECG 12 dérivations](Procedure-cas1-acte-02.html) confirme un [SCA ST+](Condition-cas1-diag-04.html) avec un sus-décalage ST dans le territoire antérieur.

La prise en charge immédiate a consisté en :

- Dose de charge de charge [d'Aspirine 250 mg](MedicationAdministration-cas1-medadm-01.html)
- Dose de charge de [Ticagrelor 180 mg](MedicationAdministration-cas1-medadm-02.html)
- Bolus [d'HNF 3500 UI en IVD](MedicationAdministration-cas1-medadm-03.html)

La patiente transférée en coronarographie en urgence.

La [coronarographie](Procedure-cas1-acte-01.html) par ponction radiale droite réalisée le 10 janvier à H+1 met en évidence une [occlusion de l'IVA](Condition-cas1-diag-03.html). Une [dilatation intraluminale avec pose de stents actifs](Procedure-cas1-acte-01.html) sur l'IVA est réalisée dans le même temps. Absence de complication per procédure ou post geste.

La patiente est transférée en USIC pour suite de la prise en charge.

Dans ses antécédents, on note une [hypercholestérolémie essentielle](Condition-cas1-diag-02.html) isolée connue mais non traitée jusqu'à présent.

La patiente présente par ailleurs un [tabagisme estimé à 35 sevré depuis 1 an](à faire), et une consommation [occasionnelle d'alcool](à faire). Elle pratique la [marche à pied 30 minutes par jour](à faire).

Cliniquement à l'admission : État hémodynamique stable. Fréquence cardiaque : 72 /min [Pression artérielle : 135/85 mmHg](Observation-cas1-exam-tas-01-cas1-exam-tad-01.html) Température corporelle : 36.8°C. A l'auscultation : bruits du cœur réguliers, pas de souffle, pouls périphériques tous perçus, mollets souples, pas de signe d'insuffisance cardiaque gauche ou droite. 

Auscultation pulmonaire : normale

Examens complémentaires

Son dernier bilan du 10/01/2024 montrent :

- NFS normale ([hémoglobine : 14.2 g/dL](Observation-cas1-bio-hb-01.html), [leucocytes 7G/L](Observation-cas1-bio-leuco-01.html) , [plaquettes 295 G/L](Observation-cas1-bio-plq-01.html))
- [Créatinine sérique : 85 µmol/L](Observation-cas1-bio-creat-01.html) avec [DFG estimé : 74 mL/min/1.73m²](Observation-cas1-bio-dfg-01.html)
- Bilan hépatique sans particularité :
  - [ASAT 50 UI/L](Observation-cas1-bio-asat-01.html)
  - [alanine aminotransférase : 45 UI/L](Observation-cas1-bio-alat-01.html)
  - [GGT 70 UI/L](Observation-cas1-bio-ggt-01.html)
  - [PAL 30 UI/L](Observation-cas1-bio-pal-01.html)

L'évolution en USIC est favorable avec amendement rapide de la douleur thoracique et décroissance progressive de la troponinémie (à 1900 ng/mL à l'acmé).

[L'échocardiographie transthoracique](Procedure-cas1-acte-03.html) réalisée en post-coronarographie le 10 janvier 2024 retrouve une bonne fonction ventriculaire gauche avec FEVG à 65% sans trouble de la cinétique segmentaire et absence de valvulopathie significative.

Mme Dupont rentre à domicile le 14 janvier 2024 et est convoquée en consultation de cardiologie à un mois pour réévaluation clinique et adaptation thérapeutique. Information sur les signes d'alerte cardiovasculaires nécessitant une consultation en urgence. Conseils sur l'hygiène de vie : arrêt définitif du tabac, régime alimentaire adapté, reprise progressive de l'activité physique.

Elle sera également convoquée prochainement en SMR de réadaptation cardiovasculaire.

Prescription de sortie :

- [Aspirine 75 mg](MedicationRequest-cas1-medpresc-01.html) : 1 comprimé midi par jour par voie orale, traitement antiagrégant plaquettaire le midi
- [Ticagrelor 90 mg](MedicationRequest-cas1-medpresc-03.html) : 1 comprimé matin et soir par jour par voie orale, traitement antiagrégant plaquettaire, à poursuivre pendant 1 an
- [Atorvastatine 40 mg](MedicationRequest-cas1-medpresc-02.html) : 1 comprimé le soir par voie orale, traitement hypolipémiant
- [Bisoprolol 10 mg](MedicationRequest-cas1-medpresc-04.html) : 1 comprimé le matin par voie orale, bêta-bloquant
- [Ramipril 5 mg](MedicationRequest-cas1-medpresc-05.html) : 1 comprimé le matin par voie orale

Fait à Lariboisière le 14 janvier 2024

#### Cas 2 : Ulcère gastrique

[Pierre Martin, né le 5 avril 1970](Patient-cas2-pat-01.html), a été [hospitalisé du 8 au 10 janvier 2024](Encounter-cas2-sej-01.html) dans le service de gastroentérologie de l'hôpital Pitié-Salpêtrière pour une [endoscopie oeso-gastro-duodénale](Procedure-cas2-acte-01.html) dans le cadre d'une suspicion [d'ulcère de l'estomac](Condition-cas2-diag-01.html).

Histoire de la maladie :

Le patient s'est présenté aux urgences le 8 janvier 2024 pour des douleurs épigastriques intenses évoluant depuis plusieurs semaines, associées à des brûlures d'estomac et des nausées. Ces derniers jours, il rapporte également la présence de selles noires et malodorantes (suspicion de [méléna](Condition-cas2-diag-03.html)).

Mode de vie :

Travail dans l'informatique, [tabagisme actif à 40 PA](à faire), [consommation d'alcool entre 1 et 2 bières de 50 cL par jour](à faire). [Sédentaire](à faire).

Dans ses antécédents, on note un [psoriasis cutané isolé](Condition-cas2-diag-02.html).

Examen clinique à l'admission : État général conservé. Fréquence cardiaque : 88 /min Température corporelle : 37.2°C Pâleur conjonctivale modérée Abdomen souple, sensible à la palpation épigastrique, sans défense ni contracture Toucher rectal : présence de selles noires confirmant le méléna

Les examens complémentaires à son arrivée montre une anémie normocytaire régénérative : [hémoglobine à 7 g/dL](Observation-cas2-bio-hb-01.html), [VGM 87 fL](Observation-cas2-bio-vgm-01.html) Réticulocytes 190 G/L.

Le reste du bilan est sans particularité, la [créatininémie est à 98 µmol/L](Observation-cas2-bio-creat-01.html).

La [FOGD](Procedure-cas2-acte-01.html) réalisée le 8 janvier retrouve un [ulcère gastrique](Condition-cas2-diag-01.html) de 1,5 cm de diamètre au niveau de l'antre gastrique. L'ulcère présente un fond fibrineux sans stigmate de saignement actif au moment de l'examen. Pas de signe de perforation. L'œsophage et le duodénum sont d'aspect normal. Des biopsies gastriques sont réalisées pour recherche d'Helicobacter pylori et analyse anatomopathologique.

Introduction d'un traitement par [oméprazole 20 mg](MedicationRequest-cas2-medpresc-01.html) 2 fois par jour à partir du 8 janvier.

L'évolution est favorable avec une amélioration rapide des douleurs épigastriques. Pas de récidive du saignement digestif durant l'hospitalisation. L'hémodynamique reste stable.

Sortie

Le patient sort à domicile le 10 janvier avec [la prescription d'oméprazole 20 mg](MedicationRequest-cas2-medpresc-01.html) pour une durée de 8 semaines.

Consignes de sortie :

 - Poursuite du traitement par oméprazole pendant 8 semaines
 - Éradication d'Helicobacter pylori si la recherche s'avère positive (résultats des biopsies en attente)
 - Consultation de contrôle avec endoscopie à 6-8 semaines pour vérifier la cicatrisation
 - Arrêt du tabac et réduction de la consommation d'alcool, facteurs aggravant l'ulcère gastrique
 - Éviter les anti-inflammatoires non stéroïdiens (AINS) et l'aspirine

M. Martin est informé des signes d'alerte nécessitant une consultation en urgence : douleurs abdominales intenses, vomissements de sang, selles noires, malaise.

Fait à la Pitié-Salpêtrière le 10 janvier 2024


#### Cas 3 : Accouchement simple

[Sophie Leroy, née le 3 décembre 1994](Patient-cas3-pat-01.html), a été [hospitalisée du 15 au 18 janvier 2024](Encounter-cas3-sej-01.html) dans le service de gynécologie-obstétrique de l'hôpital Port Royal pour un [accouchement spontanée par voie basse](Condition-cas3-diag-01.html)

Histoire de la maladie : La patiente primipare, se présente à la maternité le 15 janvier 2024 à 5h00 du matin pour un début de travail spontané à 39 semaines et 4 jours d'aménorrhée. Les contractions utérines sont régulières et douloureuses. La rupture de la poche des eaux est spontanée à l'arrivée, avec un liquide amniotique clair.

La grossesse a été suivie de manière régulière et s'est déroulée sans complication particulière. Tous les examens prénataux étaient normaux. On note que la patiente est elle-même issue d'une grossesse gémellaire (rang de gémellaire : 2).

Concernant son mode de vie, la patiente ne [fume pas](à faire), [ne consomme pas d'alcool](à faire) et maintient une [activité physique régulière (marche active plusieurs fois par semaine)](à faire), ce qui a contribué au bon déroulement de sa grossesse.

Examen clinique à l'admission : État général excellent, patiente bien préparée à l'accouchement. [Poids : 68.5 kg](Observation-cas3-exam-poids-01.html), [Taille : 165 cm](Observation-cas3-exam-taille-01.html) [Pression artérielle : 125/73 mmHg](Observation-cas3-exam-tas-01-cas3-exam-tad-01.html) (normale) Hauteur utérine : 34 cm. Bruits du cœur fœtaux : réguliers et normaux (140 bpm) Col utérin : dilatation à 4 cm, effacé à 80%, présentation céphalique bien engagée.

Examens complémentaires

Les analyses biologiques du 15/01/2024 montrent :

 - [Hémoglobine : 11.8 g/dL](Observation-cas3-bio-hb-01.html)
 - [Plaquettes : 285 x10⁹/L](Observation-cas3-bio-plq-01.html)
 - Pas de cytolyse hépatique
 - Bonne fonction rénale avec [créatininémie à 60 µmol/L](Observation-cas3-bio-creat-01.html)

Le reste du bilan est sans particularité. En particulier l'hémostase est normal, compatible avec un accouchement par voie basse sans contre-indication à une éventuelle péridurale.

Déroulé de l'accouchement : Bonne progression du travail avec une bonne dynamique utérine. La dilatation cervicale est complète à 7h45. La patiente bénéficie d'une [analgésie par anesthésie péridurale](Procedure-cas3-acte-02.html) efficace posée à 6 cm de dilatation, permettant un travail confortable.

[L'accouchement céphalique unique par voie basse chez une patiente primipare](Procedure-cas3-acte-01.html) se déroule le 15 janvier 2024 à 8h30, sous la direction de la sage-femme. [Naissance unique d'un enfant vivant](Condition-cas3-diag-02.html).

Nouveau-né de sexe féminin, poids de naissance : 3250 g, taille : 49 cm, périmètre crânien : 34 cm. Score d'Apgar : 10/10 à 1 minute et 10/10 à 5 minutes. L'examen pédiatrique est normal. Le contact peau à peau est immédiat et la première tétée se déroule bien.

La délivrance est complète et spontanée 15 minutes après la naissance. [Absence de déchirure périnéale significative](Condition-cas3-diag-03.html), une [petite déchirure du 1er degré suturée](Procedure-cas3-acte-03.html) sous anesthésie locale. Les pertes sanguines sont estimées à 350 mL, dans les limites de la normale.

Suites de couches

Les suites de couches immédiates sont simples. La surveillance en salle de naissance durant 2 heures ne révèle aucune anomalie. La patiente et son nouveau-né sont transférés en chambre mère-enfant.

L'allaitement maternel est débuté dès la naissance et se met en place progressivement avec l'aide de l'équipe soignante. Les montées de lait sont effectives à J3.

Sortie

Mme Leroy et sa fille sortent à domicile le 18 janvier 2024 après 3 nuits d'hospitalisation. L'état de la mère et du nouveau-né est excellent.

[Prescription d'acide folique 5 mg](MedicationRequest-cas3-medpresc-01.html) par voie orale, à prendre quotidiennement pendant 3 mois dans le cadre de la supplémentation post-partum, notamment si l'allaitement maternel est poursuivi.

Consignes de sortie :

 - Poursuite de l'allaitement maternel exclusif à la demande
 - Surveillance de la cicatrisation périnéale, soins locaux
 - [Supplémentation en acide folique](MedicationRequest-cas3-medpresc-01.html) pendant 3 mois
 - Consultation post-natale avec le gynécologue à 6-8 semaines
 - Visite pédiatrique de suivi à J10 puis à 1 mois
 - [Rééducation périnéale](Procedure-cas3-acte-04.html) prescrite (à débuter 6 semaines après l'accouchement)
 - Contraception : information donnée, prescription différée à la consultation post-natale

Numéros d'urgence communiqués. Information sur les signes d'alerte nécessitant une consultation : fièvre, saignements abondants, douleurs abdominales intenses, difficultés d'allaitement majeures.

Fait à Port Royal le 18 janvier 2024


#### Cas 4 : Choc cardiogénique

[Jean Moreau, né le 15 août 1961](Patient-cas4-pat-01.html), a été [hospitalisé du 5 au 7 novembre 2023](Encounter-cas4-sej-01.html) dans le service de réanimation médical de l'hôpital Bichat pour un [choc cardiogénique](Condition-cas4-diag-01.html).

Le patient, âgé de 62 ans, est admis en urgence en réanimation médicale de l'hôpital Bichat le 5 novembre 2023 à 21h00 transporté par SAMU dans un contexte de [détresse respiratoire aiguë](Condition-cas4-diag-02.html). Il a en effet présenté une douleur thoracique intense d'apparition brutale survenue au domicile 30 min plus tôt, associée à une dyspnée majeure et des sueurs profuses. Sa compagne a d'emblée contacté les secours.

A l'arrivée du SAMU, le patient est en état de choc avec une pression artérielle imprenable, des marbrures diffuses des membres inférieurs et des troubles de la vigilance avec un Glasgow à 12. [L'électrocardiogramme sur 18 dérivations](Procedure-cas4-acte-08.html) retrouve un rythme sinusal à 110 bpm avec sus-décalage ST étendu à tout le territoire antérieur et latéral évocateur d'un [infarctus du myocarde étendu](Condition-cas4-diag-03.html).

La prise en charge immédiate a consisté en :

 - Dose de charge de charge [d'Aspirine 250 mg](MedicationAdministration-cas4-medadm-03.html)
 - Dose de charge de [Ticagrelor 180 mg](MedicationAdministration-cas4-medadm-04.html)
 - Bolus d'[HNF 4000 UI en IVD](MedicationAdministration-cas4-medadm-02.html)
 - Remplissage vasculaire par [1 L de NaCl 0.9%](MedicationAdministration-cas4-medadm-06.html)

La patiente transférée en dans le service de réanimation médicale de l'hôpital Bichat.

Dans ses antécédents, on note un [carcinome épidermoïde pulmonaire métastatique (plève)](Condition-cas4-diag-04.html) diagnostiqué en mars 2023 pour lequel le patient a été perdu de vue à l'issue du diagnostic, une notion [d'angor d'effort non exploré](Condition-cas4-diag-05.html), un [diabète de type 2](Condition-cas4-diag-06.html) non traité et non suivi.

Par ailleurs, le patient est [fumeur actif](à faire) avec une consommation de 1 paquet par jour depuis 30 ans et a une [consommation quotidienne d'alcool à 3 verres de vin par jour](à faire). [Pas d'activité physique](à faire).

Examen clinique à l'admission en réanimation :

Fréquence cardiaque : 125 /min (tachycardie sinusale) [Pression artérielle : 75/30 mmHg](Observation-cas4-exam-tas-01-cas4-exam-tad-01.html). Température corporelle : 35.8°C, marbrures cutanées diffuses, extrémités froides et cyanosées Auscultation cardiaque : tachycardie, galop, souffle d'insuffisance mitrale Auscultation pulmonaire : crépitants bilatéraux jusqu'à mi-champs. Oligurie. GCS 10.

Prise en charge initiale :

 - [Intubation oro-trachéale](Procedure-cas4-acte-01.html) est réalisée en urgence le 5 novembre à 22h15 avec mise en place d'une [ventilation mécanique invasive par ventilation assistée contrôlée](Procedure-cas4-acte-07.html) devant la défaillance hémodynamique, respiratoire et neurologique.
 - [Pose d'un cathéter veineux central et d'un cathéter artériel en fémoral droit](Procedure-cas4-acte-04.html)
 - [Support vasopresseur par Dobutamine 10 µg/kg/min + Noradrénaline à 3 mg/h](MedicationAdministration-cas4-medadm-05.html) et poursuite du remplissage vasculaire par [1 L de NaCl 0.9% en débit libre](MedicationAdministration-cas4-medadm-07.html)

[L'échocardiographie transthoracique](Procedure-cas4-acte-06.html) à l'admission révèle une altération sévère de la fonction ventriculaire gauche avec une fraction d'éjection effondrée à 20%, une akinésie étendue de la paroi antérieure et septale, et une insuffisance mitrale significative. Péricarde sec.

Le 5 novembre à 23h00, réalisation d'une [coronarographie](Procedure-cas4-acte-02.html) et met en évidence une [occlusion complète du tronc commun](Condition-cas4-diag-08.html), ainsi qu'une [sténose à 60% de l'artère coronaire droite proximale](Condition-cas4-diag-09.html).

Mise en place d'un [stent actif sur le tronc commun](Procedure-cas4-acte-05.html).

Echec de revascularisation avec persistance de la dysfonction myocardique et de la défaillance hémodynamique malgré la titration progressive en catécholamines.

Compte tenu des comorbidités du patient, à savoir un cancer pulmonaire métastatique pour lequel il a été perdu de vue dès le diagnostic, une cardiopathie ischémique et un diabète non suivis, il est décidé collégialement (réanimateur, cardiologue) de limiter le patient et de ne pas recourir à une pose d'ECMO artério-veineuse et à d'autres thérapeutiques invasives. La décision est expliquée à son épouse qui la comprend.

L'évolution est rapidement défavorable avec [une défaillance multiviscérale (hémodynamique, cardiaque, rénale et hépatique)](Condition-cas4-diag-07.html).

Le patient présentera finalement un arrêt cardiaque avec un décès constaté le 7 novembre à 09h32.

Conclusion

[Choc cardiogénique réfractaire](Condition-cas4-diag-10.html) compliquant un [infarctus du myocarde antérieur aigu étendu](Condition-cas4-diag-11.html). Evolution défavorable avec décès du patient le 7 novembre 2023 à 09h32

Fait à l'hôpital Bichat le 7 novembre 2023

#### Cas 5 : Pyélonéphrite aigue

[Camille Simon, née le 4 juillet 1945](Patient-cas5-pat-01.html), a été [hospitalisée du 12 au 16 janvier 2024](Encounter-cas5-sej-01.html) dans le service de médecine de maladies infectieuses de l'hôpital Saint-Louis pour [pyélonéphrite aigue](Condition-cas5-diag-01.html).

La patiente de 78 ans s'est présentée aux urgences de Saint-Louis dans un contexte d'altération de l'état général avec fièvre à 39°C à domicile, signes fonctionnels urinaires et douleurs en fosse lombaire gauche.

Elle a pour seul antécédent notable une [hypertension artérielle essentielle](Condition-cas5-diag-03.html) sous monothérapie par Amlodipine bien équilibrée.

Elle n'a [jamais fumé](à faire) et a une [consommation occasionnelle d'alcool](à faire).

Elle est autonome et pratique la [marche à pied 1 h 3 fois par semaine](à faire)

Aux urgences :

Patiente hémodynamiquement stable avec fièvre à 38.5°C.

Bandelette urinaire avec leucocyturie +++ et hématurie +.

Le bilan biologique retrouve :

 - Syndrome inflammatoire biologique avec [leucocytes à 18 g/L](Observation-cas5-bio-leuco-01.html) dont [PNN 15 G/L](Observation-cas5-bio-neut-01.html)
 - [Insuffisance rénale aigue](Condition-cas5-diag-02.html) avec [créatininémie à 150 µmol/L](Observation-cas5-bio-creat-01.html)

La prise en charge initiale a consisté en :

 - Antibiothérapie probabiliste par voie intraveineuse par [Ceftriaxone 1 g/jour](MedicationRequest-cas5-medpresc-01.html)
 - [Hydratation intraveineuse par 1 L/jour de NaCl 0.9%](MedicationRequest-cas5-medpresc-04.html)

Une [échographie rénale](Procedure-cas5-acte-01.html) est réalisée et ne retrouve des reins de bonne morphologie sans dilatation des cavités pyélocalicielles ni d'abcès visualisé à gauche.

La patiente est transférée dans le service de maladies infectieuses pour la suite de la prise en charge.

Examen clinique à l'admission : État général légèrement altéré avec patiente asthénique mais consciente et bien orientée. Température corporelle : 38.5°C Fréquence cardiaque : 95 /min. [Pression artérielle : 110/70 mmHg](Observation-cas5-exam-tas-01-cas5-exam-tad-01.html), Fréquence respiratoire : 15 /min, saturation en oxygène : 98% en air ambiant

Examen pulmonaire : Auscultation pulmonaire normale, pas de foyer de râles crépitants. Pas de signe de détresse respiratoire.

Examen cardiovasculaire et abdominal : normaux

Prise en charge et évolution

Evolution rapidement favorable sur le plan septique et néphrologique avec amendement de la fièvre à J1, décroissance progressive du syndrome inflammatoire biologique et stabilisation de la [créatininémie autour de 60 µmol/L](Observation-cas5-bio-creat-02.html) à J3.

[L'ECBU](Procedure-cas5-acte-02.html) réalisé aux urgences revient positif à E. coli avec une pénicillinase de bas niveau.

L'antibiothérapie est donc secondairement adaptée à partir du 14 janvier avec relais par [Amoxicilline + acide clavulanique 1 g /125 mg 3 fois par jour](MedicationRequest-cas5-medpresc-02.html) par voie orale à poursuivre pour 10 jours de traitement au total.

Conclusion

Il s'agit d'une [pyélonéphrite aigue](Condition-cas5-diag-04.html) documentée à E. coli avec une pénicillinase de bas niveau compliquée initialement d'une insuffisance rénale aigue.

Evolution rapidement favorable après antibiothérapie et réhydratation.

La patiente rentre à domicile le 16 janvier.

Prescription de sortie :

 - [Amlodipine 10 mg le soir](MedicationRequest-cas5-medpresc-03.html)
 - [Amoxicilline + acide clavulanique 1 g / 125 mg matin, midi et soir à poursuivre jusqu'au 21 janvier inclus](MedicationRequest-cas5-medpresc-02.html)

Fait à Saint-Louis le 16 janvier 2024


#### Cas 6 : Suivi de cardiopathie ischémique

[Nicolas Petit, né le 5 septembre 1965](Patient-cas6-pat-01.html), [hospitalisé du 5 au 7 janvier 2024](Encounter-cas6-sej-01.html) dans le service de cardiologie de l'hôpital Européen Georges-Pompidou pour réalisation d'une [coronarographie](Procedure-cas6-acte-02.html) pour exploration d'un [angor stable](Condition-cas6-diag-01.html).

Patient de 58 ans adressé par son cardiologue traitant dans un contexte de douleur thoracique d'effort évocatrice d'angor stable évoluant depuis plusieurs mois.

Une [épreuve par ECG d'effort](Procedure-cas6-acte-04.html) avait été réalisée en ambulatoire et s'était révélée positive cliniquement et électriquement avec apparition d'un sus-décalage ST dans le territoire inférieur.

Facteurs de risque cardiovasculaire :
  - [Hypertension artérielle essentiellediagnostic](Condition-cas6-diag-02.html) connue depuis une dizaine d'années, traitée mais mal contrôlée
  - [Tabagisme sevré](à faire) depuis 5 ans estimé à 15 paquets-années
  - Pas d'antécédent personnel ou familial d'infarctus du myocarde ou d'accident vasculaire cérébral
  - [Activité physique régulière de faible intensité](à faire) avec 30 minutes de marche par jour en moyenne
  
Par ailleurs, [consommation d'alcool occasionnelle](à faire).

Examen clinique à l'admission :

Fréquence cardiaque : 68 /min (régulière), [Pression artérielle 145/90 mmHg](Observation-cas6-exam-tas-01-cas6-exam-tad-01.html), [Poids : 82 kg](Observation-cas6-exam-poids-01.html), [taille : 175 cm](Observation-cas6-exam-taille-01.html), IMC : 26.8 kg/m²

Examen cardiovasculaire :

Auscultation cardiaque : bruits du cœur réguliers, pas de souffle. Pas de signe d'insuffisance cardiaque (pas d'œdème des membres inférieurs, pas de turgescence jugulaire? pas de reflux hépato-jugulaire).

Pouls périphériques perçus et symétriques.

Pas de douleur thoracique au repos.

Examen pulmonaire et abdominal : normaux

Bilan biologique à l'admission :

  - [Anémie microcytaire](Condition-cas6-diag-03.html) avec [hémoglobinémie à 10.5 g/dL hemoglobine](Observation-cas6-bio-hb-01.html) et [VGM à 72 fL](Observation-cas6-bio-vgm-01.html)
  - Le reste du bilan est sans particularité avec notamment une fonction rénale normale avec une [créatininémie à 75 µmol/L](Observation-cas6-bio-creat-01.html)

[L'électrocardiogramme sur 12 dérivations](Procedure-cas6-acte-01.html) réalisée à l'admission montre un rythme sinusal régulier à 68 /min, avec axe normal, sans trouble de la conduction ni de la repolarisation.

[L'échocardiographie transthoracique](Procedure-cas6-acte-03.html) réalisée à l'admission retrouve une fonction ventriculaire gauche préservée avec une FEVG à 55%

[La coronarographie](Procedure-cas6-acte-02.html), réalisée le 6 janvier 2024 à 11h30 par le Dr. Cardiologue par voie radiale droite sous anesthésie locale et contrôle scopique, met en évidence :
 
  - Artère coronaire droite : sténose de 60% au niveau du segment moyen, non significative hémodynamiquement
  - Artère interventriculaire antérieure : sténose à 40-50% au niveau du segment proximal non significative
  - Artère circonflexe : pas de sténose significative

Décision d'opter pour un traitement médical optimal dans un premier temps avec réévaluation clinique et fonctionnelle rapprochée.
Introduction de [Bisoprolol 5 mg](MedicationRequest-cas6-medpresc-04.html) , [Ramipril 5 mg](MedicationRequest-cas6-medpresc-02.html), [Simvastatine 20 mg](MedicationRequest-cas6-medpresc-03.html) et [Aspirine 75 mg](MedicationRequest-cas6-medpresc-01.html) à partir du 6 janvier 2024.

En cas d'aggravation ou de persistance, il y aura une indication formelle à un geste de revascularisation.

Règles hygiéno-diététiques :

 - Automesure tensionnelle au domicile avec objectif < 140/90 mmHg
 - Pas de reprise du tabac
 - Activité physique régulière recommandée avec plus de 30 minutes de marche par jour à adapter selon tolérance
 - Adaptation du régime alimentaire avec alimentation contrôlée en sel et acides gras saturés conformément à la documentation remise par la diététicienne du service
 - Contrôle du poids (objectif : IMC < 25 kg/m²)

Le patient rentre à domicile le 7 janvier 2024 après une surveillance de 24h post-coronarographie sans complication.

Il sera revu en consultation de cardiologie dans 1 mois et pour une épreuve d'effort dans 3 mois.

Le patient est informé des signes d'alertes motivant une consultation en urgence : douleur thoracique au repos, douleur thoracique non soulagée par le repos ou l'administration de trinitrine, malaise, dyspnée aigue.

Prescription de sortie :

 - [Acide acétylsalicylique 75 mg, 1 sachet le matin](MedicationRequest-cas6-medpresc-01.html)
 - [Ramipril 5 mg, 1 comprimé le matin](MedicationRequest-cas6-medpresc-02.html)
 - [Simvastatine 20 mg, 1 comprimé le matin](MedicationRequest-cas6-medpresc-03.html)
 - [Bisoprolol 5 mg, 1 comprimé le matin](MedicationRequest-cas6-medpresc-04.html)
 - [Trinitrine 0.15 mg, 1 pulvérisation sublinguale en cas de douleur thoracique](MedicationRequest-cas6-medpresc-05.html), si persistance de la douleur au bout de 5 min, refaire une pulvérisation et appeler le 15

Fait à Georges-Pompidou le 7 janvier 2024


#### Cas 7 : État de mal migraineux

[Elena Garcia, née le 13 novembre 1985](Patient-cas7-pat-01.html), [hospitalisée du 14 au 16 janvier 2024](Encounter-cas7-sej-01.html) dans le service de neurologie de l'hôpital Tenon, unité neuro-vasculaire, pour un céphalées inhabituelles.

Patiente de 38 ans se présentant aux urgences de l'hôpital Tenon le 14 janvier 2024 en début de matinée pour une céphalée sévère, continue, évoluant depuis 4 jours sans amélioration malgré la prise répétée d'antalgiques à domicile (paracétamol, ibuprofène).

La céphalée est d'apparition progressive, pulsatile et prédomine sur l'hémicrâne gauche, de forte intensité. (EVA 9/10). Elle est associée à des nausées avec plusieurs épisodes de vomissements et une phono-photophobie majeure.

Antécédents médicaux :

 - [Migraine](Condition-cas7-diag-02.html) depuis l'adolescence avec 2 à 3 crises par an habituellement soulagé par paracétamol et anti-inflammatoires non stéroïdiens
 - Pas d'autre antécédent notable
 - [Pas d'intoxication tabagique](à faire)
 - [Consommation d'alcool occasionnelle](à faire)
 - [Activité physique régulière avec marche et yoga plusieurs fois par semaines](à faire)

Examen clinique à l'admission :

Fréquence cardiaque : 78 /min (régulière) [Pression artérielle 120/75 mmHg](Observation-cas7-exam-tas-01-cas7-exam-tad-01.html) (normale) Température : 36.7°C

Examen neurologique :

Céphalée hémi crânienne gauche évaluée avec EVA à 9/10.

Pas de trouble de la vigilance, bien orientée dans le temps et l'espace.

Pas de syndrome méningé, nuque souple.

Examen des paires crâniennes sans particularité.

Pupilles symétriques réactives.

Pas de déficit sensitivo-moteur.

Devant le tableau de céphalée sévère et inhabituelle, réalisation d'un [angioscanner cérébral](Procedure-cas7-acte-01.html) le 14 janvier 2024 afin d'éliminer une cause secondaire.

Le scanner ne retrouve pas d'anomalie notable en particulier pas d'argument en faveur d'un saignement, d'un processus expansif ou d'une thrombophlébite cérébrale.

La patiente est transférée dans l'unité neuro-vasculaire pour la suite de la prise en charge.

Compte tenu de l'absence de lésion retrouvée et de l'antécédent de migraine, nous retenons [l'état de mal migraineux](Condition-cas7-diag-01.html).

Prise en charge thérapeutique :

 - Mise au repos en chambre individuelle avec environnement calme
 - Traitement antiémétique par [Metoclopramide 10 mg intraveineux](MedicationRequest-cas7-medpresc-03.html)
 - Traitement antalgique avec poursuite du Paracetamol 1 g, [Ketoprofene 100 mg](MedicationRequest-cas7-medpresc-02.html) et introduction de [Sumatriptan 50 mg](MedicationRequest-cas7-medpresc-01.html)

Évolution rapidement favorable avec résolution progressive de la céphalée et amendement de la photo-phonophobie et de nausées/vomissements.

Éducation thérapeutique et conseils :

 - Hygiène de sommeil : régularité du sommeil (7-8h par nuit), éviter la dette de sommeil
 - Eviter la consommation d'alcool
 - Traitement précoce des crises dès les premiers signes
 - Éviter la surconsommation d'antalgiques (risque de céphalée par abus médicamenteux si prise >10 jours par mois)
 - Tenir un agenda des crises pour identifier les facteurs déclenchants

La patiente rentre à domicile le 16 janvier 2024.

Elle sera revue en consultation de neurologie dans 3 mois pour réévaluation.

Signes d'alerte devant faire consulter en urgence en cas de céphalée : brutale et intense, fièvre associée, trouble neurologique associé, caractère inhabituel

Prescription de sortie :

 - [Sumatriptan 50 mg, 1 comprimé si migraine](MedicationRequest-cas7-medpresc-01.html) à prendre dès le début de la crise migraineuse, renouvelable après 2 heures si besoin
 - [Ketoprofene 100 mg, 1 comprimé 2 fois par jour si migraine](MedicationRequest-cas7-medpresc-02.html) à prendre dès le début de la crise migraineuse
 - [Metoclopramide 10 mg, 1 comprimé 3 fois par jour si nausées/vomissements](MedicationRequest-cas7-medpresc-03.html)

Fait à Tenon le 16 janvier 2024

#### Cas 8 : Chirurgie d'une fracture fémorale

[Antoine Roux, né le 6 février 1992](Patient-cas8-pat-01.html), [hospitalisé du 11 au 14 janvier 2024](Encounter-cas8-sej-01.html) dans le service de chirurgie orthopédique de l'hôpital Henri-Mondor dans un contexte de [fracture du trochanter](Condition-cas8-diag-01.html).

Patient de 31 ans se présentant aux urgences de l'hôpital Henri-Mondor le 11 janvier 2024 douleur de la hanche droite compliquée d'une impotence fonctionnelle complète dans les suites d'un traumatisme de la hanche droite survenu lors d'une sortie en VTT la veille. Il rapporte une chute latérale sur la hanche droite à vitesse modérée sur terrain accidenté.

Patient en excellent état général sans antécédent médical ou chirurgical.

Pas d'[intoxication tabagique](à faire) ni de [consommation d'alcool](à faire).

[Activité physique intense régulière](à faire) avec pratique régulière du VTT, de la course à pied et de la musculation.

Examen clinique à l'admission :

Fréquence cardiaque : 85 /min Température corporelle : 36.9°C [Pression artérielle : 130/75 mmHg](Observation-cas8-exam-tas-01-cas8-exam-tad-01.html)

Examen locorégional de la hanche droite :

Membre inférieur droit en rotation externe et adduction.

Douleur intense à la palpation du grand trochanter.

Ecchymose de la face latérale de la hanche sans plaie cutanée.

Impotence fonctionnelle complète du membre inférieur droit.

Examen neurovasculaire :

Pouls pédieux et tibial postérieur présents et bien perçus.

Sensibilité conservée dans tous les territoires.

Motricité distale conservée avec flexion/extension des orteils possible malgré la douleur proximale.

Pas de signe de compression nerveuse.

Le reste de l'examen clinique est sans particularité.

Réalisation d'une [radiographie de la hanche droite et du bassin](Procedure-cas8-acte-02.html) mettant en évidence une [fracture per-trochantérienne droite déplacée](Condition-cas8-diag-01.html).

Prise en charge chirurgicale en urgence avec réalisation d'une [ostéosynthèse trochantérienne par clou gamma](Procedure-cas8-acte-01.html) le 11 janvier 2024 sous anesthésie générale par le Dr. Orthopédiste sans complication chirurgicale.

Les suites opératoires sont simples avec reprise d'appui possible à J1.

Antalgie multimodale post-opératoire par [Paracetamol 1 g](MedicationRequest-cas8-medpresc-02.html), [Nefopam 20 mg](MedicationRequest-cas8-medpresc-04.html), [Skenan 10 mg](MedicationRequest-cas8-medpresc-05.html) et [Actiskenan 5 mg](MedicationRequest-cas8-medpresc-06.html).

Introduction d'une anticoagulation préventive par [Enoxaparine 4000 UI par jour par voie sous cutanée](MedicationRequest-cas8-medpresc-01.html) le 11 janvier, à poursuivre pendant 1 mois.

Sur le plan de la rééducation :

 - [Kinésithérapie](Procedure-cas8-acte-03.html) débutée à J1 avec mobilisation de la hanche et travail musculaire isométrique
 - Marche avec appui partiel sur le membre inférieur droit et 2 cannes anglaises autorisé selon tolérance

Le patient rentre à domicile le 14 janvier 2024 avec un programme de rééducation en ambulatoire.

Il sera revu en consultation d'orthopédie dans 6 semaines avec une radiographie de la hanche de contrôle.

Consignes post-opératoires :

 - Poursuivre la kinésithérapie 3 fois par semaine
 - Appui partiel avec 2 cannes anglaises pendant 4 semaines puis avec 1 canne anglaise. La reprise de l'appui complet se fera selon les résultats de la radiographie de contrôle dans 6 semaines
 - Activité physique hors kinésithérapie contre indiquée pour le moment
 - Mouvements proscrits pendant les 6 premières semaines : flexion de hanche > 90°, rotation externe, croisement des jambes, adduction forcée

Signes d'alerte motivant une consultation aux urgences :

 - Fièvre, écoulement purulent au niveau de la cicatrice
 - Douleur, gonflement et rougeur du mollet
 - Douleur brutale de la hanche droite

Prescription de sortie :

 - [Paracétamol 1 g, 1 comprimé toutes les 6 h](MedicationRequest-cas8-medpresc-02.html) si douleurs
 - [Tramadol 50 mg, 1 comprimé toutes les 8 h](MedicationRequest-cas8-medpresc-03.html) si douleurs malgré le Paracétamol
 - [Enoxaparine 4000 UI, 1 injection par voie sous cutanée par jour pendant 1 mois](MedicationRequest-cas8-medpresc-01.html)

Fait à Henri-Mondor le 14 janvier 2024

#### Cas 9 : Ponction évacuatrice d'ascite

[Isabelle Blanc, née le 6 mai 1978](Patient-cas9-pat-01.html), [hospitalisée du 13 au 14 janvier 2024](Encounter-cas9-sej-01.html) dans le service d'hépatologie de l'hôpital Beaujon pour une [ponction évacuatrice d'ascite](Procedure-cas9-acte-01.html).

Patiente suivie dans le service depuis 7 ans dans un contexte de [cirrhose alcoolique](Condition-cas9-diag-02.html) compliquée d'une [ascite réfractaire](Condition-cas9-diag-01.html) nécessitant des ponctions évacuatrices régulières. Elle revient ce jour pour une [ponction évacuatrice](Procedure-cas9-acte-01.html).

Examen clinique :

Abdomen tendu avec matité à la percussion, périmètre abdo : 92 cm. [Poids 58.2 kg](Observation-cas9-exam-poids-01.html) à l'entré, soit 9 kg de plus que son poids de forme.

Examen neurologique normal, en particulier pas de signe d'encéphalopathie.

Le reste de l'examen est sans particularité.

Le bilan biologique à l'entrée retrouve un bilan hépatique stable avec :

 - [ASAT à 1.5 N](Observation-cas9-bio-asat-01.html), [ALAT 1.5 Na](Observation-cas9-bio-alat-01.html), [PAL à 100 U/LP](Observation-cas9-bio-pal-01.html), [GGT à 30 UI/L](Observation-cas9-bio-ggt-01.html), [bilirubinémie totale à 25 µmol/L](Observation-cas9-bio-bili-01.html)
 - [TP à 80%](Observation-cas9-bio-tp-01.html)
 - Albuminémie à 40 g/L

Soit un score de Child Pugh B7.

Réalisation d'une [ponction évacuatrice d'ascite](Procedure-cas9-acte-01.html), de 7 L avec [perfusion de 50 g d'Albumine](MedicationAdministration-cas9-medadm-01.html).

L'analyse du liquide d'ascite retrouve 57 PNN/mm3.

 - l'analyse du liquide d'ascite ne révèle pas d'infection (57 PNN/mm3)

La patiente rentre à domicile le 14 janvier 2025.

Elle sera reconvoquée pour la prochaine ponction évacuatrice.

Renouvellement de la prescription :

 - [Furosemide 40 mg, 1 comprimé le matin et le midi](MedicationRequest-cas9-medpresc-01.html)
 - [Spironolactone 25 mg, 1 comprimé le matin](MedicationRequest-cas9-medpresc-02.html)

Fait à Beaujon le 15 janvier 2024

#### Cas 10 : Exacerbation de BPCO

[Thomas David, né le 7 décembre 1989](Patient-cas10-pat-01.html), [hospitalisé du 16 au 19 janvier 2024](Encounter-cas10-sej-01.html) dans le service de pneumologie de l'hôpital Avicenne pour une [exacerbation de bronchopneumopathie chronique obstructive](Condition-cas10-diag-01.html).

Patient de 34 ans se présentant aux urgences de l'hôpital Avicenne le 16 janvier 2024 pour une dyspnée d'aggravation progressive depuis 5 jours. Il est dyspnéique au moindre effort et rapporte également une toux productive avec expectorations purulentes et verdâtres et une oppression thoracique.

Antécédents :

 - [Bronchopneumopathie chronique obstructive GOLD 3](Condition-cas10-diag-05.html) diagnostiquée à 31 ans diagnostiquée de façon précoce à l'âge de 31 ans.
 - [Allergie à la pénicilline](Condition-cas10-diag-02.html)
 - [Tabagisme actif avec consommation estimée à 20 paquets-années](à faire) (1 paquet par jour depuis l'âge de 15 ans)
 - [Consommation d'alcool occasionnelle](à faire)
 - [Pas d'activité physique régulière](à faire) car limité par sa dyspnée d'effort chronique

Examen clinique à l'admission :

Fréquence cardiaque : 105 /min, Fréquence respiratoire : 28 /min [Pression artérielle : 135/85 mmHg](Observation-cas10-exam-tas-01-cas10-exam-tad-01.html) Température : 37.8°C Saturation en oxygène : 88% en air ambiant

Examen respiratoire :

Patient en détresse respiratoire aigüe avec tirage sus claviculaire et intercostal.

Auscultation pulmonaire : sibilants diffus bilatéraux, diminution du murmure vésiculaire aux bases

Examen cardiovasculaire : tachycardie, bruits du cœur réguliers sans souffle, pas de signe d'insuffisance cardiaque droite.

Le bilan biologique à l'entrée retrouve :

 - [Anémie normocytaire](Condition-cas10-diag-03.html) avec [Hb à 11.2 g/dL](Observation-cas10-bio-hb-01.html) et [VGM à 87 fL](Observation-cas10-bio-vgm-01.html)
 - [Syndrome inflammatoire biologique](Condition-cas10-diag-04.html) avec [hyperleucocytose à 14 G/L](Observation-cas10-bio-leuco-01.html) et CRP à 58 mg/L
 - [Gazométrie artérielle](Procedure-cas10-acte-03.html) : pH 7.38, PaO2 = 62 mmHg, PaCO2 = 48 mmHg (discrète hypercapnie), Bicarbonates 29 mmol/L

La [radiographie thoracique](Procedure-cas10-acte-02.html) montre un thorax distendu avec aplatissement des coupoles diaphragmatiques, évocateur d'un emphysème, sans foyer de condensation alvéolaire.

[Un ECBC](Procedure-cas10-acte-05.html) est réalisé le 16 janvier 2024.

Le patient est transféré dans le service de pneumologie pour la suite de la prise en charge.

La prise en charge initiale consiste en :

 - [Oxygénothérapie à 2 L/min aux lunettes nasales](MedicationRequest-cas10-medpresc-06.html) avec objectif de SpO2 entre 88 et 92%
 - Aérosolthérapie avec administration de [Terbutaline 5 mg toutes les 6 heures et de Bromure d'ipratropium 0.5 mg toutes les 8 heures](MedicationRequest-cas10-medpresc-07.html)
 - Antibiothérapie probabiliste par [Azithromycine](MedicationRequest-cas10-medpresc-03.html) compte tenu de l'antécédent d'allergie à la pénicilline et des crachats verdâtres chez un patient avec BPCO GOLD 3.
 - [Kinésithérapie respiratoire](Procedure-cas10-acte-04.html)

L'évolution est progressivement favorable avec sevrage de l'oxygénothérapie à J2 et reprise du traitement de fond. L'ECBC réalisé le 16 janvier est de mauvaise qualité et retrouve de la flore orale polymorphe donc poursuite de l'antibiothérapie probabiliste initiale pour 5 jours au total.

Concernant la maladie respiratoire chronique :

 - Nous insistons sur la nécessité d'un arrêt total et définitif du tabac qui est primordial pour ralentir la progression de la maladie. Nous organisons une consultation de tabacologie dans 2 semaines au patient et nous lui prescrivons des [substituts nicotiniques](MedicationRequest-cas10-medpresc-04.html)
 - Le patient sera convoqué dans les prochaines semaines pour débuter une réhabilitation respiratoire dans un centre spécialisé
 - Nous remettons une prescription du [vaccin anti-pneumococcique](MedicationRequest-cas10-medpresc-09.html) à faire en ville et nous informons le patient de l'importance de se faire vacciner contre la grippe chaque année et contre le COVID tous les 6 mois.

Le patient rentre à domicile le 19 janvier 2024.

Il sera revu en consultation de pneumologie dans 1 mois et convoqué prochainement en réhabilitation respiratoire.

Prescription de sortie :

 - [Ultibro Breezhaler 85/43 µg](MedicationRequest-cas10-medpresc-01.html), 1 inhalation le matin
 - [Salbutamol 100 µg](MedicationRequest-cas10-medpresc-02.html) en inhalation : 1-2 bouffées 4 fois par jour et à la demande en cas de gêne respiratoire
 - [Azithromycine 250 mg, 1 comprimé par jour](MedicationRequest-cas10-medpresc-03.html) (fin du traitement antibiotique à J5)
 - [Nicopatch 15 mg](MedicationRequest-cas10-medpresc-04.html) 1 patch à appliquer le matin et à retirer avant de dormir
 - [Nicorette gomme 2 mg](MedicationRequest-cas10-medpresc-05.html), prendre une gomme en cas d'envie de fumer malgré le patch, ne pas dépasser 20 par jours

Fait à Avicenne le 19 janvier 2024