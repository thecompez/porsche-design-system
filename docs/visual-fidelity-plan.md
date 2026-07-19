# Visual fidelity plan

## Calibration sequence

Button is the calibration component. No other component receives a fidelity
claim until Button reference and Qt renderers run against the locked 4.4.0
source.

Implemented fixtures cover:

- primary and secondary;
- normal and compact;
- label-only and hidden-label geometry;
- default, hover, active, focus, disabled and loading;
- light and dark;
- LTR and RTL.

## Dual renderer

The official renderer loads the pinned 4.4.0 JS loader:

`porsche-design-system.v4.4.0.6061434ac0cf4528ac11.js`

The Qt renderer loads only the native `Pds.Native` QML module. WebEngine is not
linked into or used by the shipped library.

Both renderers use:

- a fixed 1.0 device-pixel ratio;
- the same logical viewport and fixture content;
- transparent/known backgrounds;
- settled fonts and animations;
- explicit state-driving hooks;
- normalized PNG output.

## Metrics and thresholds

| Metric | Gate |
|---|---:|
| outer bounds deviation | ≤ 1 logical px |
| internal spacing deviation | ≤ 1 logical px |
| radius/border deviation | ≤ 1 logical px |
| icon bounds deviation | ≤ 1 logical px |
| text baseline deviation | ≤ 1 logical px, excluding documented fallback-font delta |
| structural similarity | ≥ 0.98 |

Geometry, non-text color, border, typography and icon regions are scored
separately. The HTML report shows reference, actual, overlay, diff and raw
metrics. Thresholds are not relaxed to obtain a passing result.

The available Button gate passes with 1px maximum bounds deviation, 0px height
deviation, 0.99622 structural geometry similarity, 0.99482 overall pixel
similarity, and 1.321 mean RGB delta. Official icon and icon-only raster
fixtures remain `Unavailable` until a properly licensed icon pack is supplied;
no icon score is fabricated.
