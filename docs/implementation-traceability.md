# Implementation traceability

Generated from `spec/component-status.json`. A row is complete only when its
named evidence exists and its validation has passed.

| ID | Requirement | Target | Status | Validation | Evidence |
|---|---|---|---|---|---|
| UPSTREAM-001 | Preserve the v4.4.0 lock at commit ff5d3d4… | upstream lock | Complete | lock/hash audit | upstream/porsche-design-system.lock.json |
| TOKEN-001 | Preserve deterministic extraction and generation | tokens/tools | Complete | unit + determinism CTests | 158 classified upstream exports |
| REGRESSION-001 | Preserve Button geometry ≥0.99622 and pixels ≥0.99482 | Button visual gate | Complete | cumulative visual CTest | button-fidelity.json |
| BUTTON-API-001 | Button: Public API mapping | Button | Complete | component-specific validation | docs/api-mapping/button.md |
| BUTTON-TOKENS-001 | Button: Token mapping | Button | Complete | component-specific validation | spec/components/button.json |
| BUTTON-GEOMETRY-001 | Button: Geometry specification | Button | Complete | component-specific validation | spec/components/button.json |
| BUTTON-STATES-001 | Button: Supported states | Button | Complete | component-specific validation | spec/components/button.json |
| BUTTON-A11Y-001 | Button: Accessibility | Button | Complete | component-specific validation | tests/accessibility |
| BUTTON-KEYBOARD-001 | Button: Keyboard behavior | Button | Complete | component-specific validation | tests/interaction |
| BUTTON-RTL-001 | Button: RTL behavior | Button | Complete | component-specific validation | tests/visual |
| BUTTON-LIGHT-001 | Button: Light theme | Button | Complete | component-specific validation | tests/visual/reference-web |
| BUTTON-DARK-001 | Button: Dark theme | Button | Complete | component-specific validation | tests/visual/reference-web |
| BUTTON-REFERENCE-001 | Button: Official web reference | Button | Complete | component-specific validation | tests/visual/reference-web |
| BUTTON-DIFF-001 | Button: Native screenshot and visual diff | Button | Complete | component-specific validation | tests/visual/reports/button-fidelity.html |
| BUTTON-GALLERY-001 | Button: Gallery integration | Button | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| BUTTON-DOCS-001 | Button: Documentation | Button | Complete | component-specific validation | docs/api-mapping/button.md |
| BUTTON-TESTS-001 | Button: Automated tests | Button | Complete | component-specific validation | CTest |
| SPINNER-API-001 | Spinner: Public API mapping | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-TOKENS-001 | Spinner: Token mapping | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-GEOMETRY-001 | Spinner: Geometry specification | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-STATES-001 | Spinner: Supported states | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-A11Y-001 | Spinner: Accessibility | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-KEYBOARD-001 | Spinner: Keyboard behavior | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-RTL-001 | Spinner: RTL behavior | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-LIGHT-001 | Spinner: Light theme | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-DARK-001 | Spinner: Dark theme | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-REFERENCE-001 | Spinner: Official web reference | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-DIFF-001 | Spinner: Native screenshot and visual diff | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-GALLERY-001 | Spinner: Gallery integration | Spinner | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| SPINNER-DOCS-001 | Spinner: Documentation | Spinner | In progress | component-specific validation | Evidence required before completion |
| SPINNER-TESTS-001 | Spinner: Automated tests | Spinner | In progress | component-specific validation | Evidence required before completion |
| ICON-API-001 | Icon: Public API mapping | Icon | Complete | component-specific validation | docs/api-mapping/icon.md |
| ICON-TOKENS-001 | Icon: Token mapping | Icon | Complete | component-specific validation | spec/components/icon.json |
| ICON-GEOMETRY-001 | Icon: Geometry specification | Icon | Complete | component-specific validation | spec/components/icon.json |
| ICON-STATES-001 | Icon: Supported states | Icon | Complete | component-specific validation | spec/components/icon.json |
| ICON-A11Y-001 | Icon: Accessibility | Icon | Complete | component-specific validation | tests/accessibility |
| ICON-KEYBOARD-001 | Icon: Keyboard behavior | Icon | In progress | component-specific validation | Evidence required before completion |
| ICON-RTL-001 | Icon: RTL behavior | Icon | In progress | component-specific validation | Evidence required before completion |
| ICON-LIGHT-001 | Icon: Light theme | Icon | In progress | component-specific validation | Evidence required before completion |
| ICON-DARK-001 | Icon: Dark theme | Icon | In progress | component-specific validation | Evidence required before completion |
| ICON-REFERENCE-001 | Icon: Official web reference | Icon | In progress | component-specific validation | Evidence required before completion |
| ICON-DIFF-001 | Icon: Native screenshot and visual diff | Icon | In progress | component-specific validation | Evidence required before completion |
| ICON-GALLERY-001 | Icon: Gallery integration | Icon | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| ICON-DOCS-001 | Icon: Documentation | Icon | Complete | component-specific validation | docs/api-mapping/icon.md |
| ICON-TESTS-001 | Icon: Automated tests | Icon | Complete | component-specific validation | CTest |
| TEXT-API-001 | Text: Public API mapping | Text | Complete | component-specific validation | docs/api-mapping/text.md |
| TEXT-TOKENS-001 | Text: Token mapping | Text | Complete | component-specific validation | spec/components/text.json |
| TEXT-GEOMETRY-001 | Text: Geometry specification | Text | Complete | component-specific validation | spec/components/text.json |
| TEXT-STATES-001 | Text: Supported states | Text | Complete | component-specific validation | spec/components/text.json |
| TEXT-A11Y-001 | Text: Accessibility | Text | Complete | component-specific validation | tests/accessibility |
| TEXT-KEYBOARD-001 | Text: Keyboard behavior | Text | In progress | component-specific validation | Evidence required before completion |
| TEXT-RTL-001 | Text: RTL behavior | Text | In progress | component-specific validation | Evidence required before completion |
| TEXT-LIGHT-001 | Text: Light theme | Text | In progress | component-specific validation | Evidence required before completion |
| TEXT-DARK-001 | Text: Dark theme | Text | In progress | component-specific validation | Evidence required before completion |
| TEXT-REFERENCE-001 | Text: Official web reference | Text | In progress | component-specific validation | Evidence required before completion |
| TEXT-DIFF-001 | Text: Native screenshot and visual diff | Text | In progress | component-specific validation | Evidence required before completion |
| TEXT-GALLERY-001 | Text: Gallery integration | Text | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| TEXT-DOCS-001 | Text: Documentation | Text | Complete | component-specific validation | docs/api-mapping/text.md |
| TEXT-TESTS-001 | Text: Automated tests | Text | Complete | component-specific validation | CTest |
| HEADING-API-001 | Heading: Public API mapping | Heading | Complete | component-specific validation | docs/api-mapping/heading.md |
| HEADING-TOKENS-001 | Heading: Token mapping | Heading | Complete | component-specific validation | spec/components/heading.json |
| HEADING-GEOMETRY-001 | Heading: Geometry specification | Heading | Complete | component-specific validation | spec/components/heading.json |
| HEADING-STATES-001 | Heading: Supported states | Heading | Complete | component-specific validation | spec/components/heading.json |
| HEADING-A11Y-001 | Heading: Accessibility | Heading | Complete | component-specific validation | tests/accessibility |
| HEADING-KEYBOARD-001 | Heading: Keyboard behavior | Heading | In progress | component-specific validation | Evidence required before completion |
| HEADING-RTL-001 | Heading: RTL behavior | Heading | In progress | component-specific validation | Evidence required before completion |
| HEADING-LIGHT-001 | Heading: Light theme | Heading | In progress | component-specific validation | Evidence required before completion |
| HEADING-DARK-001 | Heading: Dark theme | Heading | In progress | component-specific validation | Evidence required before completion |
| HEADING-REFERENCE-001 | Heading: Official web reference | Heading | In progress | component-specific validation | Evidence required before completion |
| HEADING-DIFF-001 | Heading: Native screenshot and visual diff | Heading | In progress | component-specific validation | Evidence required before completion |
| HEADING-GALLERY-001 | Heading: Gallery integration | Heading | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| HEADING-DOCS-001 | Heading: Documentation | Heading | Complete | component-specific validation | docs/api-mapping/heading.md |
| HEADING-TESTS-001 | Heading: Automated tests | Heading | Complete | component-specific validation | CTest |
| DIVIDER-API-001 | Divider: Public API mapping | Divider | Complete | component-specific validation | docs/api-mapping/divider.md |
| DIVIDER-TOKENS-001 | Divider: Token mapping | Divider | Complete | component-specific validation | spec/components/divider.json |
| DIVIDER-GEOMETRY-001 | Divider: Geometry specification | Divider | Complete | component-specific validation | spec/components/divider.json |
| DIVIDER-STATES-001 | Divider: Supported states | Divider | Complete | component-specific validation | spec/components/divider.json |
| DIVIDER-A11Y-001 | Divider: Accessibility | Divider | Complete | component-specific validation | tests/accessibility |
| DIVIDER-KEYBOARD-001 | Divider: Keyboard behavior | Divider | In progress | component-specific validation | Evidence required before completion |
| DIVIDER-RTL-001 | Divider: RTL behavior | Divider | In progress | component-specific validation | Evidence required before completion |
| DIVIDER-LIGHT-001 | Divider: Light theme | Divider | In progress | component-specific validation | Evidence required before completion |
| DIVIDER-DARK-001 | Divider: Dark theme | Divider | In progress | component-specific validation | Evidence required before completion |
| DIVIDER-REFERENCE-001 | Divider: Official web reference | Divider | In progress | component-specific validation | Evidence required before completion |
| DIVIDER-DIFF-001 | Divider: Native screenshot and visual diff | Divider | In progress | component-specific validation | Evidence required before completion |
| DIVIDER-GALLERY-001 | Divider: Gallery integration | Divider | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| DIVIDER-DOCS-001 | Divider: Documentation | Divider | Complete | component-specific validation | docs/api-mapping/divider.md |
| DIVIDER-TESTS-001 | Divider: Automated tests | Divider | Complete | component-specific validation | CTest |
| LINK-API-001 | Link: Public API mapping | Link | Complete | component-specific validation | docs/api-mapping/link.md |
| LINK-TOKENS-001 | Link: Token mapping | Link | Complete | component-specific validation | spec/components/link.json |
| LINK-GEOMETRY-001 | Link: Geometry specification | Link | Complete | component-specific validation | spec/components/link.json |
| LINK-STATES-001 | Link: Supported states | Link | Complete | component-specific validation | spec/components/link.json |
| LINK-A11Y-001 | Link: Accessibility | Link | Complete | component-specific validation | tests/accessibility |
| LINK-KEYBOARD-001 | Link: Keyboard behavior | Link | Complete | component-specific validation | tests/interaction |
| LINK-RTL-001 | Link: RTL behavior | Link | In progress | component-specific validation | Evidence required before completion |
| LINK-LIGHT-001 | Link: Light theme | Link | In progress | component-specific validation | Evidence required before completion |
| LINK-DARK-001 | Link: Dark theme | Link | In progress | component-specific validation | Evidence required before completion |
| LINK-REFERENCE-001 | Link: Official web reference | Link | In progress | component-specific validation | Evidence required before completion |
| LINK-DIFF-001 | Link: Native screenshot and visual diff | Link | In progress | component-specific validation | Evidence required before completion |
| LINK-GALLERY-001 | Link: Gallery integration | Link | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| LINK-DOCS-001 | Link: Documentation | Link | Complete | component-specific validation | docs/api-mapping/link.md |
| LINK-TESTS-001 | Link: Automated tests | Link | Complete | component-specific validation | CTest |
| LINKPURE-API-001 | LinkPure: Public API mapping | LinkPure | Complete | component-specific validation | docs/api-mapping/link-pure.md |
| LINKPURE-TOKENS-001 | LinkPure: Token mapping | LinkPure | Complete | component-specific validation | spec/components/link-pure.json |
| LINKPURE-GEOMETRY-001 | LinkPure: Geometry specification | LinkPure | Complete | component-specific validation | spec/components/link-pure.json |
| LINKPURE-STATES-001 | LinkPure: Supported states | LinkPure | Complete | component-specific validation | spec/components/link-pure.json |
| LINKPURE-A11Y-001 | LinkPure: Accessibility | LinkPure | Complete | component-specific validation | tests/accessibility |
| LINKPURE-KEYBOARD-001 | LinkPure: Keyboard behavior | LinkPure | Complete | component-specific validation | tests/interaction |
| LINKPURE-RTL-001 | LinkPure: RTL behavior | LinkPure | In progress | component-specific validation | Evidence required before completion |
| LINKPURE-LIGHT-001 | LinkPure: Light theme | LinkPure | In progress | component-specific validation | Evidence required before completion |
| LINKPURE-DARK-001 | LinkPure: Dark theme | LinkPure | In progress | component-specific validation | Evidence required before completion |
| LINKPURE-REFERENCE-001 | LinkPure: Official web reference | LinkPure | In progress | component-specific validation | Evidence required before completion |
| LINKPURE-DIFF-001 | LinkPure: Native screenshot and visual diff | LinkPure | In progress | component-specific validation | Evidence required before completion |
| LINKPURE-GALLERY-001 | LinkPure: Gallery integration | LinkPure | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| LINKPURE-DOCS-001 | LinkPure: Documentation | LinkPure | Complete | component-specific validation | docs/api-mapping/link-pure.md |
| LINKPURE-TESTS-001 | LinkPure: Automated tests | LinkPure | Complete | component-specific validation | CTest |
| BUTTONPURE-API-001 | ButtonPure: Public API mapping | ButtonPure | Complete | component-specific validation | docs/api-mapping/button-pure.md |
| BUTTONPURE-TOKENS-001 | ButtonPure: Token mapping | ButtonPure | Complete | component-specific validation | spec/components/button-pure.json |
| BUTTONPURE-GEOMETRY-001 | ButtonPure: Geometry specification | ButtonPure | Complete | component-specific validation | spec/components/button-pure.json |
| BUTTONPURE-STATES-001 | ButtonPure: Supported states | ButtonPure | Complete | component-specific validation | spec/components/button-pure.json |
| BUTTONPURE-A11Y-001 | ButtonPure: Accessibility | ButtonPure | Complete | component-specific validation | tests/accessibility |
| BUTTONPURE-KEYBOARD-001 | ButtonPure: Keyboard behavior | ButtonPure | Complete | component-specific validation | tests/interaction |
| BUTTONPURE-RTL-001 | ButtonPure: RTL behavior | ButtonPure | In progress | component-specific validation | Evidence required before completion |
| BUTTONPURE-LIGHT-001 | ButtonPure: Light theme | ButtonPure | In progress | component-specific validation | Evidence required before completion |
| BUTTONPURE-DARK-001 | ButtonPure: Dark theme | ButtonPure | In progress | component-specific validation | Evidence required before completion |
| BUTTONPURE-REFERENCE-001 | ButtonPure: Official web reference | ButtonPure | In progress | component-specific validation | Evidence required before completion |
| BUTTONPURE-DIFF-001 | ButtonPure: Native screenshot and visual diff | ButtonPure | In progress | component-specific validation | Evidence required before completion |
| BUTTONPURE-GALLERY-001 | ButtonPure: Gallery integration | ButtonPure | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| BUTTONPURE-DOCS-001 | ButtonPure: Documentation | ButtonPure | Complete | component-specific validation | docs/api-mapping/button-pure.md |
| BUTTONPURE-TESTS-001 | ButtonPure: Automated tests | ButtonPure | Complete | component-specific validation | CTest |
| INPUTTEXT-API-001 | InputText: Public API mapping | InputText | Complete | component-specific validation | docs/api-mapping/input-text.md |
| INPUTTEXT-TOKENS-001 | InputText: Token mapping | InputText | Complete | component-specific validation | spec/components/input-text.json |
| INPUTTEXT-GEOMETRY-001 | InputText: Geometry specification | InputText | Complete | component-specific validation | spec/components/input-text.json |
| INPUTTEXT-STATES-001 | InputText: Supported states | InputText | Complete | component-specific validation | spec/components/input-text.json |
| INPUTTEXT-A11Y-001 | InputText: Accessibility | InputText | Complete | component-specific validation | tests/accessibility |
| INPUTTEXT-KEYBOARD-001 | InputText: Keyboard behavior | InputText | Complete | component-specific validation | tests/interaction |
| INPUTTEXT-RTL-001 | InputText: RTL behavior | InputText | In progress | component-specific validation | Evidence required before completion |
| INPUTTEXT-LIGHT-001 | InputText: Light theme | InputText | In progress | component-specific validation | Evidence required before completion |
| INPUTTEXT-DARK-001 | InputText: Dark theme | InputText | In progress | component-specific validation | Evidence required before completion |
| INPUTTEXT-REFERENCE-001 | InputText: Official web reference | InputText | In progress | component-specific validation | Evidence required before completion |
| INPUTTEXT-DIFF-001 | InputText: Native screenshot and visual diff | InputText | In progress | component-specific validation | Evidence required before completion |
| INPUTTEXT-GALLERY-001 | InputText: Gallery integration | InputText | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| INPUTTEXT-DOCS-001 | InputText: Documentation | InputText | Complete | component-specific validation | docs/api-mapping/input-text.md |
| INPUTTEXT-TESTS-001 | InputText: Automated tests | InputText | Complete | component-specific validation | CTest |
| INPUTPASSWORD-API-001 | InputPassword: Public API mapping | InputPassword | Complete | component-specific validation | docs/api-mapping/input-password.md |
| INPUTPASSWORD-TOKENS-001 | InputPassword: Token mapping | InputPassword | Complete | component-specific validation | spec/components/input-password.json |
| INPUTPASSWORD-GEOMETRY-001 | InputPassword: Geometry specification | InputPassword | Complete | component-specific validation | spec/components/input-password.json |
| INPUTPASSWORD-STATES-001 | InputPassword: Supported states | InputPassword | Complete | component-specific validation | spec/components/input-password.json |
| INPUTPASSWORD-A11Y-001 | InputPassword: Accessibility | InputPassword | Complete | component-specific validation | tests/accessibility |
| INPUTPASSWORD-KEYBOARD-001 | InputPassword: Keyboard behavior | InputPassword | Complete | component-specific validation | tests/interaction |
| INPUTPASSWORD-RTL-001 | InputPassword: RTL behavior | InputPassword | In progress | component-specific validation | Evidence required before completion |
| INPUTPASSWORD-LIGHT-001 | InputPassword: Light theme | InputPassword | In progress | component-specific validation | Evidence required before completion |
| INPUTPASSWORD-DARK-001 | InputPassword: Dark theme | InputPassword | In progress | component-specific validation | Evidence required before completion |
| INPUTPASSWORD-REFERENCE-001 | InputPassword: Official web reference | InputPassword | In progress | component-specific validation | Evidence required before completion |
| INPUTPASSWORD-DIFF-001 | InputPassword: Native screenshot and visual diff | InputPassword | In progress | component-specific validation | Evidence required before completion |
| INPUTPASSWORD-GALLERY-001 | InputPassword: Gallery integration | InputPassword | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| INPUTPASSWORD-DOCS-001 | InputPassword: Documentation | InputPassword | Complete | component-specific validation | docs/api-mapping/input-password.md |
| INPUTPASSWORD-TESTS-001 | InputPassword: Automated tests | InputPassword | Complete | component-specific validation | CTest |
| SWITCH-API-001 | Switch: Public API mapping | Switch | Complete | component-specific validation | docs/api-mapping/switch.md |
| SWITCH-TOKENS-001 | Switch: Token mapping | Switch | Complete | component-specific validation | spec/components/switch.json |
| SWITCH-GEOMETRY-001 | Switch: Geometry specification | Switch | Complete | component-specific validation | spec/components/switch.json |
| SWITCH-STATES-001 | Switch: Supported states | Switch | Complete | component-specific validation | spec/components/switch.json |
| SWITCH-A11Y-001 | Switch: Accessibility | Switch | Complete | component-specific validation | tests/accessibility |
| SWITCH-KEYBOARD-001 | Switch: Keyboard behavior | Switch | Complete | component-specific validation | tests/interaction |
| SWITCH-RTL-001 | Switch: RTL behavior | Switch | In progress | component-specific validation | Evidence required before completion |
| SWITCH-LIGHT-001 | Switch: Light theme | Switch | In progress | component-specific validation | Evidence required before completion |
| SWITCH-DARK-001 | Switch: Dark theme | Switch | In progress | component-specific validation | Evidence required before completion |
| SWITCH-REFERENCE-001 | Switch: Official web reference | Switch | In progress | component-specific validation | Evidence required before completion |
| SWITCH-DIFF-001 | Switch: Native screenshot and visual diff | Switch | In progress | component-specific validation | Evidence required before completion |
| SWITCH-GALLERY-001 | Switch: Gallery integration | Switch | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| SWITCH-DOCS-001 | Switch: Documentation | Switch | Complete | component-specific validation | docs/api-mapping/switch.md |
| SWITCH-TESTS-001 | Switch: Automated tests | Switch | Complete | component-specific validation | CTest |
| CHECKBOX-API-001 | Checkbox: Public API mapping | Checkbox | Complete | component-specific validation | docs/api-mapping/checkbox.md |
| CHECKBOX-TOKENS-001 | Checkbox: Token mapping | Checkbox | Complete | component-specific validation | spec/components/checkbox.json |
| CHECKBOX-GEOMETRY-001 | Checkbox: Geometry specification | Checkbox | Complete | component-specific validation | spec/components/checkbox.json |
| CHECKBOX-STATES-001 | Checkbox: Supported states | Checkbox | Complete | component-specific validation | spec/components/checkbox.json |
| CHECKBOX-A11Y-001 | Checkbox: Accessibility | Checkbox | Complete | component-specific validation | tests/accessibility |
| CHECKBOX-KEYBOARD-001 | Checkbox: Keyboard behavior | Checkbox | Complete | component-specific validation | tests/interaction |
| CHECKBOX-RTL-001 | Checkbox: RTL behavior | Checkbox | In progress | component-specific validation | Evidence required before completion |
| CHECKBOX-LIGHT-001 | Checkbox: Light theme | Checkbox | In progress | component-specific validation | Evidence required before completion |
| CHECKBOX-DARK-001 | Checkbox: Dark theme | Checkbox | In progress | component-specific validation | Evidence required before completion |
| CHECKBOX-REFERENCE-001 | Checkbox: Official web reference | Checkbox | In progress | component-specific validation | Evidence required before completion |
| CHECKBOX-DIFF-001 | Checkbox: Native screenshot and visual diff | Checkbox | In progress | component-specific validation | Evidence required before completion |
| CHECKBOX-GALLERY-001 | Checkbox: Gallery integration | Checkbox | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| CHECKBOX-DOCS-001 | Checkbox: Documentation | Checkbox | Complete | component-specific validation | docs/api-mapping/checkbox.md |
| CHECKBOX-TESTS-001 | Checkbox: Automated tests | Checkbox | Complete | component-specific validation | CTest |
| RADIOGROUP-API-001 | RadioGroup: Public API mapping | RadioGroup | Complete | component-specific validation | docs/api-mapping/radio-group.md |
| RADIOGROUP-TOKENS-001 | RadioGroup: Token mapping | RadioGroup | Complete | component-specific validation | spec/components/radio-group.json |
| RADIOGROUP-GEOMETRY-001 | RadioGroup: Geometry specification | RadioGroup | Complete | component-specific validation | spec/components/radio-group.json |
| RADIOGROUP-STATES-001 | RadioGroup: Supported states | RadioGroup | Complete | component-specific validation | spec/components/radio-group.json |
| RADIOGROUP-A11Y-001 | RadioGroup: Accessibility | RadioGroup | Complete | component-specific validation | tests/accessibility |
| RADIOGROUP-KEYBOARD-001 | RadioGroup: Keyboard behavior | RadioGroup | Complete | component-specific validation | tests/interaction |
| RADIOGROUP-RTL-001 | RadioGroup: RTL behavior | RadioGroup | In progress | component-specific validation | Evidence required before completion |
| RADIOGROUP-LIGHT-001 | RadioGroup: Light theme | RadioGroup | In progress | component-specific validation | Evidence required before completion |
| RADIOGROUP-DARK-001 | RadioGroup: Dark theme | RadioGroup | In progress | component-specific validation | Evidence required before completion |
| RADIOGROUP-REFERENCE-001 | RadioGroup: Official web reference | RadioGroup | In progress | component-specific validation | Evidence required before completion |
| RADIOGROUP-DIFF-001 | RadioGroup: Native screenshot and visual diff | RadioGroup | In progress | component-specific validation | Evidence required before completion |
| RADIOGROUP-GALLERY-001 | RadioGroup: Gallery integration | RadioGroup | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| RADIOGROUP-DOCS-001 | RadioGroup: Documentation | RadioGroup | Complete | component-specific validation | docs/api-mapping/radio-group.md |
| RADIOGROUP-TESTS-001 | RadioGroup: Automated tests | RadioGroup | Complete | component-specific validation | CTest |
| SELECT-API-001 | Select: Public API mapping | Select | Complete | component-specific validation | docs/api-mapping/select.md |
| SELECT-TOKENS-001 | Select: Token mapping | Select | Complete | component-specific validation | spec/components/select.json |
| SELECT-GEOMETRY-001 | Select: Geometry specification | Select | Complete | component-specific validation | spec/components/select.json |
| SELECT-STATES-001 | Select: Supported states | Select | Complete | component-specific validation | spec/components/select.json |
| SELECT-A11Y-001 | Select: Accessibility | Select | Complete | component-specific validation | tests/accessibility |
| SELECT-KEYBOARD-001 | Select: Keyboard behavior | Select | Complete | component-specific validation | tests/interaction |
| SELECT-RTL-001 | Select: RTL behavior | Select | In progress | component-specific validation | Evidence required before completion |
| SELECT-LIGHT-001 | Select: Light theme | Select | In progress | component-specific validation | Evidence required before completion |
| SELECT-DARK-001 | Select: Dark theme | Select | In progress | component-specific validation | Evidence required before completion |
| SELECT-REFERENCE-001 | Select: Official web reference | Select | In progress | component-specific validation | Evidence required before completion |
| SELECT-DIFF-001 | Select: Native screenshot and visual diff | Select | In progress | component-specific validation | Evidence required before completion |
| SELECT-GALLERY-001 | Select: Gallery integration | Select | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| SELECT-DOCS-001 | Select: Documentation | Select | Complete | component-specific validation | docs/api-mapping/select.md |
| SELECT-TESTS-001 | Select: Automated tests | Select | Complete | component-specific validation | CTest |
| BANNER-API-001 | Banner: Public API mapping | Banner | Complete | component-specific validation | docs/api-mapping/banner.md |
| BANNER-TOKENS-001 | Banner: Token mapping | Banner | Complete | component-specific validation | spec/components/banner.json |
| BANNER-GEOMETRY-001 | Banner: Geometry specification | Banner | Complete | component-specific validation | spec/components/banner.json |
| BANNER-STATES-001 | Banner: Supported states | Banner | Complete | component-specific validation | spec/components/banner.json |
| BANNER-A11Y-001 | Banner: Accessibility | Banner | In progress | component-specific validation | Evidence required before completion |
| BANNER-KEYBOARD-001 | Banner: Keyboard behavior | Banner | In progress | component-specific validation | Evidence required before completion |
| BANNER-RTL-001 | Banner: RTL behavior | Banner | In progress | component-specific validation | Evidence required before completion |
| BANNER-LIGHT-001 | Banner: Light theme | Banner | In progress | component-specific validation | Evidence required before completion |
| BANNER-DARK-001 | Banner: Dark theme | Banner | In progress | component-specific validation | Evidence required before completion |
| BANNER-REFERENCE-001 | Banner: Official web reference | Banner | In progress | component-specific validation | Evidence required before completion |
| BANNER-DIFF-001 | Banner: Native screenshot and visual diff | Banner | In progress | component-specific validation | Evidence required before completion |
| BANNER-GALLERY-001 | Banner: Gallery integration | Banner | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| BANNER-DOCS-001 | Banner: Documentation | Banner | Complete | component-specific validation | docs/api-mapping/banner.md |
| BANNER-TESTS-001 | Banner: Automated tests | Banner | Complete | component-specific validation | CTest |
| INLINENOTIFICATION-API-001 | InlineNotification: Public API mapping | InlineNotification | Complete | component-specific validation | docs/api-mapping/inline-notification.md |
| INLINENOTIFICATION-TOKENS-001 | InlineNotification: Token mapping | InlineNotification | Complete | component-specific validation | spec/components/inline-notification.json |
| INLINENOTIFICATION-GEOMETRY-001 | InlineNotification: Geometry specification | InlineNotification | Complete | component-specific validation | spec/components/inline-notification.json |
| INLINENOTIFICATION-STATES-001 | InlineNotification: Supported states | InlineNotification | Complete | component-specific validation | spec/components/inline-notification.json |
| INLINENOTIFICATION-A11Y-001 | InlineNotification: Accessibility | InlineNotification | Complete | component-specific validation | tests/accessibility |
| INLINENOTIFICATION-KEYBOARD-001 | InlineNotification: Keyboard behavior | InlineNotification | In progress | component-specific validation | Evidence required before completion |
| INLINENOTIFICATION-RTL-001 | InlineNotification: RTL behavior | InlineNotification | In progress | component-specific validation | Evidence required before completion |
| INLINENOTIFICATION-LIGHT-001 | InlineNotification: Light theme | InlineNotification | In progress | component-specific validation | Evidence required before completion |
| INLINENOTIFICATION-DARK-001 | InlineNotification: Dark theme | InlineNotification | In progress | component-specific validation | Evidence required before completion |
| INLINENOTIFICATION-REFERENCE-001 | InlineNotification: Official web reference | InlineNotification | In progress | component-specific validation | Evidence required before completion |
| INLINENOTIFICATION-DIFF-001 | InlineNotification: Native screenshot and visual diff | InlineNotification | In progress | component-specific validation | Evidence required before completion |
| INLINENOTIFICATION-GALLERY-001 | InlineNotification: Gallery integration | InlineNotification | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| INLINENOTIFICATION-DOCS-001 | InlineNotification: Documentation | InlineNotification | Complete | component-specific validation | docs/api-mapping/inline-notification.md |
| INLINENOTIFICATION-TESTS-001 | InlineNotification: Automated tests | InlineNotification | Complete | component-specific validation | CTest |
| TAG-API-001 | Tag: Public API mapping | Tag | Complete | component-specific validation | docs/api-mapping/tag.md |
| TAG-TOKENS-001 | Tag: Token mapping | Tag | Complete | component-specific validation | spec/components/tag.json |
| TAG-GEOMETRY-001 | Tag: Geometry specification | Tag | Complete | component-specific validation | spec/components/tag.json |
| TAG-STATES-001 | Tag: Supported states | Tag | Complete | component-specific validation | spec/components/tag.json |
| TAG-A11Y-001 | Tag: Accessibility | Tag | Complete | component-specific validation | tests/accessibility |
| TAG-KEYBOARD-001 | Tag: Keyboard behavior | Tag | In progress | component-specific validation | Evidence required before completion |
| TAG-RTL-001 | Tag: RTL behavior | Tag | In progress | component-specific validation | Evidence required before completion |
| TAG-LIGHT-001 | Tag: Light theme | Tag | In progress | component-specific validation | Evidence required before completion |
| TAG-DARK-001 | Tag: Dark theme | Tag | In progress | component-specific validation | Evidence required before completion |
| TAG-REFERENCE-001 | Tag: Official web reference | Tag | In progress | component-specific validation | Evidence required before completion |
| TAG-DIFF-001 | Tag: Native screenshot and visual diff | Tag | In progress | component-specific validation | Evidence required before completion |
| TAG-GALLERY-001 | Tag: Gallery integration | Tag | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| TAG-DOCS-001 | Tag: Documentation | Tag | Complete | component-specific validation | docs/api-mapping/tag.md |
| TAG-TESTS-001 | Tag: Automated tests | Tag | Complete | component-specific validation | CTest |
| TABS-API-001 | Tabs: Public API mapping | Tabs | Complete | component-specific validation | docs/api-mapping/tabs.md |
| TABS-TOKENS-001 | Tabs: Token mapping | Tabs | Complete | component-specific validation | spec/components/tabs.json |
| TABS-GEOMETRY-001 | Tabs: Geometry specification | Tabs | Complete | component-specific validation | spec/components/tabs.json |
| TABS-STATES-001 | Tabs: Supported states | Tabs | Complete | component-specific validation | spec/components/tabs.json |
| TABS-A11Y-001 | Tabs: Accessibility | Tabs | Complete | component-specific validation | tests/accessibility |
| TABS-KEYBOARD-001 | Tabs: Keyboard behavior | Tabs | Complete | component-specific validation | tests/interaction |
| TABS-RTL-001 | Tabs: RTL behavior | Tabs | In progress | component-specific validation | Evidence required before completion |
| TABS-LIGHT-001 | Tabs: Light theme | Tabs | In progress | component-specific validation | Evidence required before completion |
| TABS-DARK-001 | Tabs: Dark theme | Tabs | In progress | component-specific validation | Evidence required before completion |
| TABS-REFERENCE-001 | Tabs: Official web reference | Tabs | In progress | component-specific validation | Evidence required before completion |
| TABS-DIFF-001 | Tabs: Native screenshot and visual diff | Tabs | In progress | component-specific validation | Evidence required before completion |
| TABS-GALLERY-001 | Tabs: Gallery integration | Tabs | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| TABS-DOCS-001 | Tabs: Documentation | Tabs | Complete | component-specific validation | docs/api-mapping/tabs.md |
| TABS-TESTS-001 | Tabs: Automated tests | Tabs | Complete | component-specific validation | CTest |
| MODAL-API-001 | Modal: Public API mapping | Modal | Complete | component-specific validation | docs/api-mapping/modal.md |
| MODAL-TOKENS-001 | Modal: Token mapping | Modal | Complete | component-specific validation | spec/components/modal.json |
| MODAL-GEOMETRY-001 | Modal: Geometry specification | Modal | Complete | component-specific validation | spec/components/modal.json |
| MODAL-STATES-001 | Modal: Supported states | Modal | Complete | component-specific validation | spec/components/modal.json |
| MODAL-A11Y-001 | Modal: Accessibility | Modal | Complete | component-specific validation | tests/accessibility |
| MODAL-KEYBOARD-001 | Modal: Keyboard behavior | Modal | Complete | component-specific validation | tests/interaction |
| MODAL-RTL-001 | Modal: RTL behavior | Modal | In progress | component-specific validation | Evidence required before completion |
| MODAL-LIGHT-001 | Modal: Light theme | Modal | In progress | component-specific validation | Evidence required before completion |
| MODAL-DARK-001 | Modal: Dark theme | Modal | In progress | component-specific validation | Evidence required before completion |
| MODAL-REFERENCE-001 | Modal: Official web reference | Modal | In progress | component-specific validation | Evidence required before completion |
| MODAL-DIFF-001 | Modal: Native screenshot and visual diff | Modal | In progress | component-specific validation | Evidence required before completion |
| MODAL-GALLERY-001 | Modal: Gallery integration | Modal | Complete | component-specific validation | examples/component-lab and examples/reference-gallery |
| MODAL-DOCS-001 | Modal: Documentation | Modal | Complete | component-specific validation | docs/api-mapping/modal.md |
| MODAL-TESTS-001 | Modal: Automated tests | Modal | Complete | component-specific validation | CTest |
