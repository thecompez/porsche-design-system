# Testing

Run the full validation:

```sh
cmake --preset dev
cmake --build --preset dev
ctest --preset dev --output-on-failure
```

| CTest | Coverage |
|---|---|
| `unit.token_generator` | parsing, malformed source, aliases, types, deterministic output |
| `unit.core` | Light/Dark/System, exact Button geometry/state values, font injection |
| `qml.components` | official defaults, normal/compact/hide-label geometry, schemes, variant exclusions |
| `qml.interaction` | Tab/Backtab, Enter/Return/Space, pointer, disabled/loading blocking |
| `qml.accessibility` | role, name, loading/disabled state, hidden label |
| `qml.visual` | Light, Dark, hover, active, focus, RTL, disabled, loading, compact |
| `visual.button_fidelity_gate` | web/Qt bounds, structure, colors, pixels, overlays, diffs, HTML/JSON report |
| `runtime.component_lab_smoke` | offscreen component-lab startup |
| `runtime.reference_gallery_smoke` | offscreen reference-gallery startup |
| `validation.token_determinism` | repeated generated-output hashes |
| `validation.installed_consumer` | install, `find_package`, link, run |

The official renderer uses the exact 4.4.0 JS package at 720×520 and DPR 1.
The native renderer uses only `Pds.Native`. The strict Button gate requires
≤1px bounds deviation, ≥0.98 structural geometry similarity, and ≤3 mean RGB
delta. The generated report is
`tests/visual/reports/button-fidelity.html`.
