# Pre-implementation audit

Audit date: 2026-07-18.

The repository initially contained a generic Qt design system generated from
the earlier specification: 75 local tokens, five Button variants, custom
density/high-contrast/automotive themes, neutral icons, Card/IconButton,
TextField/Switch/Banner, and a dashboard-style gallery. Those values and APIs
were not derived from Porsche Design System and were classified as arbitrary.

The correction removed that visual layer from the build and then deleted the
obsolete sources. The current source module contains only upstream-derived
Button/Spinner work and their shared primitives.

## Verified environment

| Item | Value |
|---|---|
| Host | macOS 26.5.1, arm64 |
| Qt | 6.11.1 macOS arm64 SDK |
| CMake | 4.3.4 |
| Generator | Ninja |
| Compiler | Homebrew Clang 22.1.8 |
| Language | C++26 modules |
| Tests | Qt Test, Qt Quick Test, CTest |

## Upstream and asset result

Latest stable v4 was locked to 4.4.0 at commit
`ff5d3d4dfdab3312dbf299e88457af59f289c264`. The npm archive hash, loader,
package versions, and retrieval time are in
`upstream/porsche-design-system.lock.json`.

The source is Apache-2.0, while Porsche-specific font and icon assets have a
restrictive separate license. The runtime therefore uses injection boundaries
and does not vendor those files.
