Instance: edsh-patient-deceased-example
InstanceOf: EdshPatient
Usage: #example
Description: "Exemple de EdshPatient décédé, portant la source de l'information de décès."

* identifier[INS-NIR].value = "199012912345678"
* name.family = "Martin"
* name.given[0] = "Jeanne"
* gender = #female
* birthDate = "1949-03-12"
* deceasedDateTime = "2024-02-01T04:20:00+01:00"
* deceasedDateTime.extension[DeathSource].valueCode = #sih
