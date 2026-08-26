### Explication détaillées

La StructureMap comporte 10 groupes. Le point d'entrée `QuestionnaireResponseToBundle`
initialise le `Bundle` puis enchaîne les 8 autres groupes producteurs de ressources ;
`CreateLabObservation` est un groupe utilitaire appelé par `CreateLaboratoryObservations`
pour chacune des 23 analyses de biologie, afin d'éviter de dupliquer 23 fois la même
logique de construction d'`Observation`.

#### `QuestionnaireResponseToBundle` — point d'entrée

Initialise le `Bundle` (`type = collection`, `timestamp`), crée l'entrée `Patient` et
enchaîne, dans cet ordre, tous les autres groupes producteurs de ressources : `CreatePatient`,
 `CreateEncounters` (qui enchaîne lui-même `CreateConditions` et
`CreateProcedures`), `CreateLaboratoryObservations`, `CreateMedicationRequests`,
`CreateMedicationAdministrations`, `CreateVitalSignObservations`.

``` fml
group QuestionnaireResponseToBundle(source src : QuestionnaireResponse, target bundle : Bundle) {
  src -> bundle.type = 'collection' "bundle-type";
  src -> bundle.timestamp = (now()) "setTimestamp";
  src -> bundle.entry as patientEntry then {
    src -> patientEntry.resource = create('Patient') as patient then {
      src then CreatePatient(src, patient) "create-patient";
      src -> patient.id as patientId, patientEntry.fullUrl = append('urn:uuid:', patientId) "set-fullUrl";
      src then CreateLocations(src, patient, bundle) "create-locations";
      src then CreateEncounters(src, patient, bundle) "create-encounters";
      src then CreateLaboratoryObservations(src, patient, bundle) "create-lab-observations";
      src then CreateMedicationRequests(src, patient, bundle) "create-medication-requests";
      src then CreateMedicationAdministrations(src, patient, bundle) "create-medication-administrations";
      src then CreateVitalSignObservations(src, patient, bundle) "create-vital-signs";
    } "create-patient-resource";
  } "patient-entry";
}
```

#### `CreatePatient`

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

#### `CreateEncounters`

Crée l'`Encounter` à partir du groupe PMSI (linkId 2825244231605) :

- `id` : dérivé de l'id du Patient en remplaçant `-pat-` par `-sej-`
- `status = finished`, `class = IMP` (hospitalisation, v3-ActCode)
- `period.start` / `period.end` : dates de début/fin de séjour (linkId 5991443718282 /
  6114780320846)
- `hospitalization.admitSource` / `dischargeDisposition` : mode d'entrée (linkId
  6172398101212) / mode de sortie (linkId 3354867075704)
- enchaîne `CreateConditions` et `CreateProcedures` sur ce même item PMSI

``` fml
group CreateEncounters(source src : QuestionnaireResponse, target patient : Patient, target bundle : Bundle) {
  src.item as pmsiItem where (linkId = '2825244231605') -> bundle.entry as encounterEntry then {
    pmsiItem -> encounterEntry.resource = create('Encounter') as encounter then {
      src -> patient.id as patIdForEnc, encounter.id = (%patIdForEnc.replace('-pat-', '-sej-')) "set-encounter-id";
      pmsiItem -> encounter.meta = create('Meta') as meta then {
        pmsiItem -> meta.profile = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-encounter' "encounter-profile";
      } "encounter-meta";
      src -> encounter.status = 'finished' "setStatus";
      src -> encounter.class = c('http://terminology.hl7.org/CodeSystem/v3-ActCode', 'IMP') "setClass";
      src -> encounter.subject = create('Reference') as ref, patient.id as patId, ref.reference = append('Patient/', patId) "set-subject";
      pmsiItem -> encounter.period = create('Period') as period then {
        pmsiItem.item as startItem where (linkId = '5991443718282') then {
          startItem.answer as ans -> period.start = (%ans.value.ofType(date)) "set-start";
        } "extract-start";
        pmsiItem.item as endItem where (linkId = '6114780320846') then {
          endItem.answer as ans -> period.end = (%ans.value.ofType(date)) "set-end";
        } "extract-end";
      } "set-period";
      pmsiItem.item as modeInItem where (linkId = '6172398101212') then {
        modeInItem.answer as ans then {
          ans.valueString as valueString -> encounter.hospitalization as hosp, hosp.admitSource as admitSource,
            admitSource.coding as admitSourceCoding, admitSourceCoding.code = valueString "set-admit-source";
        } "navValue";
      } "extract-mode-in";
      pmsiItem.item as modeOutItem where (linkId = '3354867075704') then {
        modeOutItem.answer as ans then {
          ans.valueString as valueString -> encounter.hospitalization as hosp, hosp.dischargeDisposition as dischargeDisposition,
            dischargeDisposition.coding as dischargeDispositionCoding, dischargeDispositionCoding.code = valueString "set-discharge-disposition";
        } "navValue";
      } "extract-mode-out";
      src -> encounter.id as encId, encounterEntry.fullUrl = append('urn:uuid:', encId) "set-fullUrl";
      pmsiItem then CreateConditions(pmsiItem, patient, encounter, bundle) "create-conditions";
      pmsiItem then CreateProcedures(pmsiItem, patient, encounter, bundle) "create-procedures";
    } "create-encounter";
  } "encounter-entry";
}
```

