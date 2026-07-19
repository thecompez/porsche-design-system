# Component guidelines

Only types backed by the locked upstream release may enter `Pds.Native`.
Filenames exactly match public type names (`Button.qml`, not `PdsButton.qml`).

The current `Button` variants are exactly `Primary` and `Secondary`. Normal and
compact geometry, loading, disabled, hide-label, focus, hover, icon-source, RTL,
and scheme behavior map to `p-button` 4.4.0. Do not add Ghost, Tertiary, Danger,
Small/Medium/Large, automotive density, or a generic Card API.

```qml
import Pds.Native

Button {
    text: qsTr("Continue")
    variant: Button.Secondary
    compact: true
}
```

For licensed assets:

- set `Theme.fontFamily` to a consumer-supplied Porsche Next family;
- set `Button.iconSource` to a consumer-controlled, licensed SVG URL;
- keep `accessibleName` meaningful when `hideLabel` is true.

New controls must follow the same sequence: source audit, API map,
machine-readable geometry spec, native implementation, state tests, official
web baseline, Qt baseline, strict diff gate, then gallery exposure.
