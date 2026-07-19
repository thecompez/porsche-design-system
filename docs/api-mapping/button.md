# Button API mapping

Upstream source: Porsche Design System 4.4.0 `p-button`.

| Official property | Qt property | Mapping |
|---|---|---|
| default slot | `text` | direct textual label |
| `type` | `buttonType` | Submit, Reset, Button; form integration is platform adapted |
| `name` | `name` | retained for form adapter |
| `value` | `value` | retained for form adapter |
| `variant` | `variant` | exact Primary/Secondary enum |
| `disabled` | `disabled` | direct; retains focusability like upstream `aria-disabled` and blocks activation |
| `loading` | `loading` | direct; blocks input and shows Spinner |
| `icon` | `iconName` | typed official identifier |
| `icon-source` | `iconSource` | external licensed provider reference |
| `hide-label` | `hideLabel` | direct base value; responsive helper maps official breakpoints |
| `compact` | `compact` | direct base value; responsive helper maps official breakpoints |
| `aria` | Qt `Accessible` fields | platform-adapted structured accessibility |
| `form` | `formId` | optional native application form adapter |

Unsupported old Qt properties—`Danger`, `Tertiary`, `Ghost`, Small/Medium/Large,
leading/trailing icon selection, full-width mode and Automotive density—are
not part of the v4.4.0 Button fidelity API.

The official source has no Ghost Button variant in locked release 4.4.0.
