# InputText API mapping

Locked source: Porsche Design System 4.4.0 `p-input-text`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| `label` | string | `label` | string | Direct | Rendered with centralized typography. |
| `description` | string | `description` | string | Direct | Locked xs description style. |
| `compact` | boolean | `compact` | bool | Direct | 36 px instead of 56 px. |
| `name`, `form` | strings | `name`, `formId` | strings | QtAdapted | Metadata for native form adapters. |
| `value` | string/number/null | `value` | string | QtAdapted | `TextInput` is string-valued, matching the upstream native input after coercion. |
| `autocomplete` | string | `autoComplete` | string | Unsupported | Qt has platform input-method hints, not HTML autocomplete vocabulary. |
| `readonly` | boolean | `readOnly` | bool | Direct | Exact frosted read-only presentation. |
| `maxlength` | number | `maximumLength` | int | Renamed | Direct native editor constraint. |
| `minlength` | number | `minimumLength` | int | Renamed | Validation metadata. |
| `placeholder` | string | `placeholder` | string | Direct | Direction-aware native placeholder. |
| `disabled`, `required`, `loading` | booleans | same | bool | Direct | Loading and disabled block editing. |
| `state` | none/success/error | `state` | `InputText.State` | Direct | Exact semantic form-state colors. |
| `message` | string | `message` | string | Direct | State-colored feedback. |
| `hide-label` | responsive bool | `hideLabel` | bool | QtAdapted | Base value; accessible label retained. |
| `counter` | boolean | `counter` | bool | Direct | Live length/max display. |
| `spellcheck` | boolean | `spellCheck` | bool | Unsupported | Qt Quick `TextInput` exposes no portable spelling API. |
| start/end slots | content | `leading`, `trailing` | Component | QtAdapted | Native component injection points. |

