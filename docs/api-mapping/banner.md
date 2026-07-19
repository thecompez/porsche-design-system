# Banner API mapping

Locked source: Porsche Design System 4.4.0 `p-banner`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| `open` | boolean | `open` | bool | Direct | Drives a native top-layer popup. |
| `heading` | string | `heading` | string | Direct | Semibold notification heading. |
| `heading-tag` | h1…h6 | `headingLevel` | int | QtAdapted | Native accessibility heading level metadata. |
| description/default slot | content | `description` | string | QtAdapted | Native rich content can be supplied through `content`. |
| `position` | responsive top/bottom | `position` | `Banner.Position` | QtAdapted | Base value plus viewport-safe top-layer placement. |
| `state` | info/success/warning/error | `state` | string | Direct | Uses the exact upstream names and colors. |
| `dismiss-button` | boolean | `dismissButton` | bool | Direct | Close control and Escape behavior. |
| `dismiss` event | void | `dismiss()` | signal | Direct | Controlled `open` remains consumer-owned. |

