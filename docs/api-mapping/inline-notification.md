# InlineNotification API mapping

Locked source: Porsche Design System 4.4.0 `p-inline-notification`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| `heading`, `description` | strings | same | strings | Direct | Centralized notification typography. |
| `heading-tag` | h1…h6 | `headingLevel` | int | QtAdapted | Native heading semantics. |
| `state` | info/success/warning/error | `state` | string | Direct | Exact tokens and live-region role. |
| `dismiss-button` | boolean | `dismissButton` | bool | Direct | Emits `dismiss`. |
| `action-label` | string | `actionLabel` | string | Direct | Displays `ButtonPure`. |
| `action-loading` | boolean | `actionLoading` | bool | Direct | ButtonPure loading state. |
| `action-icon` | IconName | `actionIcon` | string | Direct | External official icon injection. |
| heading/default slots | rich content | `content` | Component | QtAdapted | Optional native content component. |
| `dismiss`, `action` events | void | same | signals | Direct | Typed native signals. |

The notification status icon is reserved at the exact 24 px geometry. Its
unlicensed upstream inline SVG is not redistributed; an official source may be
injected through `IconProvider`.

