### Exemples porteurs

`EdshAddress` est un profil de type de donnée : il n'a pas d'instance propre et s'observe dans les ressources qui l'utilisent. Il type `Patient.address` dans le profil [EdshPatient](StructureDefinition-edsh-patient.html).

Les ressources `Patient` des dix cas d'usage portent chacune une adresse conforme à ce profil, avec l'extension `PmsiCodeGeo` (code géographique PMSI de résidence) :
[cas 1](Patient-cas1-pat-01.html), [cas 2](Patient-cas2-pat-01.html), [cas 3](Patient-cas3-pat-01.html), [cas 4](Patient-cas4-pat-01.html), [cas 5](Patient-cas5-pat-01.html), [cas 6](Patient-cas6-pat-01.html), [cas 7](Patient-cas7-pat-01.html), [cas 8](Patient-cas8-pat-01.html), [cas 9](Patient-cas9-pat-01.html), [cas 10](Patient-cas10-pat-01.html).
