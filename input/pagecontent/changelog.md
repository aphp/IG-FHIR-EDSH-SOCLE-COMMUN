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
    <li>Correctifs PMSI :
    <ul>
        <li><code>EdshClaimRum</code> : les URL de CodeSystem fixées sur <code>modifier[MDE]</code> et <code>modifier[MDS]</code> étaient erronées et contredisaient le binding <code>required</code> ;</li>
        <li><code>EdshItemRank</code> : le contexte d'usage passe de <code>Claim.item</code> à <code>Claim</code> (rang du RUM dans le séjour).</li>
    </ul>
    </li>
    <li>Exemples : 18 exemples écrits à la main pour les profils du Lot 1 qu'aucun cas d'usage ne couvrait (11 analytes de biologie, un RUM complet, Organization, Location, EpisodeOfCare, PractitionerRole, un patient décédé portant l'extension <code>EdshDeathSource</code>). Ils se rattachent à un patient fictif dédié, et non à un cas d'usage, pour ne pas ajouter aux cas d'usage des informations qu'ils ne contiennent pas.</li>
    <li>Types de données : un exemple <code>EdshMedicationRequest</code> (paracétamol IV) porte <code>FrRangeUcum</code>, <code>FrRatioUcum</code> et <code>FrSimpleQuantityUcum</code>, qu'aucun exemple n'utilisait jusque-là pour les intervalles et les rapports. Les pages de <code>EdshAddress</code>, <code>FrSimpleQuantityUcum</code>, <code>FrRangeUcum</code> et <code>FrRatioUcum</code> indiquent les exemples qui les portent.</li>
    <li>Biologie : <code>valueQuantity.unit</code> n'est plus fixé dans les 21 profils d'analytes. L'unité reste imposée par le code UCUM ; le libellé d'affichage peut prendre une forme lisible (10^3/µL, µmol/L…).</li>
    <li>Biologie, numération sanguine : <code>valueQuantity.code</code> n'est plus fixé dans 7 profils (<code>Eosinophiles</code>, <code>Erythrocytes</code>, <code>Leucocytes</code>, <code>Lymphocytes</code>, <code>Monocytes</code>, <code>Neutrophiles</code>, <code>Plaquettes</code>). Deux nouveaux invariants, <code>dm-lab-unit-10e3-ul</code> et <code>dm-lab-unit-10e6-ul</code>, acceptent les deux notations UCUM équivalentes (<code>10*3/uL</code> ou <code>10^3/uL</code>, <code>10*6/uL</code> ou <code>10^6/uL</code>).</li>
    <li><code>StructureMap/Q2FSL</code> : les chemins <code>ans.valueString</code> et <code>irisExt.valueString</code> deviennent <code>ans.value</code> et <code>irisExt.value</code> (élément à choix nommé sans son suffixe de type), refusés par la vérification des chemins d'IG Publisher 3.0. Les ressources produites sont inchangées.</li>
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