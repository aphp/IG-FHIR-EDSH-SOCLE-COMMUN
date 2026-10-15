L'extension `EdshDeathSource` se pose sur l'élément `Patient.deceased[x]` : elle indique la source (Insee, CépiDc, système d'information hospitalier) dont provient le statut vital du patient. Les codes possibles sont définis dans le [ValueSet des sources d'information sur le statut vital](ValueSet-death-source-vs.html).

### Exemple

L'exemple [Patient décédé](Patient-edsh-patient-deceased-example.html) (profil [EdshPatient](StructureDefinition-edsh-patient.html)) porte cette extension. Sa date de décès provient du système d'information hospitalier :

```json
"deceasedDateTime": "2024-02-01T04:20:00+01:00",
"_deceasedDateTime": {
  "extension": [
    {
      "url": "https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-death-source",
      "valueCode": "sih"
    }
  ]
}
```

En FHIR R4, une ressource ne peut être déclarée exemple que d'un seul profil. Ce patient est donc rattaché à `EdshPatient` et n'apparaît pas automatiquement dans l'onglet « Exemples » de cette extension.

{% include markdown-link-references.md %}
