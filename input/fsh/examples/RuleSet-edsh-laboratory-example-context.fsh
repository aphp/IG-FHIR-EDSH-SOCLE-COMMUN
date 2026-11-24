// Contexte commun aux exemples de biologie écrits à la main : résultat final
// pour le patient fictif, rendu par l'organisation exemple, même prélèvement.
RuleSet: EdshLaboratoryExampleContext
* status = #final
* subject = Reference(edsh-patient-example)
* performer = Reference(edsh-organization-example)
* effectiveDateTime = "2024-01-10T08:30:00+01:00"
