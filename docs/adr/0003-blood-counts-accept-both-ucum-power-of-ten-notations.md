# Blood-count profiles accept both UCUM power-of-ten notations, `10*` and `10^`

UCUM defines two equivalent symbols for powers of ten: `10*`, inherited from HL7's ISO+
extension, and `10^`, added later because it is what most readers expect (UCUM §29). The
7 blood-count profiles (`Eosinophiles`, `Erythrocytes`, `Leucocytes`, `Lymphocytes`,
`Monocytes`, `Neutrophiles`, `Plaquettes`) used to fix `valueQuantity.code` exactly to
`10*3/uL` or `10*6/uL`. In review of #29 we chose the readable `10^` form for the
examples; fixing the code to `10^` instead would have rejected `10*`, which is the more
common form in practice (LOINC example units, other IGs) and is what `Q2FSL` produces for
the 10 cas d'usage. Since this is a Core IG ([ADR-0002](0002-edsh-is-a-core-ig.md)), we
**accept both notations**: the 7 profiles no longer fix `valueQuantity.code`, and two
invariants replace the fixed value — `dm-lab-unit-10e3-ul` (`10*3/uL` or `10^3/uL`, 6
profiles) and `dm-lab-unit-10e6-ul` (`10*6/uL` or `10^6/uL`, `Erythrocytes`). `dm-lab-3`
still requires a `referenceRange`'s bounds to use the same code as the value, so a single
resource never mixes the two notations.

## Considered Options

- **Keep `10*` fixed**: no consumer impact, but rejects valid UCUM and contradicts the
  examples the reviewer asked for.
- **Fix `10^`**: readable, but rejects the more common `10*` form, including the
  guide's own `casN` resources — a narrowing a Core IG should not make.
- **Accept both via an invariant** (chosen): robust for producers; the cost moves to
  consumers (below).

## Consequences

- **Consumers must normalise units before comparing or aggregating.** Two conformant
  resources can carry `10*3/uL` and `10^3/uL` for the same quantity; a string comparison
  on `valueQuantity.code` treats them as different units. This applies to any downstream
  transformation, notably the FHIR→OMOP derivation in `IG-fhir-dm`, which must map both
  codes to the same OMOP unit concept (or canonicalise through a UCUM library). The
  `^comment` on each profile's `valueQuantity.code` states this.
- Today the guide's own data is split by origin: hand-authored FSH examples use `10^`,
  the `Q2FSL`-generated `casN` resources use `10*`. Both validate.
- Other lab profiles are unaffected: their units have a single UCUM form and stay fixed.
- The same reasoning would extend to the SI forms labs often report (`10*9/L` for
  `10*3/uL`, `10*12/L` for `10*6/uL`): numerically identical, but a wider change, tracked
  in #38.
