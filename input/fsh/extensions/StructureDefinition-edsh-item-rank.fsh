Extension: EdshItemRank
Id: edsh-item-rank
Title: "Rang d'un résumé PMSI dans le séjour"
Description: "Cette extension permet d'ordonnancer les résumés PMSI d'un même séjour (par exemple les RUM d'un RSS) lorsque les autres éléments présents ne permettent pas de le faire. C'est notamment le cas des RUM, dont les dates sont parfois trop imprécises pour permettre ce classement (granularité au jour)."
* ^status = #draft
* ^context[0].type = #element
* ^context[=].expression = "Claim"
* . 0..1
* value[x] only positiveInt

Instance: 31df1ab3-c776-493c-aacc-c4ff015893c7
InstanceOf: Provenance
Title: "first import"
Description: """first import"""
Usage: #definition

* target[0] = Reference(EdshItemRank)
* occurredDateTime = "2025-02-02"
* reason.text = """first import"""
* activity = $v3-DataOperation#CREATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "@ngr"
* recorded = "2025-02-02T21:36:10+01:00"

Instance: 37865e4b-c433-49c2-accc-845a8a585dfd
InstanceOf: Provenance
Title: "Correctif PMSI"
Description: """Contexte d'usage corrigé de Claim.item en Claim : l'extension porte le rang du RUM dans le séjour et s'emploie à la racine du Claim (revue PR #29). Titre et description alignés."""
Usage: #definition

* target[0] = Reference(EdshItemRank)
* occurredDateTime = "2026-10-12"
* reason.text = """Contexte d'usage corrigé de Claim.item en Claim : l'extension porte le rang du RUM dans le séjour et s'emploie à la racine du Claim (revue PR #29). Titre et description alignés."""
* activity = $v3-DataOperation#UPDATE
* agent
  * type = $provenance-participant-type#author
  * who.display = "David Ouagne"
* recorded = "2026-10-12T12:00:00+02:00"
