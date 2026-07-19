# Divider API mapping

Locked source: Porsche Design System 4.4.0 `p-divider`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| `color` | contrast color union | `semanticColor` | `Divider.Color` | Renamed | Exact contrast token mapping. |
| `direction` | responsive direction | `direction` | `Divider.Direction` | QtAdapted | Base value direct; responsive changes bind to native viewport logic. |

The separator is exactly one logical pixel. Horizontal fills available width;
vertical fills available height. It is direction-neutral and exposes the Qt
separator accessibility role.

