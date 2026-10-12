Instance: edsh-practitioner-role-example
InstanceOf: EdshPractitionerRole
Usage: #example
Description: "Exemple de EdshPractitionerRole : le rôle de cardiologue du Dr Quenum au sein du GHU."

* active = true
* practitioner = Reference(edsh-practitioner-example)
* organization = Reference(edsh-organization-example)
* code = http://terminology.hl7.org/CodeSystem/practitioner-role#doctor "Doctor"
* specialty = http://snomed.info/sct#394579002 "Cardiology"
* location = Reference(edsh-location-example)
