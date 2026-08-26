
### Conventions de nommage

#### Ressources de conformité

Les conventions de nommage détaillées (format de l'`id`, du `name`, du `title`, gabarit
d'en-tête FSH par type de ressource) sont maintenues dans le skill `fhir-skills:load-standards`
plutôt que sur cette page, pour éviter qu'elles divergent d'une IG AP-HP à l'autre. Pour
mémoire, la règle générale appliquée dans ce guide est conforme
[aux conventions préconisées par l'ANS](https://interop.esante.gouv.fr/ig/documentation/bonnes_pratiques_modeler.html#r%C3%A8gles-de-nommage-des-ressources-de-conformit%C3%A9) :

- `id` : kebab-case (ex. `edsh-observation-body-weight`)
- `name` : PascalCase dérivé de l'`id` (ex. `EdshObservationBodyWeight`)
- `url` : `[base]/[ResourceType]/[id]`
- nom de fichier : `[ResourceType]-[id].[extension fsh/json]` (ex.
  `StructureDefinition-edsh-observation-body-weight.fsh`)

Exception documentée : les ressources produites par l'[AP-HP FormBuilder](https://github.com/aphp/formbuilder)
(`Questionnaire`, `QuestionnaireResponse`) suivent leur propre convention, `id` = `name`
en PascalCase — par exemple `Questionnaire/UsageCore`, fichier `Questionnaire-UsageCore.fsh`.

#### Autres ressources (exemples, ou instances)

Id est un UUID. 
On pourra colliger les ressources afférentes à un cas d'usage dans un fichier dont le nom explicitera le cas d'usage.
