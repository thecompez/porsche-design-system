# Heading API mapping

Locked source: Porsche Design System 4.4.0 `p-heading`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| default slot | text content | `text` | `string` | Direct | Native text content. |
| `tag` | `h1`…`h6` | `level` | `int` | QtAdapted | Exposed as `Accessible.Heading` plus accessible level metadata where Qt supports it. |
| `size` | responsive size union | `size` | `Heading.Size` | QtAdapted | Exact locked fluid scale. |
| `weight` | weight union | `weight` | `Heading.Weight` | Direct | Normal, Semibold, Bold. |
| `align` | alignment union | `alignment` | `Heading.Alignment` | Renamed | Direction-aware Start/End. |
| `color` | semantic color union | `semanticColor` | `Heading.Color` | Renamed | Locked semantic-token mapping. |
| `hyphens` | hyphen union | `hyphens` | `Heading.Hyphens` | QtAdapted | Break-word fallback where automatic dictionaries are unavailable. |
| `ellipsis` | `boolean` | `ellipsis` | `bool` | Direct | Single-line end elision. |

When `level` is zero, the exact v4.4.0 size-to-heading-level map is used.

