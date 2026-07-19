# Known visual differences

Button has a passing measured v4.4.0 fidelity score for the available
label-only matrix and state fixtures.

| Component/fixture | Difference | Measurement | Reason | Status |
|---|---|---:|---|---|
| Button typography raster | glyph shapes differ while bounds are calibrated | max component bounds 1px; pixel-mask similarity 0.97148 | restricted Porsche Next asset; Arial Narrow metric adaptation | accepted platform adaptation |
| Button icon fixtures | official SVG not bundled | unavailable; no icon score claimed | restricted asset; licensed provider required | open |
| Button frosted secondary | no native backdrop filter in initial Qt primitive | overall mean RGB delta 1.321 on flat fixture | browser/Qt rendering-model difference | accepted for flat calibration background only |
| Qt disabled accessibility announcement | QML has no writable `Accessible.disabled` | behavioral tests pass; backend state unmeasured | Qt 6.11 attached-property limitation | open |
