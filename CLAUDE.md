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

## Project Description

Standardises a **51-item "socle commun"** proposed by the GT « Standards et
Interopérabilité » (mandated Jan. 2023 by the comité stratégique des données de santé) for
adoption by every French hospital EDS — split into **Lot 1** (patient identity, PMSI,
socio-démographique, médicament, biologie, examen clinique — the priority, currently
modelled set) and **Lot 2** (style de vie: tabac/alcool/drogues/activité physique —
deliberately deferred, unformalised end-to-end across every layer of the pipeline; see
README's "Travaux en cours et limites connues" for current status).

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

Status `draft`, version `0.1.0`, FHIR R4 (4.0.1), jurisdiction FR, publisher AP-HP. Guide
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
- **`input/images`**: static images consumed directly. Currently 3 PNGs, the conceptual
  diagrams for the intro pages of `edsh-observation-{body-height,body-weight,laboratory-fonction-renale}`.
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

Two genuine authoring backlogs remain, both self-contained facts about the current state
of the 56 FHIR artifacts — real work across dozens of files, not something a single pass
fixes, so tracked here rather than as a TODO anyone could silently drop:

1. **Example coverage is thin**: 44 of 56 artifacts have no example at all. (`EdshPatient`
   and `EdshPractitioner` are covered — the former by the 10 `casN` vignettes, the latter
   by `input/fsh/examples/Practitioner-edsh-practitioner-example.fsh`.)
2. **Element documentation is thin**: 81 `^short` / 39 `^definition` / 23 `^comment` across
   ~700 constraint rules (~11% coverage). The `FrMedication*` profiles are the
   best-documented in the repo and are the model to follow.

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
- **This is a Core IG** — the robustness principle applies in full:
  **`Must Support` must not be used**, **`Reference` bounds must be widened, not
  narrowed**, relative to inherited constraints, and **cardinalities must not be
  tightened**. See `fhir-skills:load-standards`'s naming-conventions reference for the
  principle itself. As of this writing, ~90 `Must Support` flags (13 artifacts), 43
  narrowed `Reference` bounds (19 profiles), and ~30 tightened cardinalities remain to be
  corrected across the 56 artifacts — run `fhir-skills:analyze-compliance` for the current
  per-file detail rather than relying on a point-in-time report.
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
