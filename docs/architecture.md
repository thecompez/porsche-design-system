# Architecture

## Dependency direction

```text
locked v4.4.0 package/repository
  -> upstream token extractor
  -> normalized token source + component specifications
  -> deterministic QML/C++/Markdown generator
  -> pds.native.core + Pds.Native runtime
  -> source-derived QML primitives and controls
  -> component lab/reference gallery
  -> official-web versus native-Qt fidelity gate
```

The official component code is the visual source of truth. The Qt library does
not contain WebEngine or use browser rendering at runtime.

## Targets and modules

| Target/module | Responsibility |
|---|---|
| `PdsTokenGeneratorLib` / `pds.native.token.generator` | validate and emit normalized tokens |
| `PdsTokenGenerator` | deterministic build-time CLI |
| `pds.native.tokens` | generated typed token representation |
| `PdsNative::Core` / `pds.native.core` | scheme, Button geometry, font injection |
| `PdsNative::Controls` / `Pds.Native` | installable native QML module |
| `PdsComponentLab` | neutral calibration application |
| `PdsPorscheReferenceGallery` | reference presentation application |
| `button_visual_compare` | geometry/color/pixel report and release gate |

Production C++ declarations use `.cppm`; matching implementation is in `.cpp`.
Namespaces mirror lowercase module identities. Qt application and test entry
points remain conventional `.cpp` interoperability boundaries.

## QML naming

The module provides identity, so filenames and public types are concise:

```qml
import Pds.Native

Button { }
Theme.mode = Theme.Dark
```

`PdsButton.qml` and similarly prefixed type filenames are not used.

## Runtime state and values

`Theme` owns only Light, Dark, and System state. Generated `Tokens` resolves the
official light/dark records. `Typography` and `Motion` expose Button mappings
from the locked tokens. No high-contrast theme, density system, automotive
profile, unsupported variant, or generic component styling remains.

Shared `FocusRing` and `InteractiveArea` primitives centralize the official
Button focus and interaction behavior. `Spinner` is a native scene-graph
rendering of the official 32×32, radius-11, 1.5-stroke definition.
