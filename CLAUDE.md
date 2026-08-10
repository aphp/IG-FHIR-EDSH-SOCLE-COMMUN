# Project: FHIR Implementation Guide — Données socles des EDSH

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

This repo publishes `aphp.fhir.fr.edsh` — the AP-HP guide describing the core ("socle
commun") data variables shared across Entrepôts de Données de Santé Hospitalier (EDSH),
their modelling method, and their target FHIR profiles. It is published to GitHub Pages at
the canonical above and consumed downstream: `IG-fhir-dm` depends on `aphp.fhir.fr.edsh:
dev` — and is *also* the upstream source of the "Data Management with FHIR" methodology
this repo instantiates, and the home of the FHIR→OMOP derivation this repo deliberately
does not cover.

**`README.md` describes what the guide specifies** (the 51-item socle, the three-step
method, the profile families, how to build the IG) — read it first for content. **This
file covers how to work in the repo**: conventions, the skill entry point, and traps found
during development that aren't visible from the published guide.

Before creating or modifying a FHIR profile, extension, ValueSet/CodeSystem, or reviewing
this repo for compliance, load the AP-HP FHIR standards via the `fhir-skills:load-standards`
skill (naming conventions, resource id/name/title/FSH-header templates, the mandatory
Provenance step, build & validation conventions).

**Open question — Core vs. Project IG.** `fhir-skills:load-standards`'s naming-conventions
reference determines IG type from `sushi-config.yaml`: `id: aphp.fhir.fr.core` or a `/core`
canonical → Core; `dependencies` declaring `aphp.fhir.fr.core` → Project; neither signal →
ask the author. Here **neither fires**: `id: aphp.fhir.fr.edsh`, canonical
`https://aphp.github.io/IG-FHIR-EDSH-SOCLE-COMMUN`, and dependencies are
`hl7.fhir.uv.sdc`/`hl7.fhir.fr.core` (the *national ANS* core, not `aphp.fhir.fr.core`)/
`ans.fhir.fr.annuaire`. A same-day compliance scan (`reports/compliance-*.md`, not yet
committed) was run on an assumed answer of "Core" and found the codebase contradicts that
assumption throughout (~90 `Must Support` flags, 43 narrowed `Reference` bounds, ~30
tightened cardinalities across all 56 artifacts) — the report itself flags this as needing
arbitration before any correction pass, not a simple cleanup. **Do not silently strip
`Must Support`/narrow bounds, and do not silently treat them as fine — ask which reading
applies before touching robustness-principle-related constraints.** If the answer turns out
to be Project, declaring `aphp.fhir.fr.core` under `dependencies` would make the type
mechanically determinable going forward.

## Project Description

Standardises a **51-item "socle commun"** proposed by the GT « Standards et
Interopérabilité » (mandated Jan. 2023 by the comité stratégique des données de santé) for
adoption by every French hospital EDS — split into **Lot 1** (patient identity, PMSI,
socio-démographique, médicament, biologie, examen clinique — the priority, currently
modelled set) and **Lot 2** (style de vie: tabac/alcool/drogues/activité physique —
deliberately deferred, unformalised end-to-end; see Known Deviations).

The guide is built around a **three-step MDE pipeline**, each step with published
deliverables you'll find referenced throughout `input/`:

1. **Acquisition** — conceptual model + 40-concept business glossary + 10 annotated
   clinical vignettes (`use-core-variables-acquisition.md`).
2. **Formalisation** — `Questionnaire/UsageCore` (5 groups: socio-démographique, PMSI,
   biologie, exposition médicamenteuse, examen clinique) + 10 `QuestionnaireResponse`
   instances (one per vignette, `input/resources/usages/core/`).
3. **Standardisation** — 52 FHIR profiles, plus a hand-authored StructureMap
   **`Q2FSL`** ("Questionnaire to FHIR Semantic Layer", `input/fml/StructureMap-Q2FSL.fml`)
   that mechanically transforms each `QuestionnaireResponse` into a `Bundle` of
   conformant resources — this is what generates the `casN/` example resources.

Status `draft`, version `0.1.0`, FHIR R4 (4.0.1), jurisdiction FRA, publisher AP-HP. Guide
content (pages, FSH titles/descriptions) is authored in French; this file is in English
per house convention.

## Technologies Used

- Markdown, HTML, Mermaid, PlantUML
- JSON
- FHIRPath, FHIR Mapping Language (FML), FHIR Shorthand (FSH)
- SQL (test fixtures under `input/test/sql/`)

## Project Structure

The directory containing the guide inputs is located in `input`. It includes:

- **`input/data`**: `expansion-params.json` (French SNOMED CT extension config), `features.yml`.
- **`input/fsh`**: FHIR artifacts in FSH — subdivided by kind, unlike a flat single-folder
  layout: `profiles/` (48), `valueset/` (30), `codesystems/` (14), `extensions/` (4),
  `profiles-datatypes/` (4), `examples/` (2), `invariants/`, `usages/`, plus top-level
  `aliases.fsh` and `provenances.fsh`. Provenance coverage is 100% (107 instances for 56
  artifacts) — the repo's one fully-satisfied standard; keep it that way when adding artifacts.
  Two abstract parent hierarchies to derive from rather than re-deriving from base FHIR:
  - `EdshObservationLaboratoryGeneric` (abstract) is the parent of **22 lab analyte
    profiles**. It binds `code` to a 31-code LOINC ValueSet and enforces UCUM on every
    quantity via **9 invariants** in `invariants.fsh` (`dm-lab-1..6` on labs; `dm-0`,
    `dm-1`, `dm-exercice-minutes-per-day`/`-days-per-week` elsewhere). A new lab profile
    that doesn't derive from this parent won't inherit UCUM enforcement and will validate
    incorrectly.
  - `Claim` → `EdshClaimPmsi` → `EdshClaimPmsiMco` → `EdshClaimRum` (all but the last are
    abstract) models a French RUM, with diagnosis slices by type (DP/DR/DA/DAD).
- **`input/fml`**: hand-authored StructureMap mapping — `Q2FSL`
  (`StructureMap-Q2FSL.fml`, 1253 lines), `QuestionnaireResponse` → `Bundle`, 11 groups
  navigating **by literal `linkId`**. Editing `Questionnaire/UsageCore`'s item structure
  without updating the matching `linkId` literals in this FML breaks the map silently — no
  compile-time link between the two. ⚠️ Dropping a `.fml` file here does **not** make it
  part of the build — it must also be listed under `parameters.path-resource` in
  `sushi-config.yaml`, or SUSHI/IG Publisher silently ignore it.
- **`input/images-source`**: `.plantuml` sources, converted to SVG and included via
  `{%include some-diagram.svg%}`.
- **`input/images`**: static images consumed directly. Currently 3 PNGs, all still prefixed
  `DM*` from before the `Edsh*` rename (see Known Deviations).
- **`input/includes`**: `.mermaid` diagram sources and `markdown-link-references.md`.
- **`input/pagecontent`**: Markdown guide pages. Each page must also be listed under `pages:`
  in `sushi-config.yaml` to be compiled into HTML by IG Publisher.
- **`input/resources`**: hand-authored FHIR JSON, all under `usages/core/` (203 files —
  `Questionnaire/UsageCore`, its 10 `QuestionnaireResponse` instances, and a
  `casN/` subfolder per vignette). **The `casN/` resources are `Q2FSL`'s generated
  output, not independently hand-maintained examples** — hand-editing one desynchronises
  it from its `QuestionnaireResponse`/the FML. Regenerate via the build rather than editing
  in place.
- **`input/test`**: `map/` (JSON EHR fixtures, one per test patient) and `sql/`.
- **`input/ignoreWarnings.txt`**.

Other key files:

- `sushi-config.yaml`: menu, dependencies, pages, and `parameters.path-resource` (the list
  of non-`input/fsh` directories SUSHI/IG Publisher also scan for artifacts).
- `ig.ini`: template `https://github.com/aphp/ig-template-aphp`.
- `.github/workflows/deploy-ig.yaml`: builds and deploys to GitHub Pages on push to `main`.

## Important Commands

- `./gradlew buildIG` (`.\gradlew.bat buildIG` on Windows) - Runs SUSHI (transpiles `.fsh`
  files to JSON) then IG Publisher to build the full Implementation Guide. Requires an
  active internet connection; README claims ~30 minutes for a first build, 5-7 minutes
  after. Output is viewable at `output/index.html`.
- `./gradlew sushiBuild` - Runs SUSHI only, useful to quickly validate new/changed `.fsh`
  files without running the full IG Publisher build.
- `./gradlew reBuildIG` - `cleanIG` followed by a full build; slow, only when you have
  reason to distrust the current build state.
- `./gradlew cleanIG` - deletes `fml-generated/`, `fsh-generated/`, `output/`, `temp/`,
  `template/`, **`input-cache/` wholesale**, `.gradle/nodejs`, `node_modules/`,
  `package.json`, `package-lock.json` — a real, sometimes-slow reset, not a free wipe.
  Wiping `input-cache/` significantly increases the next build's time; don't run
  `cleanIG`/`reBuildIG` reflexively.
- ⚠️ **Never run bare `gradle`/`./gradlew` with no task name** — `build.gradle.kts:38` sets
  `defaultTasks("cleanIG", "buildIG")`, the slowest possible path.
- Versions are pinned in `gradle.properties`: Node 22.22.0, SUSHI 3.20.0, IG Publisher
  2.3.1. SUSHI is Gradle-managed via the `node` plugin — never install it globally.
- Local prerequisites: Java 21, Jekyll. Note `deploy-ig.yaml` (CI) pins Java **17** instead
  — a real version inconsistency between local and CI, not yet reconciled.
- The Gradle wrapper (`gradlew`/`gradlew.bat`/`gradle/wrapper/`, Gradle 9.2.0) is present
  and committed — keep it that way; a missing wrapper makes the build non-reproducible.

## Preferred APIs and Libraries

- D3.js, mermaid
- FHIR API

## Known Deviations and Traps

Findings from a same-day compliance scan (`reports/compliance-2026-08-10-15-17.md`) plus
direct verification, kept here so they aren't rediscovered — or propagated — next session:

1. **`input/pagecontent/dm-instruction.md` is not published** — it's missing from `pages:`
   in `sushi-config.yaml`, so IG Publisher never compiles it, and it links to a
   `data-management.html` page that doesn't exist in this IG. It describes a broader
   5-step "processus d'instruction" (superset of the published 3-step method); check with
   the author before deciding whether to publish it, delete it, or leave it as a draft.
2. **Three `path-resource` entries in `sushi-config.yaml` point at directories that don't
   exist**: `input/resources/ViewDefinition_OMOP`, `input/resources/usages/core/View_definition`,
   `input/fml/usages/core`. Harmless to SUSHI (it skips missing paths) but likely leftover
   from a planned OMOP ViewDefinition effort — don't assume content belongs there without checking.
3. **Three intro pages are orphaned** by an old `DM*` → `Edsh*` rename:
   `StructureDefinition-DMObservationBodyHeight-intro.md`, `-BodyWeight-`,
   `-LaboratoryFonctionRenale-`. IG Publisher matches intro pages to artifacts by **id**, so
   **0 of 56 artifacts currently have published intro documentation** — including these
   three, for which text was written. Rename to the `edsh-*` id to reconnect them.
4. **Naming deviations — don't copy these patterns**: `codesystems/CodeSystem-GHM.fsh` and
   `valueset/ValueSet-CIM10.fsh` use non-kebab-case filenames; `Id:
   edsh-observation-laboratoryplaquettes` is missing a hyphen (should be
   `edsh-observation-laboratory-plaquettes`, unlike its 20 sibling lab profiles);
   `profiles-datatypes/StructureDefinition-edsh-address.fsh:3` has `Id : edsh-address` (stray
   space); `examples/Practioner-practioner-example.fsh` has a typo in the filename.
5. **The two FSH examples aren't conformance examples** — `Patient-patient-example.fsh` and
   the mistyped `Practioner-...` instantiate base `Patient`/`Practitioner`, not `EdshPatient`/
   `EdshPractitioner`. 45 of 56 artifacts have no example at all.
6. **Element documentation is thin**: 81 `^short` / 39 `^definition` / 23 `^comment` across
   ~700 constraint rules (~11% coverage). The `FrMedication*` profiles are the
   best-documented in the repo and are the model to follow.
7. **Commit message style is mixed** — recent commits use a parenthesised conventional form
   (`(build):`, `(ci):`, `(fix):`, `(chore):`); older ones are freeform French
   (`Modification_correction`, `Amelioration_structuremap`). Prefer the parenthesised form
   for new commits.
8. **`StructureMap-Q2FSL.fml` references `StructureDefinition/edsh-patient-residence`** —
   no such profile exists anywhere in `input/fsh/`. Either dead code in the map or a
   profile that was never created; don't assume the reference is valid without checking.
9. **`Questionnaire-UsageCore-intro.md` contains only `TODO contexte`** — the intro page
   for the guide's central artifact (the Questionnaire every profile and the FML trace
   back to) is unwritten.
