# LinkPure API mapping

Locked source: Porsche Design System 4.4.0 `p-link-pure`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| default slot | label | `text` | `string` | Direct | Native label. |
| `align-label` | start/end | `alignLabel` | `LinkPure.AlignLabel` | Direct | Controls label/icon order and mirrors naturally in RTL. |
| `stretch` | responsive bool | `stretch` | `bool` | QtAdapted | Fills width and distributes label/icon. |
| `size` | responsive size union | `size` | `LinkPure.Size` | QtAdapted | Exact fluid viewport resolver. |
| `color` | semantic union | `semanticColor` | `LinkPure.Color` | Renamed | Exact semantic-token mapping. |
| `icon` | icon name | `iconName` | `string` | Renamed | Defaults to `arrow-right`. |
| `icon-source` | URL | `iconSource` | `url` | Renamed | External licensed-provider injection. |
| `underline` | boolean | `underline` | `bool` | Direct | Label underline. |
| `href` | URL | `href` | `url` | Direct | Native external URL dispatch. |
| `active` | boolean | `active` | `bool` | Direct | Frosted active background. |
| `hide-label` | responsive bool | `hideLabel` | `bool` | QtAdapted | Base value with retained accessible name. |
| `target` | link target | `target` | `string` | QtAdapted | Metadata only in native URL dispatch. |
| `download`, `rel` | strings | `download`, `rel` | strings | QtAdapted | Retained for host application adapters. |
| `aria` | object | accessibility properties | Qt attached | QtAdapted | Role, name, description, focusability. |

The locked component has no disabled or visited style.

