### Exemples porteurs

`FrRatioUcum` est un profil de type de donnée : il n'a pas d'instance propre et s'observe dans les ressources qui l'utilisent. Il type le débit (`rate[x]`) des profils [EdshMedicationAdministration](StructureDefinition-edsh-medication-administration.html) et [EdshMedicationRequest](StructureDefinition-edsh-medication-request.html), ainsi que `amount` et `ingredient.strength` des profils `FrMedication*`.

Exemple qui le porte : [edsh-medication-request-example](MedicationRequest-edsh-medication-request-example.html), `maxDosePerPeriod` de 3 g pour 24 h. Les profils `FrMedication*` sont repris de `ans.fhir.fr.eprescription`, dont le guide fournit des exemples de ces formes.