10. **`StructureMap-Q2FSL-intro.md` documents only 1 of 11 FML groups** (`CreatePatient`).
    The other 10 groups (`CreateEncounters`, `CreateConditions`, `CreateLaboratoryObservations`,
    etc.) have no narrative documentation — don't assume the intro page describes the whole map.
11. **`help.md`'s naming conventions are stale and self-contradictory** — it documents a
    convention explicitly **not conformant with ANS's own recommendations** (says so
    in-page), illustrated with the obsolete `DMObservationBodyWeight` id pattern rather
    than the real `edsh-observation-body-weight`. Its closing table (production-process
    QQOQCP characteristics) is also truncated mid-row. Prefer `fhir-skills:load-standards`
    over this page for naming rules.
12. **Date inconsistency**: `index.md` says the GT was launched "janvier 2024";
    `data-dictionary.md` says "janvier 2023", and the GT's own deliverable
    (`DocumentReference/CoreExigences`) is dated 2023-09-15. `index.md` is the one that's
    wrong — fix at source if touching that page.
13. **Lot 2 (style de vie) is unformalised end-to-end, not just "thin"**: all 4
    `Questionnaire/UsageCore` groups are marked "(A définir dans des travaux
    complémentaires)" with no real items; 3 of the 4 glossary entries in
    `use-core-variables-acquisition.md` say "Préciser formellement ce qui est attendu";
    every mention in the 10 standardisation narratives is a literal dead link
    `[…](à faire)`; `Q2FSL` has no group for these 4 profiles; none have examples. Don't
    "complete" one layer (e.g. write an example) without the others — the whole chain
    needs the same complementary work described in the README first.
