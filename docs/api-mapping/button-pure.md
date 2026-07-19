# ButtonPure API mapping

Locked source: Porsche Design System 4.4.0 `p-button-pure`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| default slot | label | `text` | `string` | Direct | Native label. |
| `type` | submit/reset/button | `buttonType` | `ButtonPure.ButtonType` | Renamed | Native form adapters consume the metadata. |
| `name`, `value` | strings | `name`, `value` | strings | Direct | Retained for form adapters. |
| `disabled` | boolean | `disabled` | `bool` | Direct | Blocks pointer and keyboard activation. |
| `loading` | boolean | `loading` | `bool` | Direct | Replaces the icon with `Spinner`, announces loading, and blocks activation. |
| `size` | responsive size | `size` | `ButtonPure.Size` | QtAdapted | Exact base/fluid type scale. |
| `color` | semantic union | `semanticColor` | `ButtonPure.Color` | Renamed | Avoids Qt color-name ambiguity. |
| `icon` | icon name | `iconName` | `string` | Renamed | External official asset provider. |
| `icon-source` | URL | `iconSource` | `url` | Renamed | Direct injected source. |
| `underline` | boolean | `underline` | `bool` | Direct | Label text decoration. |
| `active` | boolean | `active` | `bool` | Direct | Frosted selected background. |
| `hide-label` | responsive bool | `hideLabel` | `bool` | QtAdapted | Exact base geometry and accessible retained label. |
| `align-label` | responsive start/end | `alignLabel` | enum | QtAdapted | Exact base value and mirrored layout. |
| `stretch` | responsive bool | `stretch` | `bool` | QtAdapted | Native width-fill behavior. |
| `aria` | object | accessibility properties | Qt attached | QtAdapted | Role, name, description, disabled and focusable state. |
| `form` | string | `formId` | `string` | Renamed | Application-provided native form adapter. |

