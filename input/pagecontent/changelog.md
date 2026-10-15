### <a id="next">Version en cours (non publiée)</a>

<details open>
  <summary>Cliquez ici pour voir les évolutions en cours</summary>
<ul>
    <li>Remédiation robustesse (IG Core, <a href="https://github.com/aphp/IG-FHIR-EDSH-SOCLE-COMMUN/issues/19">#19</a>), profils du Lot 1 :
    <ul>
        <li>retrait de tous les <code>Must Support</code> (9 profils) ;</li>
        <li>élargissement des bornes <code>Reference</code> : chaque règle liste les cibles autorisées par le parent, puis le profil FR Core correspondant s'il existe, puis le profil EDSH. Des règles de ce type sont ajoutées sur les références vers <code>Patient</code> et <code>Encounter</code> qui n'en avaient pas. Aucune cible n'est retirée ;</li>
        <li>retour à la cardinalité de base pour <code>EdshObservationLaboratoryUremie.referenceRange</code>, <code>EdshMedicationAdministration.dosage</code> et <code>EdshMedicationRequest.dosageInstruction</code>.</li>
    </ul>
    </li>
    <li>Documentation des éléments des profils du Lot 1 : <code>^short</code> sur chaque élément contraint, <code>^definition</code> sur les règles métier non évidentes (diagnostics du RUM notamment), <code>^comment</code> justifiant les cardinalités resserrées conservées (invariants structurels PMSI, discriminants de tranche, famille <code>Fr*</code>). Une rencontre (<code>Encounter</code>) y est désignée par « venue », comme dans FR Core, et les unités y sont écrites sous forme lisible (UI/L, µmol/L, 10^3/µL), le code UCUM restant imposé par les invariants.</li>
    <li><code>EdshMedicationAdministration</code> : titre « Administration de médicaments » (au lieu de « Prise de médicaments »).</li>
    <li>Glossaire : ajout du terme « tranche » (traduction de <i>slice</i>).</li>
</ul>
</details>

### <a id="0.1.">Version 0.1.0</a>

<details>
  <summary>Cliquez ici pour voir les évolutions liées à la version 0.1.0</summary>
<ul>
    <li>initialisation du guide</li>
</ul>
</details>

{% include markdown-link-references.md %}