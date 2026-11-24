### Exemples porteurs

`FrRangeUcum` est un profil de type de donnée : il n'a pas d'instance propre et s'observe dans les ressources qui l'utilisent. Dans ce guide, il type `dosageInstruction.doseAndRate.dose[x]` et `rate[x]` du profil [EdshMedicationRequest](StructureDefinition-edsh-medication-request.html).

Il n'est pas utilisé par `Observation.referenceRange` : les bornes d'un intervalle de référence de biologie restent des `SimpleQuantity` de base, dont l'unité UCUM est contrôlée par les invariants `dm-lab-*`.

Exemple qui le porte : [edsh-medication-request-example](MedicationRequest-edsh-medication-request-example.html), `doseRange` de 500 à 1000 mg par prise, la dose dépendant de l'intensité de la douleur (`asNeededCodeableConcept`).
