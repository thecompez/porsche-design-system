# Select API mapping

Locked source: Porsche Design System 4.4.0 `p-select`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| `label`, `description`, `name` | strings | same | strings | Direct | Native text and form metadata. |
| `value` | string/number/null | `value` | var | Direct | Strict model-value matching. |
| option slot | `p-select-option[]` | `options` | list of `{text,value,disabled}` | QtAdapted | QML model replaces DOM children. |
| `state`, `message`, `hide-label` | mixed | same | native | QtAdapted | Exact base semantic state. |
| `disabled`, `required`, `compact` | booleans | same | bool | Direct | Exact locked geometry. |
| `dropdown-direction` | auto/up/down | `dropdownDirection` | enum | Direct | Auto clamps to available viewport space. |
| `filter` | boolean | `filter` | bool | Direct | Native filter editor in popup. |
| `form` | string | `formId` | string | Renamed | Native form-adapter metadata. |
| open state | internal | `isOpen` | readonly bool | Derived | Observable for diagnostics and testing. |
| change event | `{name,value}` | `change(var)` | signal | QtAdapted | Typed value; `name` remains a property. |
| toggle event | `{open}` | `toggle(bool)` | signal | QtAdapted | Native typed signal. |

The popup is custom Porsche composition, not a styled default `ComboBox`.
It supports selection, highlighting, filtering, Escape, Enter/Space,
arrows, Home/End, focus restoration, RTL alignment, and viewport clamping.

