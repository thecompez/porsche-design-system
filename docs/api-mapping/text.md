# Text API mapping

Locked source: Porsche Design System 4.4.0 `p-text`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| default slot | text content | `text` | `string` | Direct | Native text content. |
| `tag` | semantic tag union | `semanticRole` | `Text.SemanticRole` | QtAdapted | Qt has no DOM tag; role retains the authoring intent. |
| `size` | responsive size union | `size` | `Text.Size` | QtAdapted | Exact v4.4.0 type scale; fluid clamp is evaluated at viewport width. |
| `weight` | weight union | `weight` | `Text.Weight` | Direct | Normal, Semibold, Bold. |
| `align` | alignment union | `alignment` | `Text.Alignment` | Renamed | Start and End are mirrored by layout direction. |
| `color` | semantic color union | `semanticColor` | `Text.Color` | Renamed | Prevents collision with `QtQuick.Text.color`. |
| `hyphens` | hyphen union | `hyphens` | `Text.Hyphens` | QtAdapted | Qt has no cross-platform automatic hyphen dictionary; break-word wrapping is used for Auto/Manual. |
| `ellipsis` | `boolean` | `ellipsis` | `bool` | Direct | Single-line right elision. |

Deprecated v4 aliases are accepted by migration helpers, while the native enum
surface exposes only the current names.

