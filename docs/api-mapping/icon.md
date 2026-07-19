# Icon API mapping

Locked source: Porsche Design System 4.4.0 `p-icon`.

| Upstream property | Upstream type | Qt property | Qt type | Mapping | Adaptation |
|---|---|---|---|---|---|
| `name` | `IconName` | `name` | `string` | Direct | Resolved through the externally supplied `IconProvider.manifest`. |
| `source` | `string` | `source` | `url` | Direct | Accepts local, resource, data, and network URLs. |
| `color` | semantic union | `semanticColor` | `Icon.Color` | Renamed | Avoids collision with Qt color properties and resolves through locked tokens. |
| `size` | responsive size union | `size` | `Icon.Size` | QtAdapted | Base value is exact; responsive values use the native viewport resolver. |
| `aria` | object | `accessibleName`, `decorative` | `string`, `bool` | QtAdapted | Mapped to Qt `Accessible` attached properties. |

The official `@porsche-design-system/icons` source package is marked
`private: true`, `license: UNLICENSED`. No SVG path is redistributed. Applications
inject `IconProvider.baseUrl` plus `IconProvider.manifest`, or set `source`
directly. A missing icon remains visually empty and reports `missing`; no Unicode,
emoji, or system-glyph substitute is fabricated.