#### `CreateConditions`

Un `Condition` par diagnostic (groupe répétable, linkId 9391816419630), appelé par
`CreateEncounters` :

- `id` : item "Identifiant" (linkId 123759733087)
- `code` : diagnostic CIM-10 (linkId 5505101189372)
- `category` : type de diagnostic (DP/DR/DA/DAD, linkId 6427586743735), codé dans le
  CodeSystem local `pmsi-mco-diag-type`
- `recordedDate` : linkId 7114466839467
- `subject` / `encounter` : références vers le Patient et l'Encounter du groupe appelant

``` fml
group CreateConditions(source pmsiItem, target patient : Patient, target encounter : Encounter, target bundle : Bundle) {
  pmsiItem.item as diagGroup where (linkId = '9391816419630') -> bundle.entry as conditionEntry then {
    diagGroup -> conditionEntry.resource = create('Condition') as condition then {
      diagGroup.item as condIdItem where (linkId = '123759733087') then {
        condIdItem.answer as condIdAns -> condition.id = (%condIdAns.value.ofType(string)) "set-condition-id";
      } "extract-condition-id";
      diagGroup -> condition.meta = create('Meta') as meta then {
        diagGroup -> meta.profile = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-condition' "condition-profile";
      } "condition-meta";
      diagGroup -> condition.subject = create('Reference') as ref, patient.id as patId, ref.reference = append('Patient/', patId) "set-subject";
      diagGroup -> encounter.id as encId, condition.encounter = create('Reference') as ref, ref.reference = append('Encounter/', encId) "set-encounter";
      diagGroup.item as diagCodeItem where (linkId = '5505101189372') then {
        diagCodeItem.answer as ans -> condition.code = create('CodeableConcept') as code then {
          ans -> code.coding as coding, coding.code = (%ans.value.ofType(string)) "set-coding";
        } "set-code";
      } "extract-diag-code";
      diagGroup.item as diagTypeItem where (linkId = '6427586743735') then {
        diagTypeItem.answer as ans -> condition.category = create('CodeableConcept') as category then {
          ans -> category.coding = create('Coding') as coding then {
            ans -> coding.system = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/CodeSystem/pmsi-mco-diag-type' "diag-type-system";
            ans -> coding.code = (%ans.value.ofType(string)) "diag-type-code";
          } "set-category-coding";
        } "set-category";
      } "extract-diag-type";
      diagGroup.item as dateItem where (linkId = '7114466839467') then {
        dateItem.answer as ans -> condition.recordedDate = (%ans.value.ofType(date)) "set-recorded-date";
      } "extract-recorded-date";
      pmsiItem -> condition.id as condId, conditionEntry.fullUrl = append('urn:uuid:', condId) "set-fullUrl";
    } "create-condition";
  } "condition-entry";
}
```

