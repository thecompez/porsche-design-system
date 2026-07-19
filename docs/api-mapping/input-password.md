# InputPassword API mapping

Locked source: Porsche Design System 4.4.0 `p-input-password`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| Input base properties | mixed | same as `InputText` | mixed | Direct | Shares the exact input base geometry and form states. |
| `toggle` | boolean | `toggle` | bool | Direct | Adds a pure icon button. |
| masked state | password input | `showPassword` | bool | Derived | False uses `TextInput.Password`; true uses normal echo. |
| toggle pressed state | ARIA pressed | `showPassword` | bool | Derived | Exposed through accessible checked state and label. |
| toggle focus return | imperative | `togglePasswordVisibility()` | function | QtAdapted | Restores focus to the editor after every toggle. |
| `view` / `view-off` icons | official asset | `IconProvider` | injected URL | QtAdapted | Restricted official paths are externally injected. |

