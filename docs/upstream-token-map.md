# Upstream token map

Every row records an official v4 name and the deterministic Qt representation.
The full generated reference is produced from the pinned extraction pipeline.

| Upstream token/CSS variable | Qt token | Classification | Source |
|---|---|---|---|
| `--p-color-primary` | `Tokens.colorPrimary` | Extracted | `tokens/src/color/light-dark/foreground/colorPrimary.ts` |
| `--p-color-canvas` | `Tokens.colorCanvas` | Extracted | `tokens/src/color/light-dark/background/colorCanvas.ts` |
| `--p-color-surface` | `Tokens.colorSurface` | Extracted | `tokens/src/color/light-dark/background/colorSurface.ts` |
| `--p-color-frosted` | `Tokens.colorFrosted` | Extracted | `tokens/src/color/light-dark/background/colorFrosted.ts` |
| `--p-color-frosted-strong` | `Tokens.colorFrostedStrong` | Extracted | matching light-dark token |
| `--p-color-contrast-high` | `Tokens.colorContrastHigh` | Extracted | matching light-dark token |
| `--p-color-focus` | `Tokens.colorFocus` | Extracted | matching light-dark token |
| `--p-radius-lg` | `Tokens.radiusLg` | Extracted (`8px`) | `tokens/src/border/radius/radiusLg.ts` |
| `--p-radius-xl` | `Tokens.radiusXl` | Extracted (`12px`) | `tokens/src/border/radius/radiusXl.ts` |
| `--p-radius-full` | `Tokens.radiusFull` | PlatformAdapted | CSS infinity radius → half of the smaller Qt dimension |
| `--p-typescale-sm` | `Tokens.typescaleSm` | Extracted (`16px`) | `tokens/src/font/size/typescaleSm.ts` |
| `--p-leading-normal` | `Tokens.leadingNormal` | PlatformAdapted | CSS `calc(6px + 2.125ex)` resolved with the active Qt font |
| `--p-font-weight-normal` | `Tokens.fontWeightNormal` | Extracted | `tokens/src/font/weight/fontWeightNormal.ts` |
| `--p-duration-sm` | `Tokens.durationSm` | Extracted (`250ms`) | `tokens/src/motion/duration/durationSm.ts` |
| `--p-ease-in-out` | `Tokens.easeInOut` | Extracted | `tokens/src/motion/ease/easeInOut.ts` |

## Naming transformation

1. Remove the `--p-` prefix.
2. Split CSS kebab-case segments.
3. Produce lower camel case for QML.
4. Preserve upstream semantic suffixes such as `Light`, `Dark`, `Frosted`,
   `2Xl` and `Sm`.
5. Emit the same identifier set to QML, C++ and Markdown.

No compatibility alias is created for invented names such as
`colorActionPrimary`, `radiusControlMedium`, or `sizeControlLarge`.