#### `CreateProcedures`

Un `Procedure` par acte (groupe répétable, linkId 591926901726), appelé par
`CreateEncounters` — même structure que `CreateConditions` :

- `id` : linkId 151762387793 ; `status = completed`
- `code` : acte CCAM (linkId 7758110033600)
- `performed` : date/heure de réalisation (linkId 5066866286682)
- `subject` / `encounter` : références vers le Patient et l'Encounter du groupe appelant

``` fml
group CreateProcedures(source pmsiItem, target patient : Patient, target encounter : Encounter, target bundle : Bundle) {
  pmsiItem.item as acteGroup where (linkId = '591926901726') -> bundle.entry as procedureEntry then {
    acteGroup -> procedureEntry.resource = create('Procedure') as procedure then {
      acteGroup.item as procIdItem where (linkId = '151762387793') then {
        procIdItem.answer as procIdAns -> procedure.id = (%procIdAns.value.ofType(string)) "set-procedure-id";
      } "extract-procedure-id";
      acteGroup -> procedure.meta = create('Meta') as meta then {
        acteGroup -> meta.profile = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-procedure' "procedure-profile";
      } "procedure-meta";
      acteGroup -> procedure.status = 'completed' "setStatus";
      acteGroup -> procedure.subject = create('Reference') as ref, patient.id as patId, ref.reference = append('Patient/', patId) "set-subject";
      acteGroup -> encounter.id as encId, procedure.encounter = create('Reference') as ref, ref.reference = append('Encounter/', encId) "set-encounter";
      acteGroup.item as acteCodeItem where (linkId = '7758110033600') then {
        acteCodeItem.answer as ans -> procedure.code = create('CodeableConcept') as code then {
          ans -> code.coding as coding, coding.code = (%ans.value.ofType(string)) "set-coding";
        } "set-code";
      } "extract-acte-code";
      acteGroup.item as dateItem where (linkId = '5066866286682') then {
        dateItem.answer as ans -> procedure.performed = (%ans.value.ofType(dateTime)) "set-performed";
      } "extract-performed-date";
      pmsiItem -> procedure.id as procId, procedureEntry.fullUrl = append('urn:uuid:', procId) "set-fullUrl";
    } "create-procedure";
  } "procedure-entry";
}
```

#### `CreateMedicationRequests`

Un `MedicationRequest` par médicament prescrit (groupe "Exposition médicamenteuse", linkId
817801935685 > groupe "Médicament prescrit", linkId 156631794800) :

- `id` : linkId 145920953908 ; `status = active`, `intent = order`
- `medication` : code ATC (linkId 1923143398283), avec le `display` repris du libellé de
  la réponse elle-même
- `dosageInstruction.route` : voie d'administration (linkId 387026794874)
- `dosageInstruction.timing.repeat.bounds` : dates de début/fin de la posologie (groupe
  "Posologie", linkId 6348237104421, sous-items 316347573327/429570775935)