14. **`input/includes/use-core-conceptual.svg` is orphaned** — referenced by no page (the
    conceptual model is rendered from the mermaid source instead).
15. **`other.md`'s "Glossaire" link points at `help.html` instead of `glossary.html`**, and
    the page omits a link to `changelog.html` even though it's in the menu.

## Specific Rules

### 1. Scoping and Governance

- Clearly define the functional scope (use cases)
- Identify actors and data flows
- Involve stakeholders (vendors, institutions, domain experts)
- Document design decisions and their rationale

### 2. Reuse and Alignment

- Check for existing IGs or international profiles (US Core, IPS, IHE…)
- Check for existing IGs or national profiles (Fr Core, ANS…)
- Align profiles with base HL7 artifacts
- Reuse standard terminologies (SNOMED CT, LOINC, ICD, ATC…)
- Limit creation of extensions and document them clearly

### 3. Technical Quality of Profiles

- Avoid unnecessary over-constraining
- Specify cardinalities and coded values
- **Must Support flags, narrowed `Reference` bounds, tightened cardinalities**: whether
  these are legitimate here depends on the open Core-vs-Project question above — don't
  assume either reading. See `fhir-skills:load-standards`'s naming-conventions reference for
  the underlying robustness principle once the question is settled.
- Ensure consistency with FHIR base model invariants
- Provide **valid and representative** examples for each profile
- Use validation tools (FHIR Validator, SUSHI/IG Publisher…)

