### Exemples porteurs

`FrSimpleQuantityUcum` est un profil de type de donnée : il n'a pas d'instance propre et s'observe dans les ressources qui l'utilisent. Il type les doses des profils [EdshMedicationAdministration](StructureDefinition-edsh-medication-administration.html) et [EdshMedicationRequest](StructureDefinition-edsh-medication-request.html), ainsi que les bornes de [FrRangeUcum](StructureDefinition-fr-range-ucum.html) et les termes de [FrRatioUcum](StructureDefinition-fr-ratio-ucum.html).

Exemples qui le portent :

- `MedicationAdministration.dosage.dose` dans les administrations des cas d'usage, par exemple [cas1-medadm-01](MedicationAdministration-cas1-medadm-01.html), [cas4-medadm-01](MedicationAdministration-cas4-medadm-01.html) ou [cas9-medadm-01](MedicationAdministration-cas9-medadm-01.html) ;
- `MedicationRequest.dosageInstruction.maxDosePerAdministration`, ainsi que les bornes de `doseRange` et les termes de `rateRatio` et `maxDosePerPeriod`, dans [edsh-medication-request-example](MedicationRequest-edsh-medication-request-example.html).
