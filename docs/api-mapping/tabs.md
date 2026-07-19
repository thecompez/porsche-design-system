# Tabs API mapping

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| `activeTabIndex` | `number` | `activeTabIndex` | `int` | Direct | Clamped to the available item range. |
| `aria` | `TabsAriaAttribute` | `accessibleName`, `accessibleDescription` | `string` | QtAdapted | Mapped to Qt Accessibility metadata. |
| `background` | `canvas\|surface\|frosted\|none` | `backgroundStyle` | `Tabs.Background` | Renamed | PascalCase scoped enum. |
| `compact` | `boolean` | `compact` | `bool` | Direct | Exact 36 px compact geometry. |
| `size` | `small\|medium` | `size` | `Tabs.Size` | Direct | PascalCase scoped enum. |
| `p-tabs-item` children | elements | `items` | `var` | QtAdapted | Each map supplies `label`, optional `content`, and optional `component`. |
| `update` | custom event | `update(int)` | signal | Direct | Carries the selected zero-based index. |

The obsolete upstream `weight` property has no visual effect in v4.4.0 and is
not exposed.