### 4. Documentation Clarity

- Organize the guide around business scenarios
- Include sequence diagrams, JSON/XML examples, real-life exchange cases
- Explain the choice of FHIR resources used (and why others are not)
- Document governance and versioning policies

### 5. Interoperability and Mapping

- Define mappings to other data models (CDA, OMOP, openEHR…)
- Mention compatibility with IHE profiles (PAM, PIXm, PDQm, MHD…)
- Document compliance with local/EU regulations (GDPR, eHDSI…)

### 6. Maintenance and Evolution

- Version the guide with a clear changelog
- Define an evolution policy (breaking changes, extensions)
- Host the guide on a sustainable platform (HL7, GitHub Pages)
- Plan automated conformance testing (Touchstone, Inferno, Postman…)

### 7. User Experience

- Provide clear and intuitive navigation (menu, search)
- Offer progressive reading: business scenario → technical constraints → profiles → examples
- Add "Implementation Notes" to help developers understand quickly

## Acronyms

- IG: Implementation Guide
- FHIR: Fast Healthcare Interoperability Resources
- FIG: FHIR Implementation Guide
- HL7: Health Level Seven
- AP-HP: Assistance Publique - Hôpitaux de Paris
- EDS: Entrepôt de Données de Santé
- EDSH: Entrepôt de Données de Santé Hospitalier
- GT: Groupe de Travail
- PMSI: Programme de Médicalisation des Systèmes d'Information
- MCO: Médecine, Chirurgie, Obstétrique
