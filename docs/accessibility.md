# Accessibility

The calibrated `Button` maps the official internal HTML button contract to a
native `QtQuick.Templates.Button`.

| Contract | Native implementation | Validation |
|---|---|---|
| button role and accessible label | `Accessible.Button`, `accessibleName` | `qml.accessibility` |
| Tab/Backtab traversal | `activeFocusOnTab` and native focus chain | `qml.interaction` |
| Enter/Return/Space activation | guarded key handlers | `qml.interaction` |
| disabled/loading block activation | `interactive` state and overlay | pointer and keyboard tests |
| loading announcement | accessible `Loading` description | accessibility test |
| focus-visible outline | focus reason, 2px outline, 2px offset | visual focus baseline |
| hidden label remains named | root accessible name retains `text` | accessibility test |

Qt 6.11 does not expose an assignable `Accessible.disabled` attached property.
The QML port therefore keeps the official focusable `aria-disabled` behavior,
blocks activation, and exposes `accessibilityDisabled` for deterministic state
testing. A native accessibility-backend disabled-state announcement requires a
future C++ bridge and remains documented as a platform difference.

No accessibility behavior is claimed yet for unported milestone components.