``` fml
group CreateMedicationRequests(source src : QuestionnaireResponse, target patient : Patient, target bundle : Bundle) {
  src.item as medExpoGroup where (linkId = '817801935685') then {
    medExpoGroup.item as prescribedGroup where (linkId = '156631794800') -> bundle.entry as medReqEntry then {
      prescribedGroup -> medReqEntry.resource = create('MedicationRequest') as medReq then {
        prescribedGroup.answer as prescribedMedForId then {
          prescribedMedForId.item as medReqIdItem where (linkId = '145920953908') then {
            medReqIdItem.answer as medReqIdAns -> medReq.id = (%medReqIdAns.value.ofType(string)) "set-medreq-id";
          } "extract-medreq-id";
        } "navPrescribedMedForId";
        src -> medReq.id as medReqId, medReqEntry.fullUrl = append('urn:uuid:', medReqId) "set-fullUrl";
        prescribedGroup -> medReq.meta = create('Meta') as meta then {
          prescribedGroup -> meta.profile = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-medication-request' "medreq-profile";
        } "medreq-meta";
        prescribedGroup -> medReq.subject = create('Reference') as ref, patient.id as patId, ref.reference = append('Patient/', patId) "set-subject";
        prescribedGroup -> medReq.status = 'active' "set-status";
        prescribedGroup -> medReq.intent = 'order' "set-intent";
        prescribedGroup.answer as prescribedMedication then {
          prescribedMedication.item as atcItem where (linkId = '1923143398283') then {
            atcItem.answer as ans -> medReq.medication = create('CodeableConcept') as medReqCC,
              medReqCC.coding as medReqC, medReqC.code = (%ans.value.ofType(string)),
              medReqC.display = (%prescribedMedication.value.ofType(string)) "setAtcCoding";
          } "navAtcItem";
        } "navPrescribedMedication";
        prescribedGroup -> medReq.dosageInstruction = create('Dosage') as dosage then {
          prescribedGroup.answer as prescribedMedication then {
            prescribedMedication.item as routeItem where (linkId = '387026794874') then {
              routeItem.answer as ans -> dosage.route as route then {
                ans -> route.coding as routeCoding, routeCoding.code = (%ans.value.ofType(string)) "set-route-coding";
              } "set-route";
            } "navRouteItem";
          } "navPrescribedMedication";
          medExpoGroup.item as posoGroup where (linkId = '6348237104421') -> dosage.timing as timing,
            timing.repeat as timingRepeat, timingRepeat.bounds = create('Period') as timingPeriod then {
              posoGroup.item as DateDebItem where (linkId = '316347573327') then {
                DateDebItem.answer as ans -> timingPeriod.start = (%ans.value.ofType(date)) "setDateDeb";
              } "navDateDeb";
              posoGroup.item as DateFinItem where (linkId = '429570775935') then {
                DateFinItem.answer as ans -> timingPeriod.end = (%ans.value.ofType(date)) "setDateFin";
              } "navDateFin";
          } "navPoso";
        } "set-dosage";
      } "create-medreq";
    } "medreq-entry";
  } "process-med-expo";
}
```

#### `CreateMedicationAdministrations`

Un `MedicationAdministration` par médicament administré (même groupe "Exposition
médicamenteuse", linkId 817801935685 > groupe "Médicament administré", linkId
266852453304) — même logique que `CreateMedicationRequests`, avec `dosage` au lieu de
`dosageInstruction` :

- `id` : linkId 870029232684 ; `status = completed`
- `medication` : code ATC (linkId 631972144976)
- `dosage.route` : linkId 811931484859
- `dosage.dose` : quantité administrée (groupe "Dosage", linkId 5720103839343, sous-item
  4765772671997)
- `effective` (Period) : date/heure de début et de fin d'administration (linkId
  1443558617577 / 780829110731)

