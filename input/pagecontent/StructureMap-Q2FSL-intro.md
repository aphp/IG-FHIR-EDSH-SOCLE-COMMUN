### Explication détaillées

Le group `CreatePatient` alimente la ressource Patient à partir des éléments d'informations contenus dans le QR, à savoir : 

- élément `id` : génération d'un uuid
- élément `name` : alimenté à partir des items "Nom patient" (8605698058770) et "Prénom patient" (6214879623503)
- élément `identifier` : plusieurs identifiants peuvent être créé :
  - le NIR, à partir de l'item "Numéro d'inscription au Répertoire (NIR)" (5711960356160)
  - l'INS, à partir de l'item "Identité Nationale de Santé (INS)" (3764723550987)
- élément `birthDate` : alimenté à partir de l'item "Date de naissance" (5036133558154)
- élément `deceased[x]` : alimenté à partir de l'item "Date de décès" (5633552097315). La source de cette information peut être renseigné dans l'extension `edsh-death-source` à partir de l'item "Source de la date de décès" (9098810065693)
- élémént `multipleBirth[x]` : alimenté à partir de l'item "Rang gémellaire du bénéficiaire" (6931296968515)
- élément `gender` : alimenté à partir de l'item "Sexe" (3894630481120)
- élément `address` : plusieurs informations peuvent être renseigné :
  - le code commune PMSI, issue de l'item "Code géographique de résidence" (2446369196222) alimente l'extension `edsh-pmsi-code-geo`
  - les coordonnées géographiques alimentent l'extension `geolocation` :
    - la latitude provient de l'item "Latitude" (3709843054556)
    - la longitude provient de l'item "Longitude" (7651448032665)
  - l'IRIS, issue de l'item "IRIS" (7621032273792) alimente l'extension `iso21090-ADXP-censusTract`

``` fml
// Group: Create Patient from QuestionnaireResponse
group CreatePatient(source src : QuestionnaireResponse, target patient : Patient) {
  src -> patient.id = uuid() "patient-id";
  src -> patient.meta = create('Meta') as meta then {
    src -> meta.profile = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-patient' "patient-profile";
  } "patient-meta";

  // Extract patient identity data from linkId 4647259356106 > 2958000860428
  src.item as socioDemo where (linkId = '4647259356106') then {
    socioDemo.item as identity where (linkId = '2958000860428') then {

      // Patient name (linkId 8605698058770 = family, 6214879623503 = given)
      identity -> patient.name = create('HumanName') as name then {
        identity.item as familyItem where (linkId = '8605698058770') then {
          familyItem.answer as ans -> name.family = (%ans.valueString) "set-family";
        } "extract-family";
        identity.item as givenItem where (linkId = '6214879623503') then {
          givenItem.answer as ans -> name.given = (%ans.valueString) "set-given";
        } "extract-given";
      } "set-name";

      // NIR identifier (linkId 5711960356160)
      identity.item as nirItem where (linkId = '5711960356160') then {
        nirItem.answer as ans -> patient.identifier = create('Identifier') as nir then {
          ans -> nir.system = 'urn:oid:1.2.250.1.213.1.4.8' "nir-system";
          ans -> nir.value = (%ans.valueString) "nir-value";
          ans -> nir.type = cc('http://interopsante.org/fhir/CodeSystem/fr-v2-0203', 'NIR') "nir-type";
        } "set-nir";
      } "extract-nir";

      // INS identifier (linkId 3764723550987)
      identity.item as insItem where (linkId = '3764723550987') then {
        insItem.answer as ans -> patient.identifier = create('Identifier') as ins then {
          ans -> ins.system = 'urn:oid:1.2.250.1.213.1.4.10' "ins-system";
          ans -> ins.value = (%ans.valueString) "ins-value";
          ans -> ins.type = cc('http://interopsante.org/fhir/CodeSystem/fr-v2-0203', 'INS-C') "ins-type";
        } "set-ins";
      } "extract-ins";

      // Birth date (linkId 5036133558154)
      identity.item as birthItem where (linkId = '5036133558154') then {
        birthItem.answer as ans -> patient.birthDate = (%ans.valueDate) "set-birthdate";
      } "extract-birthdate";

      // Death date (linkId 5633552097315)
      identity.item as deathItem where (linkId = '5633552097315') then {
        deathItem.answer as ans -> patient.deceased = (%ans.valueDate) "set-deceased-date";
        // Death source (linkId 9098810065693)
        deathItem.item as deathSource where (linkId = '9098810065693') then {
          deathSource.answer as sourceAns -> patient.extension = create('Extension') as ext then {
            sourceAns -> ext.url = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-death-source' "death-source-url";
            sourceAns -> ext.value = (%sourceAns.valueCoding) "death-source-value";
          } "set-death-source-ext";
        } "extract-death-source";
      } "extract-death";

      // Multiple birth rank (linkId 6931296968515)
      identity.item as multipleItem where (linkId = '6931296968515') then {
        multipleItem.answer as ans -> patient.multipleBirth = (%ans.valueInteger) "set-multiple-birth";
      } "extract-multiple-birth";

    } "process-identity";

    // Gender from PMSI data (linkId 3894630481120 within 2825244231605)
    src.item as pmsiGroup where (linkId = '2825244231605') then {
      pmsiGroup.item as sexItem where (linkId = '3894630481120') then {
        sexItem.answer as ans then {
          ans.valueString as female where ($this = 'f') -> patient.gender = 'female' "setGenderF";
          ans.valueString as female where ($this = 'm') -> patient.gender = 'male' "setGenderM";
        } "valueCoding";
      } "extract-gender";

      // Address from code géographique (linkId 2446369196222)
      pmsiGroup.item as codeGeoItem where (linkId = '2446369196222') then {
        codeGeoItem.answer as ans -> patient.address = create('Address') as addr then {
          ans -> addr.extension = create('Extension') as ext then {
            ans -> ext.url = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-pmsi-code-geo' "codegeo-url";
            ans.value as val -> ext.value = cast(val, 'code') "codegeo-value";
          } "set-codegeo-ext";

          // Environnement
          socioDemo.item as environnementItem where (linkId = '5491974639955') then {
            // geolocation
            environnementItem.item as geocodageItem where (linkId = '3816475533472') -> addr.extension = create('Extension') as geolocationExt then {
              geocodageItem.item as latItem where (linkId = '3709843054556') -> geolocationExt.url = 'http://hl7.org/fhir/StructureDefinition/geolocation', geolocationExt.extension = create('Extension') as latExt then {
                latItem.answer as lat -> latExt.url = 'latitude', latExt.value = (%lat.valueDecimal) then {
                  geocodageItem.item as longItem where (linkId = '7651448032665') -> geolocationExt.extension = create('Extension') as longExt then {
                    longItem.answer as long -> longExt.url = 'longitude', longExt.value = (%long.valueDecimal) "setLong";
                  } "createLongExt";
                } "setLat";
              } "createLatExt";
            } "createGeolocExt";
            // IRIS
            environnementItem.item as irisItem where (linkId = '7621032273792') -> addr.line as addrLine, addrLine.extension = create('Extension') as irisExt then {
              irisItem.answer as ans -> irisExt.url = 'http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-censusTract',
              irisExt.valueString = (%ans.valueString) "setIrisExt";
            } "navIrisItem";

          } "navEnv";

        } "set-address";
      } "extract-codegeo";
    } "extract-pmsi-demographics";

  } "process-sociodemographics";
}
```
