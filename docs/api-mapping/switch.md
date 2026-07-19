# Switch API mapping

Locked source: Porsche Design System 4.4.0 `p-switch`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| default slot | label | `text` | string | Direct | Native label. |
| `align-label` | responsive start/end | `alignLabel` | `Switch.AlignLabel` | QtAdapted | Base value; direction-aware order. |
| `hide-label` | responsive bool | `hideLabel` | bool | QtAdapted | Accessible name retained. |
| `stretch` | responsive bool | `stretch` | bool | QtAdapted | Native width fill and space-between. |
| `checked` | controlled boolean | `checked` | bool | Direct | `update(bool)` requests a controlled-state change. |
| `disabled`, `loading`, `compact` | booleans | same | bool | Direct | Exact interaction and scale rules. |
| update event | `{checked}` | `update(bool)` | signal | QtAdapted | Native typed signal payload. |