``` fml
group CreateMedicationAdministrations(source src : QuestionnaireResponse, target patient : Patient, target bundle : Bundle) {
  src.item as medExpoGroup where (linkId = '817801935685') then {
    medExpoGroup.item as adminGroup where (linkId = '266852453304') -> bundle.entry as medAdminEntry then {
      adminGroup -> medAdminEntry.resource = create('MedicationAdministration') as medAdmin then {
        adminGroup.answer as administeredMedForId then {
          administeredMedForId.item as medAdminIdItem where (linkId = '870029232684') then {
            medAdminIdItem.answer as medAdminIdAns -> medAdmin.id = (%medAdminIdAns.value.ofType(string)) "set-medadmin-id";
          } "extract-medadmin-id";
        } "navAdministeredMedForId";
        src -> medAdmin.id as medAdminId, medAdminEntry.fullUrl = append('urn:uuid:', medAdminId) "set-fullUrl";
        adminGroup -> medAdmin.meta = create('Meta') as meta then {
          adminGroup -> meta.profile = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-medication-administration' "medadmin-profile";
        } "medadmin-meta";
        adminGroup -> medAdmin.subject = create('Reference') as ref, patient.id as patId, ref.reference = append('Patient/', patId) "set-subject";
        adminGroup -> medAdmin.status = 'completed' "set-status";
        adminGroup.answer as administeredMedication then {
          administeredMedication.item as atcItem where (linkId = '631972144976') then {
            atcItem.answer as ans -> medAdmin.medication = create('CodeableConcept') as medAdminCC,
              medAdminCC.coding as medAdminC, medAdminC.code = (%ans.value.ofType(string)),
              medAdminC.display = (%administeredMedication.value.ofType(string)) "setAtcCoding";
          } "navAtcItem";
        } "navadministeredMedication";
        adminGroup -> medAdmin.dosage as dosage then {
          adminGroup.answer as administeredMedication then {
            administeredMedication.item as routeItem where (linkId = '811931484859') then {
              routeItem.answer as ans -> dosage.route = create('CodeableConcept') as route then {
                ans -> route.coding as routeCoding, routeCoding.code = (%ans.value.ofType(string)) "set-route-coding";
              } "set-route";
            } "navRoute";
          } "navadministeredMedication";
          medExpoGroup.item as doseGroup where (linkId = '5720103839343') then {
            doseGroup.item as quantityItem where (linkId = '4765772671997') then {
              quantityItem.answer as ans -> dosage.dose = (%ans.value.ofType(Quantity)) "setDose";
            } "navquantity";
            doseGroup.item as startItem where (linkId = '1443558617577') then {
              startItem.answer as startAns then {
                doseGroup.item as endItem where (linkId = '780829110731') then {
                  endItem.answer as endAns -> medAdmin.effective = create('Period') as adminPeriod,
                    adminPeriod.start = (%startAns.value), adminPeriod.end = (%endAns.value) "setAdminPeriod";
                } "navEnd";
              } "navStartAns";
            } "navStart";
          } "navDosage";
        } "set-dosage";
      } "create-medadmin";
    } "medadmin-entry";
  } "process-med-expo-admin";
}
```

#### `CreateVitalSignObservations`

Trois `Observation` de signes vitaux, à partir du groupe "Dossier de soins" (linkId
305831246173, sous "Examen clinique", linkId 214880328197) — toutes en
`category = vital-signs` :

- **Taille** (linkId 4846902346416) → profil `edsh-observation-body-height`, LOINC
  8302-2 ; `effective` = linkId 941821315470
- **Poids** (linkId 451513217936) → profil `edsh-observation-body-weight`, LOINC 29463-7 ;
  `effective` = linkId 151269044052
- **Pression artérielle** (systolique linkId 4160905247955 + diastolique linkId
  848797127998, combinées) → profil `edsh-observation-blood-pressure`, LOINC panel
  85354-9, avec deux composants LOINC 8480-6 (systolique) et 8462-4 (diastolique) ;
  `id` = concaténation des deux ids systolique/diastolique ; `effective` = linkId
  987654638442

