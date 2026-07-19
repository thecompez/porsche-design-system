# Porsche Design System 4.4.0 upstream audit

## Audited source

The audit uses tag `v4.4.0`, commit
`ff5d3d4dfdab3312dbf299e88457af59f289c264`. Repository source is the primary
authority; the v4 documentation and the pinned npm package are secondary
runtime references.

## Relevant upstream packages

| Package/workspace | Responsibility | Port use |
|---|---|---|
| `packages/tokens` | primitive and semantic colors, radii, spacing, type scales, motion, shadows, breakpoints | extraction source |
| `packages/components` | Stencil component contracts, markup, state styles and tests | component source of truth |
| `packages/styles` | public CSS/SCSS/Emotion/Vanilla Extract mappings | CSS variable and typography verification |
| `packages/components/src/stylesheets` | generated component CSS variables | browser reference verification |
| `packages/assets/projects/icons` | official SVG icon assets | metadata audit only; not redistributed |
| `packages/assets/projects/fonts` | Porsche Next web fonts | metadata audit only; not redistributed |
| `packages/components-js` | pinned runtime loader and wrappers | reference-web renderer |
| `packages/component-meta` | public property/component metadata | inventory/API cross-check |

## Token architecture

The v4 source contains:

- light, dark and light-dark semantic color modules;
- primitive HSL palettes with alpha variants;
- semantic canvas, surface, frosted, contrast, primary, focus and notification
  colors;
- static and fluid spacing;
- radii from `2px` through `32px` plus full radius;
- Porsche Next optimized type scales and line height;
- normal, semibold and bold weights;
- four duration tokens and three cubic-bezier tokens;
- three shadows, blur, gradients and six breakpoints.

Qt generation will preserve official names using deterministic Pascal/camel
case conversion. CSS expressions that Qt cannot evaluate are classified as
`Derived` or `PlatformAdapted`, never replaced by stylistic guesses.

## Button source findings

Primary files:

- `packages/components/src/components/button/button.tsx`
- `packages/components/src/components/button/button-styles.ts`
- `packages/components/src/styles/link-button-styles.ts`
- `packages/components/src/utils/link-button/link-button-variant.ts`
- `packages/components/src/components/button/__snapshots__/button-styles.spec.ts.snap`

Verified contract:

- variants are exactly `primary` and `secondary`;
- default type is `submit`;
- `disabled` and `loading` block interaction;
- icon, custom icon source, responsive hide-label and responsive compact APIs
  exist;
- loading replaces visible content with the official spinner while retaining
  accessible loading text;
- focus-visible uses a 2px focus outline with 2px offset;
- default type is Porsche Next normal, 16px type scale, dynamic official line
  height;
- normal geometry resolves to 16px block padding, 28px inline padding, 8px
  gap and 12px radius;
- compact geometry resolves to 6px block padding, 16px inline padding, 4px gap
  and 8px radius;
- disabled opacity is 0.4;
- transitions use `durationSm` (`250ms`) and `easeInOut`;
- there is no distinct upstream `:active` color selector in 4.4.0.

## Themes and responsive behavior

Color tokens resolve through CSS `light-dark()` semantics. The Qt port maps
these to Light, Dark and System only. The prior contrast and density themes
are not upstream v4 features and are removed from the fidelity API.

Official breakpoints are `xs`, `sm`, `md`, `lg`, `xl`, and `2xl`. Responsive
component properties use upstream breakpoint objects; Qt equivalents must use
the same thresholds when responsive values are supplied.

## Accessibility

The Button uses a native internal `button`, delegated focus, `aria-disabled`
for disabled/loading, `aria-busy`/described loading messaging, and native
Enter/Space activation. Qt Quick Templates supply the native control behavior;
the port maps ARIA fields to Qt `Accessible` properties.

## Licensing result

Repository source code is under Apache-2.0. Porsche-specific assets—including
fonts and icons—are governed by the separate Porsche Design System Assets
License Agreement. That agreement restricts use, modification and
redistribution. Therefore this repository does not vendor Porsche Next,
official SVGs, crest, marque, wordmark, photography or other brand assets.

The reference renderer may load the pinned public package during development
validation. Shipped Qt code exposes font and icon injection boundaries. Exact
asset-backed fidelity remains unavailable without a consumer-supplied,
properly licensed pack.
