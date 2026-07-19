# Link API mapping

Locked source: Porsche Design System 4.4.0 `p-link`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| default slot | label | `text` | `string` | Direct | Native label. |
| `variant` | primary/secondary | `variant` | `Link.Variant` | Direct | Exact Button-family colors and geometry. |
| `icon` | icon name | `iconName` | `string` | Renamed | Resolved by `IconProvider`. |
| `icon-source` | URL | `iconSource` | `url` | Renamed | Direct external asset injection. |
| `href` | URL | `href` | `url` | Direct | Opened with `Qt.openUrlExternally`; emitted through `activated` first. |
| `target` | browser target | `target` | `string` | QtAdapted | Retained as metadata; native URL handlers do not support browsing contexts. |
| `download` | string/bool | `download` | `string` | Unsupported | Native external URL dispatch has no HTML download attribute. |
| `rel` | string | `rel` | `string` | QtAdapted | Retained for application policy adapters. |
| `hide-label` | responsive bool | `hideLabel` | `bool` | QtAdapted | Exact base geometry; accessible name remains visible to AT. |
| `compact` | responsive bool | `compact` | `bool` | QtAdapted | Exact base geometry. |
| `aria` | object | `accessibleName`, `accessibleDescription` | strings | QtAdapted | Qt Accessible mapping. |

The locked Link has no disabled or visited visual state.

