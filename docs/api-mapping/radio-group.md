# RadioGroup API mapping

Locked source: Porsche Design System 4.4.0 `p-radio-group`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| `label`, `description` | strings | same | strings | Direct | Centralized typography. |
| `compact` | boolean | `compact` | bool | Direct | 18 px radios and compact gaps. |
| `direction` | responsive row/column | `direction` | enum | QtAdapted | Base native layout direction. |
| `name`, `form` | strings | `name`, `formId` | strings | QtAdapted | Form-adapter metadata. |
| `value` | string | `value` | string | Direct | Updates the selected option. |
| default option slot | `p-radio-group-option[]` | `options` | list of `{label,value,disabled,loading}` | QtAdapted | QML model replaces DOM child components while preserving one group contract. |
| `required`, `loading`, `disabled` | booleans | same | bool | Direct | Group-wide state. |
| `state`, `message`, `hide-label` | mixed | same | native | QtAdapted | Exact base visual and accessibility state. |
| change/blur events | Event | `change(string)`, focus | signal/state | QtAdapted | Typed selected value. |

Arrow keys wrap and skip disabled/loading options exactly as the locked group.

