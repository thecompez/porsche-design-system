# Browser-to-Qt platform adaptations

| Area | Upstream behavior | Qt limitation | Adaptation | Expected difference |
|---|---|---|---|---|
| Porsche Next | webfont loaded by official package | asset license prevents redistribution | externally injected family; undistorted Arial/system sans-serif for general text; only the locked 16px Button fixture uses the measured Arial Narrow 1.295×/-0.936px calibration | rasterization differs; Button label bounds remain within 1px while headings and body copy avoid arbitrary stretching |
| `leadingNormal` | `calc(6px + 2.125ex)` | QML has no CSS `ex` expression | locked Button calibration resolves it to 24px for the active fallback | line-height token is exact for the fixture; other injected fonts may have different `ex` metrics |
| `radiusFull` | `calc(infinity * 1px)` | no infinite radius token | half of smaller rendered dimension | none for pill/circle geometry |
| frosted blur | CSS backdrop filter token | Qt blur has different sampling/cost | initial Button uses extracted solid alpha color; blur tracked separately | background mixing may differ |
| responsive prop objects | CSS media-query expansion | QML has no built-in breakpoint object syntax | typed responsive value helper using official thresholds | update timing differs, values match |
| focus-visible | browser input-modality selector | Qt exposes focus reason | show for keyboard/backtab/shortcut focus reasons | modality edge cases may differ |
| disabled exposure | `aria-disabled` while retaining focus delegation | Qt 6.11 has no assignable `Accessible.disabled` attached property | retain native focusability, block activation, expose tested `accessibilityDisabled` state and loading description | backend disabled-state announcement is unavailable without a C++ accessibility bridge |
| official SVG icons | asset package loader | redistribution/modification is restricted | consumer-supplied licensed icon provider | built-in asset fidelity unavailable |

No adaptation may introduce a new theme, component variant or visual value.
