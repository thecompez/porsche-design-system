# Tag API mapping

Locked source: Porsche Design System 4.4.0 `p-tag`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| default slot | label/content | `text` | string | QtAdapted | Native string label; applications may wrap Tag with a focusable control. |
| `variant` | ten-value union | `variant` | `Tag.Variant` | Direct | Exact solid and frosted semantic variants. |
| `icon` | IconName/none | `iconName` | string | Renamed | External provider lookup. |
| `icon-source` | URL | `iconSource` | URL | Renamed | Direct external injection. |
| `compact` | boolean | `compact` | bool | Direct | Exact 28 px compact / 32 px normal geometry. |
| slotted anchor/button | interactive content | child control composition | `Item` | QtAdapted | `Tag` remains non-focusable like upstream; callers place an interactive child or wrap composition without turning the tag itself into a button. |

The locked Tag does not support selected or removable states.
