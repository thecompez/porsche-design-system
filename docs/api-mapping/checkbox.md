# Checkbox API mapping

Locked source: Porsche Design System 4.4.0 `p-checkbox`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| `name`, `value`, `form` | strings | `name`, `value`, `formId` | strings | QtAdapted | Form-adapter metadata. |
| `required`, `disabled`, `indeterminate`, `checked` | booleans | same | bool | Direct | Checked is internally mutable like upstream. |
| `label` | string | `text` | string | Renamed | Matches native button label convention. |
| `state` | none/success/error | `state` | `Checkbox.State` | Direct | Exact semantic state mapping. |
| `message` | string | `message` | string | Direct | State feedback text. |
| `hide-label`, `loading`, `compact` | booleans | same | bool | QtAdapted | Responsive base values and exact geometry. |
| `change`, `blur` events | Event | `toggled(bool)`, focus | signal/state | QtAdapted | Typed native signal. |

Check and indeterminate marks are native vector geometry; no character glyph is used.

