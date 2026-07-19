# Modal API mapping

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| `aria` | `ModalAriaAttribute` | `accessibleName`, `accessibleRole` | `string`, `Accessible.Role` | QtAdapted | Applied to the native accessible dialog. |
| `backdrop` | `blur\|shading` | `backdrop` | `Modal.Backdrop` | Direct | Blur uses Qt's frosted backdrop approximation. |
| `background` | `canvas\|surface` | `backgroundStyle` | `Modal.Background` | Renamed | PascalCase scoped enum. |
| `disableBackdropClick` | `boolean` | `disableBackdropClick` | `bool` | Direct | A backdrop press emits nothing when enabled. |
| `dismissButton` | `boolean` | `dismissButton` | `bool` | Direct | Uses the injected official close icon. |
| `fullscreen` | responsive boolean | `fullscreen` | `bool` | QtAdapted | Native viewport boolean; breakpoint binding remains caller-controlled. |
| `open` | `boolean` | `open` | `bool` | Direct | Controlled property. |
| `dismiss` | custom event | `dismiss()` | signal | Direct | The consumer updates `open`. |
| `motionVisibleEnd` | custom event | `motionVisibleEnd()` | signal | Direct | Emitted after native opening motion. |
| `motionHiddenEnd` | custom event | `motionHiddenEnd()` | signal | Direct | Emitted after native closing motion. |
| header slot | element content | `header` | `Component` | QtAdapted | Loaded above the body. |
| default slot | element content | `content` | `Component` | QtAdapted | Loaded in the scrollable body. |
| footer slot | element content | `footer` | `Component` | QtAdapted | Loaded after the body. |

`heading` and `description` are convenience fallbacks used only when explicit
slot components are not supplied.