``` fml
group CreateVitalSignObservations(source src : QuestionnaireResponse, target patient : Patient, target bundle : Bundle) {
  src.item as examGroup where (linkId = '214880328197') then {
    examGroup.item as dossierGroup where (linkId = '305831246173') then {
      dossierGroup.item as heightItem where (linkId = '4846902346416') then {
        heightItem.answer as ans -> bundle.entry as obsEntry then {
          ans -> obsEntry.resource = create('Observation') as obs then {
            ans.item as heightIdItem where (linkId = '854021250495') then {
              heightIdItem.answer as heightIdAns -> obs.id = (%heightIdAns.value.ofType(string)) "set-obs-id";
            } "extract-height-id";
            ans -> obs.id as obsId, obsEntry.fullUrl = append('urn:uuid:', obsId) "set-fullUrl";
            ans -> obs.meta = create('Meta') as meta then {
              ans -> meta.profile = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-observation-body-height' "obs-profile";
            } "obs-meta";
            ans -> obs.status = 'final' "obs-status";
            ans -> obs.category = cc('http://terminology.hl7.org/CodeSystem/observation-category', 'vital-signs') "obs-category";
            ans -> obs.code = cc('http://loinc.org', '8302-2', 'Body height') "obs-code";
            ans -> obs.subject = create('Reference') as ref, patient.id as patId, ref.reference = append('Patient/', patId) "set-subject";
            ans -> obs.value = (%ans.value.ofType(Quantity)) as tgtObsVal,
              tgtObsVal.code = (%ans.value.ofType(Quantity).unit), tgtObsVal.system = 'http://unitsofmeasure.org' "set-value";
            ans.item as dateItem where (linkId = '941821315470') then {
              dateItem.answer as dateAns then {
                dateAns.value as val -> obs.effective = cast(val, 'dateTime') "set-effective";
              } "navDateAns";
            } "extract-effective";
          } "create-height-obs";
        } "height-obs-entry";
      } "extract-height";
      dossierGroup.item as weightItem where (linkId = '451513217936') then {
        // même structure que height, profil edsh-observation-body-weight, LOINC 29463-7
      } "extract-weight";
      dossierGroup.item as sysItem where (linkId = '4160905247955') then {
        sysItem.answer as sysAns then {
          dossierGroup.item as diaItem where (linkId = '848797127998') then {
            diaItem.answer as diaAns -> bundle.entry as obsEntry then {
              sysAns -> obsEntry.resource = create('Observation') as obs then {
                // id = concaténation id systolique + id diastolique
                sysAns -> obs.meta = create('Meta') as meta then {
                  sysAns -> meta.profile = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-observation-blood-pressure' "obs-profile";
                } "obs-meta";
                sysAns -> obs.code = cc('http://loinc.org', '85354-9', 'Blood pressure panel') "obs-code";
                sysAns -> obs.component as sysComp then {
                  sysAns -> sysComp.code = cc('http://loinc.org', '8480-6', 'Systolic blood pressure') "sys-code";
                  sysAns -> sysComp.value = (%sysAns.value.ofType(Quantity)) as sysVal,
                    sysVal.code = (%sysAns.value.ofType(Quantity).unit), sysVal.system = 'http://unitsofmeasure.org' "sys-value";
                } "set-systolic";
                diaAns -> obs.component as diaComp then {
                  diaAns -> diaComp.code = cc('http://loinc.org', '8462-4', 'Diastolic blood pressure') "dia-code";
                  diaAns -> diaComp.value = (%diaAns.value.ofType(Quantity)) as diaVal,
                    diaVal.code = (%diaAns.value.ofType(Quantity).unit), diaVal.system = 'http://unitsofmeasure.org' "dia-value";
                } "set-diastolic";
              } "create-bp-obs";
            } "bp-obs-entr";
          } "extract-diastolic";
        } "process-systolic";
      } "extract-blood-pressure";
    } "process-dossier";
  } "process-exam";
}
```

#### `CreateLaboratoryObservations` et `CreateLabObservation`

`CreateLaboratoryObservations` parcourt les 4 sous-groupes de biologie du Questionnaire
(fonction rénale linkId 5241323453538, hémogramme linkId 419282985970, bilan hépatique
linkId 796308115381, autres/glucose linkId 334039497382) et appelle, pour chacune des 23
analyses, le groupe utilitaire **`CreateLabObservation`** — c'est ce dernier qui construit
effectivement l'`Observation`, toujours conforme au profil abstrait
`edsh-observation-laboratory-generic` :

- `id` : item "Identifiant" (repéré par texte, pas par linkId — `text = 'Identifiant'`)
- `category = laboratory`
- `code` : item dont le texte contient "code loinc"
- `effective` : item dont le texte contient "Date et heure du prélèvement"
- `value` : la quantité de la réponse elle-même, unité UCUM
- `referenceRange.low` / `.high` : items dont le texte contient "Borne inférieure" /
  "Borne supérieure"

Contrairement aux autres groupes, `CreateLabObservation` navigue **par texte d'item**
plutôt que par `linkId` littéral — ses 4 appelants (fonction rénale, hémogramme, bilan
hépatique, autres) lui passent chacun un item différent, mais la sous-structure de chaque
analyte (Identifiant / code LOINC / date / bornes) est la même dans les 5 groupes du
Questionnaire.

``` fml
group CreateLaboratoryObservations(source src : QuestionnaireResponse, target patient : Patient, target bundle : Bundle) {
  src.item as bioGroup where (linkId = '7702944131447') then {
    bioGroup.item as renalGroup where (linkId = '5241323453538') then {
      renalGroup.item as ureaItem where (linkId = '7169026818760') then {
        ureaItem.answer as ans -> bundle then CreateLabObservation(ans, ureaItem, patient, bundle) "create-urea-obs";
      } "extract-urea";
      // ... creatItem (500408205043), dfgItem (786621340679)
    } "process-renal";
    bioGroup.item as hemoGroup where (linkId = '419282985970') then {
      // leukoItem, hemoItem, hematItem, eryItem, vgmItem, platItem, neutItem, lymphItem, eosiItem, monoItem, tpItem, tcaItem
      // — un CreateLabObservation par analyte, même schéma que ureaItem
    } "process-hemo";
    bioGroup.item as liverGroup where (linkId = '796308115381') then {
      // asatItem, alatItem, ggtItem, palItem, bilTotItem, bilConjItem
    } "process-liver";
    bioGroup.item as glucoseGroup where (linkId = '334039497382') then {
      // glycItem, hba1cItem
    } "process-glucose";
  } "process-biology";
}

// Helper: Create a single Laboratory Observation
group CreateLabObservation(source ans, source parentItem, target patient : Patient, target bundle : Bundle) {
  ans -> bundle.entry as obsEntry then {
    ans -> obsEntry.resource = create('Observation') as obs then {
      ans.item as labIdItem where (text = 'Identifiant') then {
        labIdItem.answer as labIdAns -> obs.id = (%labIdAns.value.ofType(string)) "set-obs-id";
      } "extract-obs-id";
      ans -> obs.id as obsId, obsEntry.fullUrl = append('urn:uuid:', obsId) "set-fullUrl";
      ans -> obs.meta = create('Meta') as meta then {
        ans -> meta.profile = 'https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN/StructureDefinition/edsh-observation-laboratory-generic' "obs-profile";
      } "obs-meta";
      ans -> obs.status = 'final' "obs-status";
      ans -> obs.category = create('CodeableConcept') as cat then {
        ans -> cat.coding = create('Coding') as coding then {
          ans -> coding.system = 'http://terminology.hl7.org/CodeSystem/observation-category' "cat-system";
          ans -> coding.code = 'laboratory' "cat-code";
        } "set-category-coding";
      } "set-category";
      ans -> obs.subject = create('Reference') as ref, patient.id as patId, ref.reference = append('Patient/', patId) "set-subject";
      ans -> obs.value = (%ans.value.ofType(Quantity)) as tgtObsVal,
        tgtObsVal.code = (%ans.value.ofType(Quantity).unit), tgtObsVal.system = 'http://unitsofmeasure.org' "set-value";
      ans.item as loincItem where (text.contains('code loinc')) then {
        loincItem.answer as loincAns -> obs.code as code, code.coding as coding,
          coding.code = (%loincAns.value.ofType(string)) "set-loinc-coding";
      } "extract-loinc";
      ans.item as dateItem where (text.contains('Date et heure du prélèvement')) then {
        dateItem.answer as dateAns -> obs.effective = (%dateAns.value.ofType(dateTime)) "set-effective";
      } "extract-effective";
      ans -> obs.referenceRange as refRange then {
        ans.item as lowItem where (text.contains('Borne inférieure')) then {
          lowItem.answer as lowAns -> refRange.low = (%lowAns.value.ofType(Quantity)) as tgtLow,
            tgtLow.code = (%ans.value.ofType(Quantity).unit), tgtLow.system = 'http://unitsofmeasure.org' "set-low";
        } "extract-low";
        ans.item as highItem where (text.contains('Borne supérieure')) then {
          highItem.answer as highAns -> refRange.high = (%highAns.value.ofType(Quantity)) as tgtHigh,
            tgtHigh.code = (%ans.value.ofType(Quantity).unit), tgtHigh.system = 'http://unitsofmeasure.org' "set-high";
        } "extract-high";
      } "set-ref-range";
    } "create-obs";
  } "obs-entry";
}
```
