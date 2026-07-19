import QtQuick
import QtQuick.Controls as QQC
import QtQuick.Layouts
import Pds.Native as Pds

QQC.ApplicationWindow {
    id: window

    width: 1440
    height: 900
    minimumWidth: 960
    minimumHeight: 640
    visible: true
    title: qsTr("Porsche Design System v4 · Native Qt Reference")
    color: Pds.Tokens.colorCanvas
    font.family: Pds.Typography.family
    font.pixelSize: Pds.Tokens.typescaleSm
    LayoutMirroring.childrenInherit: true

    property int currentPageIndex: 0
    property bool expandedText: false
    property bool modalOpen: false
    property bool bannerOpen: false
    readonly property var currentPage: pages[currentPageIndex]
    readonly property int pageCount: pages.length
    readonly property int currentFixtureStatus: fixtureLoader.status
    readonly property var pages: [
        { title: qsTr("Overview"), key: "overview",
          summary: qsTr("Native Qt Quick coverage of the locked Porsche Design System v4.4.0 milestone."),
          properties: qsTr("Theme, direction, text expansion and reduced motion."),
          states: qsTr("Light, dark, system, LTR and RTL."),
          keyboard: qsTr("Use Tab to move through controls and Enter or Space to activate them.") },
        { title: qsTr("Foundations"), key: "foundations",
          summary: qsTr("Generated tokens, semantic surfaces, motion and typography resolution."),
          properties: qsTr("Color, spacing, radius, motion and typography tokens."),
          states: qsTr("Theme-aware semantic values."),
          keyboard: qsTr("Foundational values are non-interactive.") },
        { title: qsTr("Colors"), key: "colors",
          summary: qsTr("Semantic colors resolve from the active upstream color scheme."),
          properties: qsTr("Canvas, surface, primary, contrast, success, warning, error and info."),
          states: qsTr("Light, dark and system color schemes."),
          keyboard: qsTr("Color samples are decorative.") },
        { title: qsTr("Typography"), key: "typography",
          summary: qsTr("Responsive Porsche v4 type scales without fallback-font distortion."),
          properties: qsTr("Size, weight, alignment, semantic color, hyphens and ellipsis."),
          states: qsTr("Normal and expanded copy in LTR and RTL."),
          keyboard: qsTr("Typography is exposed as accessible static text and headings.") },
        { title: qsTr("Icons"), key: "icons",
          summary: qsTr("Official icon geometry is consumed through an external licensed provider."),
          properties: qsTr("Name, source, size, semantic color, direction and accessible name."),
          states: qsTr("Default, disabled, directional, decorative and missing."),
          keyboard: qsTr("Decorative icons are ignored by assistive technology.") },
        { title: qsTr("Divider"), key: "divider",
          summary: qsTr("Semantic one-pixel separators for horizontal and vertical composition."),
          properties: qsTr("Direction and semantic color."),
          states: qsTr("Horizontal, vertical, light, dark and RTL."),
          keyboard: qsTr("Exposed with the separator accessibility role.") },
        { title: qsTr("Button"), key: "button",
          summary: qsTr("Calibrated primary and secondary Porsche v4 button."),
          properties: qsTr("Text, variant, type, compact, icon, loading, disabled and hide label."),
          states: qsTr("Default, hover, focus, loading, disabled and compact."),
          keyboard: qsTr("Enter and Space activate the button; Tab moves focus.") },
        { title: qsTr("Button Pure"), key: "button-pure",
          summary: qsTr("Low-emphasis action with label and optional directional icon."),
          properties: qsTr("Text, icon, alignment, size, active, loading and disabled."),
          states: qsTr("Default, active, loading, disabled, hover and focus."),
          keyboard: qsTr("Enter and Space activate the button.") },
        { title: qsTr("Text"), key: "text",
          summary: qsTr("Semantic body text using the shared responsive type resolver."),
          properties: qsTr("Size, weight, alignment, color, hyphens, role and ellipsis."),
          states: qsTr("Semantic colors, expanded text and RTL."),
          keyboard: qsTr("Exposed as accessible static text.") },
        { title: qsTr("Heading"), key: "heading",
          summary: qsTr("Responsive headings with explicit semantic levels."),
          properties: qsTr("Size, level, weight, alignment, color, hyphens and ellipsis."),
          states: qsTr("Responsive sizes, expanded text and RTL."),
          keyboard: qsTr("Exposed with the heading accessibility role and level metadata.") },
        { title: qsTr("Input Text"), key: "input-text",
          summary: qsTr("Free-form input with labels, descriptions and validation."),
          properties: qsTr("Value, label, description, placeholder, compact, state, counter, read-only and loading."),
          states: qsTr("Default, focus, success, error, read-only, disabled and compact."),
          keyboard: qsTr("Tab focuses the editor; standard text-editing keys are supported.") },
        { title: qsTr("Input Password"), key: "input-password",
          summary: qsTr("Password input derived from Input Text with controlled visibility."),
          properties: qsTr("Input Text properties plus toggle and show password."),
          states: qsTr("Hidden, visible, focus, error, loading and disabled."),
          keyboard: qsTr("Tab reaches the editor and visibility action; Enter activates the action.") },
        { title: qsTr("Switch"), key: "switch",
          summary: qsTr("Binary setting control with normal and compact geometry."),
          properties: qsTr("Text, checked, compact and disabled."),
          states: qsTr("On, off, hover, focus and disabled."),
          keyboard: qsTr("Space toggles the proposed value.") },
        { title: qsTr("Checkbox"), key: "checkbox",
          summary: qsTr("Binary or partial selection control."),
          properties: qsTr("Text, checked, indeterminate, compact and disabled."),
          states: qsTr("Unchecked, checked, indeterminate, hover, focus and disabled."),
          keyboard: qsTr("Space toggles the selection.") },
        { title: qsTr("Radio Group"), key: "radio-group",
          summary: qsTr("Mutually exclusive options with disabled-item navigation."),
          properties: qsTr("Label, value, options, compact and disabled."),
          states: qsTr("Selected, unselected, focus and disabled option."),
          keyboard: qsTr("Arrow keys move to the next enabled option.") },
        { title: qsTr("Select"), key: "select",
          summary: qsTr("Single-value selection with popup and optional filtering."),
          properties: qsTr("Label, value, options, filter, compact, state and disabled."),
          states: qsTr("Closed, open, selected, focus, error, loading and disabled."),
          keyboard: qsTr("Enter or Space opens; arrows navigate; Escape closes.") },
        { title: qsTr("Banner"), key: "banner",
          summary: qsTr("Controlled global message layered above application content."),
          properties: qsTr("Open, heading, description, state, position and dismiss button."),
          states: qsTr("Info, success, warning and error."),
          keyboard: qsTr("Tab reaches actions; Escape or the dismiss action closes it.") },
        { title: qsTr("Inline Notification"), key: "inline-notification",
          summary: qsTr("Contextual message with semantic state and optional action."),
          properties: qsTr("Heading, description, state, action label and dismiss button."),
          states: qsTr("Info, success, warning and error."),
          keyboard: qsTr("Tab reaches the action and dismiss controls.") },
        { title: qsTr("Tag"), key: "tag",
          summary: qsTr("Non-interactive status label matching the upstream semantic contract."),
          properties: qsTr("Text, variant and compact."),
          states: qsTr("Primary, secondary and frosted semantic variants."),
          keyboard: qsTr("The tag is static text and is not focusable.") },
        { title: qsTr("Spinner"), key: "spinner",
          summary: qsTr("Indeterminate progress indicator used by loading states."),
          properties: qsTr("Extent, stroke width and semantic color."),
          states: qsTr("Normal, compact, light, dark and reduced motion."),
          keyboard: qsTr("Exposed as an accessible busy indicator where composed.") },
        { title: qsTr("Link"), key: "link",
          summary: qsTr("Prominent navigation action in primary and secondary variants."),
          properties: qsTr("Text, variant, icon, compact, hide label and destination metadata."),
          states: qsTr("Default, hover, focus, compact and hidden label."),
          keyboard: qsTr("Enter and Space activate the link.") },
        { title: qsTr("Link Pure"), key: "link-pure",
          summary: qsTr("Inline navigation action with optional underline and icon."),
          properties: qsTr("Text, icon, alignment, size, underline, active and destination metadata."),
          states: qsTr("Default, hover, focus, active and hidden label."),
          keyboard: qsTr("Enter and Space activate the link.") },
        { title: qsTr("Tabs"), key: "tabs",
          summary: qsTr("Page-tab list with controlled selection and content panel."),
          properties: qsTr("Items, active index, background, size, compact and accessibility labels."),
          states: qsTr("Selected, hover, focus, disabled item, compact and RTL."),
          keyboard: qsTr("Arrow keys navigate; Home and End select the first and last tabs.") },
        { title: qsTr("Modal"), key: "modal",
          summary: qsTr("Controlled dialog with backdrop, focus management and content slots."),
          properties: qsTr("Open, backdrop, background, fullscreen, dismiss button and content slots."),
          states: qsTr("Closed, open, fullscreen, reduced motion and RTL."),
          keyboard: qsTr("Focus moves into the dialog; Escape dismisses and focus is restored.") },
        { title: qsTr("Accessibility"), key: "accessibility",
          summary: qsTr("Roles, names, descriptions, focus order and keyboard behavior."),
          properties: qsTr("Accessible name, description, role, checked, selected and disabled state."),
          states: qsTr("Keyboard-only and assistive-technology fixtures."),
          keyboard: qsTr("Use Tab, Shift+Tab, Enter, Space, arrows, Home, End and Escape.") },
        { title: qsTr("RTL"), key: "rtl",
          summary: qsTr("Direction-aware controls and directional icon behavior."),
          properties: qsTr("Layout mirroring and directional metadata."),
          states: qsTr("LTR and RTL."),
          keyboard: qsTr("Arrow behavior follows the active layout direction.") },
        { title: qsTr("Dark Theme"), key: "dark",
          summary: qsTr("Semantic tokens resolve without component-specific palette overrides."),
          properties: qsTr("Theme mode and effective system scheme."),
          states: qsTr("Light, dark and system."),
          keyboard: qsTr("Use the theme controls in the page header.") },
        { title: qsTr("Text Expansion"), key: "expansion",
          summary: qsTr("Long German and Persian copy validates layout resilience."),
          properties: qsTr("Wrapping, hyphens, responsive width and direction."),
          states: qsTr("Normal and expanded copy."),
          keyboard: qsTr("Use the text control in the page header.") },
        { title: qsTr("Visual Fidelity"), key: "fidelity",
          summary: qsTr("Measured evidence remains separate from subjective visual review."),
          properties: qsTr("Geometry, pixels, mean color delta, bounds and availability."),
          states: qsTr("Qt actual, upstream reference, overlay and diff."),
          keyboard: qsTr("Reports are static validation artifacts.") }
    ]

    onWidthChanged: Pds.Theme.viewportWidth = Math.max(320, width - navigation.width)

    Component.onCompleted: {
        Pds.Theme.viewportWidth = Math.max(320, width - navigation.width)
        // Reference-app-only external injection. No restricted Porsche asset
        // is redistributed by the native library.
        Pds.IconProvider.baseUrl =
                "https://cdn.ui.porsche.com/porsche-design-system/icons/"
        Pds.IconProvider.manifest = {
            "arrow-right": "arrow-right.872716b.svg",
            "arrow-head-down": "arrow-head-down.1e3cbb8.svg",
            "check": "check.8ba06be.svg",
            "close": "close.eec3c5d.svg",
            "configurate": "configurate.5311c8d.svg",
            "external": "external.fb677b9.svg",
            "search": "search.3f0f1ce.svg",
            "view": "view.5b4d7f6.svg"
        }
    }

    function fixtureForKey(key) {
        switch (key) {
        case "overview": return overviewFixture
        case "foundations": return foundationsFixture
        case "colors": return colorsFixture
        case "typography": return typographyFixture
        case "icons": return iconsFixture
        case "divider": return dividerFixture
        case "button": return buttonFixture
        case "button-pure": return buttonPureFixture
        case "text": return textFixture
        case "heading": return headingFixture
        case "input-text": return inputTextFixture
        case "input-password": return inputPasswordFixture
        case "switch": return switchFixture
        case "checkbox": return checkboxFixture
        case "radio-group": return radioGroupFixture
        case "select": return selectFixture
        case "banner": return bannerFixture
        case "inline-notification": return notificationFixture
        case "tag": return tagFixture
        case "spinner": return spinnerFixture
        case "link": return linkFixture
        case "link-pure": return linkPureFixture
        case "tabs": return tabsFixture
        case "modal": return modalFixture
        case "accessibility": return accessibilityFixture
        case "rtl": return rtlFixture
        case "dark": return darkFixture
        case "expansion": return expansionFixture
        case "fidelity": return fidelityFixture
        default: return overviewFixture
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            id: navigation
            Layout.preferredWidth: 364
            Layout.fillHeight: true
            color: Pds.Tokens.colorSurface
            border.width: 0

            ColumnLayout {
                anchors.fill: parent
                anchors.topMargin: Pds.Tokens.spacingStaticLg
                anchors.bottomMargin: Pds.Tokens.spacingStaticMd
                spacing: Pds.Tokens.spacingStaticMd

                Column {
                    Layout.fillWidth: true
                    leftPadding: Pds.Tokens.spacingStaticLg
                    rightPadding: Pds.Tokens.spacingStaticLg
                    spacing: Pds.Tokens.spacingStaticXs

                    Pds.Text {
                        width: parent.width
                        text: qsTr("PORSCHE DESIGN SYSTEM")
                        weight: Pds.Text.Semibold
                        size: Pds.Text.SizeXs
                        font.letterSpacing: 2
                    }
                    Pds.Text {
                        width: parent.width
                        text: qsTr("Native Qt · v4.4.0")
                        size: Pds.Text.SizeXs
                        semanticColor: Pds.Text.ContrastMedium
                    }
                }

                Pds.Divider { Layout.fillWidth: true }

                QQC.ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    contentWidth: availableWidth

                    ListView {
                        id: pageList
                        width: parent.width
                        model: window.pages
                        currentIndex: window.currentPageIndex
                        spacing: 2
                        clip: true
                        reuseItems: true
                        cacheBuffer: 120

                        delegate: Rectangle {
                            required property int index
                            required property var modelData

                            width: pageList.width
                            height: 40
                            color: index === window.currentPageIndex
                                   ? Pds.Tokens.colorFrosted : "transparent"
                            radius: Pds.Tokens.radiusMd

                            Pds.Text {
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.leftMargin: Pds.Tokens.spacingStaticMd
                                anchors.rightMargin: Pds.Tokens.spacingStaticMd
                                anchors.verticalCenter: parent.verticalCenter
                                text: parent.modelData.title
                                size: Pds.Text.SizeXs
                                weight: parent.index === window.currentPageIndex
                                        ? Pds.Text.Semibold : Pds.Text.Normal
                                ellipsis: true
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    window.currentPageIndex = parent.index
                                    pageScroll.contentItem.contentY = 0
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Pds.Tokens.colorCanvas

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: headerContent.implicitHeight
                                            + Pds.Tokens.spacingStaticMd * 2
                    color: Pds.Tokens.colorCanvas

                    ColumnLayout {
                        id: headerContent
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: Pds.Tokens.spacingStaticXl
                        anchors.rightMargin: Pds.Tokens.spacingStaticXl
                        spacing: Pds.Tokens.spacingStaticSm

                        Pds.Text {
                            Layout.fillWidth: true
                            text: qsTr("Native reference gallery")
                            size: Pds.Text.SizeXs
                            semanticColor: Pds.Text.ContrastMedium
                        }

                        Flow {
                            Layout.fillWidth: true
                            spacing: Pds.Tokens.spacingStaticSm

                            Pds.Button {
                                text: qsTr("Light")
                                compact: true
                                variant: Pds.Button.Secondary
                                onClicked: Pds.Theme.mode = Pds.Theme.Light
                            }
                            Pds.Button {
                                text: qsTr("Dark")
                                compact: true
                                variant: Pds.Button.Secondary
                                onClicked: Pds.Theme.mode = Pds.Theme.Dark
                            }
                            Pds.Button {
                                text: qsTr("System")
                                compact: true
                                variant: Pds.Button.Secondary
                                onClicked: Pds.Theme.mode = Pds.Theme.System
                            }
                            Pds.Button {
                                text: window.LayoutMirroring.enabled
                                      ? qsTr("LTR") : qsTr("RTL")
                                compact: true
                                variant: Pds.Button.Secondary
                                onClicked: window.LayoutMirroring.enabled =
                                           !window.LayoutMirroring.enabled
                            }
                            Pds.Button {
                                text: window.expandedText
                                      ? qsTr("Normal text") : qsTr("Expand text")
                                compact: true
                                variant: Pds.Button.Secondary
                                onClicked: window.expandedText = !window.expandedText
                            }
                            Pds.Button {
                                text: Pds.Theme.reducedMotion
                                      ? qsTr("Motion on") : qsTr("Reduce motion")
                                compact: true
                                variant: Pds.Button.Secondary
                                onClicked: Pds.Theme.reducedMotion =
                                           !Pds.Theme.reducedMotion
                            }
                        }
                    }
                }

                Pds.Divider { Layout.fillWidth: true }

                QQC.ScrollView {
                    id: pageScroll
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    contentWidth: availableWidth

                    ColumnLayout {
                        width: Math.min(960, Math.max(0, pageScroll.availableWidth
                                                      - Pds.Tokens.spacingStaticXl * 2))
                        x: Math.max(Pds.Tokens.spacingStaticXl,
                                    (pageScroll.availableWidth - width) / 2)
                        spacing: Pds.Tokens.spacingStaticLg

                        Item {
                            Layout.preferredHeight: Pds.Tokens.spacingStaticSm
                        }

                        Pds.Heading {
                            Layout.fillWidth: true
                            text: window.currentPage.title
                            size: Pds.Heading.Size2Xl
                            hyphens: Pds.Heading.Auto
                            wrapMode: Text.WordWrap
                        }

                        Pds.Text {
                            Layout.fillWidth: true
                            text: window.expandedText
                                  ? window.currentPage.summary + " "
                                    + qsTr("Fahrzeugkonfigurationen remain readable with deliberately expanded localized content.")
                                  : window.currentPage.summary
                            hyphens: Pds.Text.Auto
                            wrapMode: Text.WordWrap
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: Math.max(
                                                        196,
                                                        fixtureLoader.item
                                                        ? fixtureLoader.item.implicitHeight
                                                          + Pds.Tokens.spacingStaticXl * 2
                                                        : 196)
                            color: Pds.Tokens.colorCanvas
                            border.width: 1
                            border.color: Pds.Tokens.colorContrastLower
                            radius: Pds.Tokens.radius3Xl

                            Loader {
                                id: fixtureLoader
                                anchors.fill: parent
                                anchors.margins: Pds.Tokens.spacingStaticXl
                                sourceComponent: window.fixtureForKey(
                                                     window.currentPage.key)
                                asynchronous: true
                                onLoaded: item.width = width
                                onWidthChanged: if (item) item.width = width
                            }

                            Pds.Spinner {
                                anchors.centerIn: parent
                                visible: fixtureLoader.status === Loader.Loading
                            }
                        }

                        GridLayout {
                            Layout.fillWidth: true
                            columns: width >= 760 ? 2 : 1
                            rowSpacing: Pds.Tokens.spacingStaticLg
                            columnSpacing: Pds.Tokens.spacingStaticXl

                            ColumnLayout {
                                Layout.fillWidth: true
                                Pds.Heading {
                                    Layout.fillWidth: true
                                    text: qsTr("Supported properties")
                                    size: Pds.Heading.SizeMd
                                }
                                Pds.Text {
                                    Layout.fillWidth: true
                                    text: window.currentPage.properties
                                    hyphens: Pds.Text.Auto
                                    wrapMode: Text.WordWrap
                                }
                            }
                            ColumnLayout {
                                Layout.fillWidth: true
                                Pds.Heading {
                                    Layout.fillWidth: true
                                    text: qsTr("States and variants")
                                    size: Pds.Heading.SizeMd
                                }
                                Pds.Text {
                                    Layout.fillWidth: true
                                    text: window.currentPage.states
                                    hyphens: Pds.Text.Auto
                                    wrapMode: Text.WordWrap
                                }
                            }
                            ColumnLayout {
                                Layout.fillWidth: true
                                Pds.Heading {
                                    Layout.fillWidth: true
                                    text: qsTr("Keyboard and accessibility")
                                    size: Pds.Heading.SizeMd
                                }
                                Pds.Text {
                                    Layout.fillWidth: true
                                    text: window.currentPage.keyboard
                                    hyphens: Pds.Text.Auto
                                    wrapMode: Text.WordWrap
                                }
                            }
                            ColumnLayout {
                                Layout.fillWidth: true
                                Pds.Heading {
                                    Layout.fillWidth: true
                                    text: qsTr("Validation evidence")
                                    size: Pds.Heading.SizeMd
                                }
                                Pds.Text {
                                    Layout.fillWidth: true
                                    text: window.currentPage.key === "button"
                                          ? qsTr("Geometry 0.99622 · pixels 0.99482 · mean RGB delta 1.321.")
                                          : qsTr("API, geometry, interaction and accessibility contracts run in the cumulative Qt test suite.")
                                    hyphens: Pds.Text.Auto
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }

                        Item {
                            Layout.preferredHeight: Pds.Tokens.spacingStaticLg
                        }
                    }
                }
            }
        }
    }

    Pds.Modal {
        open: window.modalOpen
        heading: qsTr("Confirm charging target")
        description: qsTr("The vehicle will charge to 80%. Focus returns to the triggering control after dismissal.")
        onDismiss: window.modalOpen = false
        footer: Component {
            Row {
                spacing: Pds.Tokens.spacingStaticMd
                Pds.Button {
                    text: qsTr("Confirm")
                    onClicked: window.modalOpen = false
                }
                Pds.Button {
                    text: qsTr("Cancel")
                    variant: Pds.Button.Secondary
                    onClicked: window.modalOpen = false
                }
            }
        }
    }

    Pds.Banner {
        open: window.bannerOpen
        heading: qsTr("Vehicle software update")
        description: qsTr("A new software version is ready to install.")
        state: "info"
        onDismiss: window.bannerOpen = false
    }

    Component {
        id: overviewFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            RowLayout {
                spacing: Pds.Tokens.spacingStaticMd
                Pds.Button { text: qsTr("Primary") }
                Pds.Button { text: qsTr("Secondary"); variant: Pds.Button.Secondary }
                Pds.Tag { text: qsTr("Native Qt"); variant: Pds.Tag.InfoFrosted }
            }
            Pds.InputText {
                Layout.fillWidth: true
                label: qsTr("Vehicle name")
                placeholder: qsTr("Enter a value")
            }
            Pds.InlineNotification {
                Layout.fillWidth: true
                heading: qsTr("All public types available")
                description: qsTr("The installed-consumer test instantiates every required unprefixed type.")
                state: "success"
            }
        }
    }

    Component {
        id: foundationsFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Text { text: qsTr("Canvas → Surface → Frosted → Contrast") }
            Row {
                spacing: Pds.Tokens.spacingStaticSm
                Repeater {
                    model: [8, 12, 16, 24, 32]
                    Rectangle {
                        required property int modelData
                        width: modelData
                        height: modelData
                        radius: Pds.Tokens.radiusSm
                        color: Pds.Tokens.colorPrimary
                    }
                }
            }
            Pds.Text {
                Layout.fillWidth: true
                text: qsTr("Tokens.qml and tokens.cppm are generated deterministically from the locked source.")
                semanticColor: Pds.Text.ContrastMedium
                wrapMode: Text.WordWrap
            }
        }
    }

    Component {
        id: colorsFixture
        GridLayout {
            columns: 4
            rowSpacing: Pds.Tokens.spacingStaticMd
            columnSpacing: Pds.Tokens.spacingStaticMd
            Repeater {
                model: [
                    { label: qsTr("Primary"), color: Pds.Tokens.colorPrimary },
                    { label: qsTr("Surface"), color: Pds.Tokens.colorSurface },
                    { label: qsTr("Success"), color: Pds.Tokens.colorSuccess },
                    { label: qsTr("Warning"), color: Pds.Tokens.colorWarning },
                    { label: qsTr("Error"), color: Pds.Tokens.colorError },
                    { label: qsTr("Info"), color: Pds.Tokens.colorInfo }
                ]
                Column {
                    required property var modelData
                    spacing: Pds.Tokens.spacingStaticXs
                    Rectangle {
                        width: 120
                        height: 72
                        radius: Pds.Tokens.radiusLg
                        color: parent.modelData.color
                        border.width: 1
                        border.color: Pds.Tokens.colorContrastLower
                    }
                    Pds.Text { text: parent.modelData.label; size: Pds.Text.SizeXs }
                }
            }
        }
    }

    Component {
        id: typographyFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticSm
            Pds.Heading { text: qsTr("Precision in every detail"); size: Pds.Heading.Size3Xl }
            Pds.Heading { text: qsTr("Responsive heading"); size: Pds.Heading.SizeXl }
            Pds.Text {
                Layout.fillWidth: true
                text: qsTr("Short English · Fahrzeugkonfigurationen · دقت در هر جزئیات · 911 GT3 RS")
                hyphens: Pds.Text.Auto
                wrapMode: Text.WordWrap
            }
        }
    }

    Component {
        id: iconsFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Row {
                id: iconRow
                spacing: Pds.Tokens.spacingStaticMd
                Pds.Icon { id: arrowIcon; name: "arrow-right"; size: Pds.Icon.SizeXs; accessibleName: qsTr("Arrow") }
                Pds.Icon { id: checkIcon; name: "check"; accessibleName: qsTr("Check") }
                Pds.Icon { id: externalIcon; name: "external"; size: Pds.Icon.SizeLg; accessibleName: qsTr("External") }
            }
            Pds.Text {
                Layout.fillWidth: true
                visible: arrowIcon.missing && checkIcon.missing && externalIcon.missing
                text: qsTr("Official assets are unavailable offline; configure IconProvider with a licensed source.")
                size: Pds.Text.SizeXs
                semanticColor: Pds.Text.ContrastMedium
                wrapMode: Text.WordWrap
            }
        }
    }

    Component {
        id: dividerFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticLg
            Pds.Text { text: qsTr("Content above") }
            Pds.Divider { Layout.fillWidth: true }
            Row {
                spacing: Pds.Tokens.spacingStaticMd
                Pds.Text { text: qsTr("Start") }
                Pds.Divider { direction: Pds.Divider.Vertical; implicitHeight: 48 }
                Pds.Text { text: qsTr("End") }
            }
        }
    }

    Component {
        id: buttonFixture
        GridLayout {
            columns: 3
            rowSpacing: Pds.Tokens.spacingStaticMd
            columnSpacing: Pds.Tokens.spacingStaticMd
            Pds.Button { text: qsTr("Primary") }
            Pds.Button { text: qsTr("Secondary"); variant: Pds.Button.Secondary }
            Pds.Button { text: qsTr("Loading"); loading: true }
            Pds.Button { text: qsTr("Compact"); compact: true }
            Pds.Button { text: qsTr("Disabled"); disabled: true }
            Pds.Button { text: qsTr("Compact secondary"); compact: true; variant: Pds.Button.Secondary }
        }
    }

    Component {
        id: buttonPureFixture
        Row {
            spacing: Pds.Tokens.spacingStaticLg
            Pds.ButtonPure { text: qsTr("Discover more") }
            Pds.ButtonPure { text: qsTr("Active"); active: true }
            Pds.ButtonPure { text: qsTr("Loading"); loading: true }
            Pds.ButtonPure { text: qsTr("Disabled"); disabled: true }
        }
    }

    Component {
        id: textFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticSm
            Pds.Text { text: qsTr("Normal body text") }
            Pds.Text { text: qsTr("Semibold information"); weight: Pds.Text.Semibold; semanticColor: Pds.Text.Info }
            Pds.Text { text: qsTr("Validation error"); semanticColor: Pds.Text.Error }
            Pds.Text {
                Layout.fillWidth: true
                text: qsTr("Long localized body copy wraps without horizontal stretching or arbitrary scaling.")
                hyphens: Pds.Text.Auto
                wrapMode: Text.WordWrap
            }
        }
    }

    Component {
        id: headingFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticSm
            Pds.Heading { text: qsTr("Heading 2XL"); size: Pds.Heading.Size2Xl }
            Pds.Heading { text: qsTr("Heading XL"); size: Pds.Heading.SizeXl }
            Pds.Heading { text: qsTr("Heading medium"); size: Pds.Heading.SizeMd }
        }
    }

    Component {
        id: inputTextFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.InputText {
                Layout.fillWidth: true
                label: qsTr("Name")
                placeholder: qsTr("Enter your name")
                required: true
            }
            Pds.InputText {
                Layout.fillWidth: true
                label: qsTr("Validation")
                value: qsTr("Confirmed")
                state: "success"
                message: qsTr("The value is valid.")
            }
            Pds.InputText {
                Layout.fillWidth: true
                label: qsTr("Read only")
                value: qsTr("Vehicle ID 911")
                readOnly: true
            }
        }
    }

    Component {
        id: inputPasswordFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.InputPassword {
                Layout.fillWidth: true
                label: qsTr("Password")
                value: "precision"
                toggle: true
            }
            Pds.InputPassword {
                Layout.fillWidth: true
                label: qsTr("Invalid password")
                value: "short"
                toggle: true
                state: "error"
                message: qsTr("Use at least eight characters.")
            }
        }
    }

    Component {
        id: switchFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Switch { text: qsTr("Charging notifications"); checked: true; onUpdate: value => checked = value }
            Pds.Switch { text: qsTr("Compact switch"); compact: true; onUpdate: value => checked = value }
            Pds.Switch { text: qsTr("Disabled switch"); disabled: true }
        }
    }

    Component {
        id: checkboxFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Checkbox { text: qsTr("Remember selection"); checked: true }
            Pds.Checkbox { text: qsTr("Partial selection"); indeterminate: true }
            Pds.Checkbox { text: qsTr("Disabled option"); disabled: true }
        }
    }

    Component {
        id: radioGroupFixture
        Pds.RadioGroup {
            label: qsTr("Drive mode")
            value: "sport"
            options: [
                { label: qsTr("Normal"), value: "normal" },
                { label: qsTr("Sport"), value: "sport" },
                { label: qsTr("Individual"), value: "individual" },
                { label: qsTr("Unavailable"), value: "disabled", disabled: true }
            ]
        }
    }

    Component {
        id: selectFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Select {
                Layout.fillWidth: true
                label: qsTr("Vehicle")
                value: "911"
                filter: true
                options: [
                    { text: "718 Cayman", value: "718" },
                    { text: "911 Carrera", value: "911" },
                    { text: "Taycan", value: "taycan" },
                    { text: "Panamera", value: "panamera" }
                ]
            }
            Pds.Select {
                Layout.fillWidth: true
                label: qsTr("Disabled select")
                disabled: true
                options: [{ text: "911 Carrera", value: "911" }]
            }
        }
    }

    Component {
        id: bannerFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Text {
                Layout.fillWidth: true
                text: qsTr("Banner is a controlled overlay; use the action to inspect the real component.")
                wrapMode: Text.WordWrap
            }
            Pds.Button {
                text: qsTr("Show Banner")
                onClicked: window.bannerOpen = true
            }
        }
    }

    Component {
        id: notificationFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.InlineNotification {
                Layout.fillWidth: true
                heading: qsTr("Charging complete")
                description: qsTr("Your vehicle is ready for the next journey.")
                state: "success"
                actionLabel: qsTr("View details")
            }
            Pds.InlineNotification {
                Layout.fillWidth: true
                heading: qsTr("Connection interrupted")
                description: qsTr("Check the cable and try again.")
                state: "warning"
            }
        }
    }

    Component {
        id: tagFixture
        Row {
            spacing: Pds.Tokens.spacingStaticSm
            Pds.Tag { text: qsTr("Primary"); variant: Pds.Tag.Primary }
            Pds.Tag { text: qsTr("Secondary") }
            Pds.Tag { text: qsTr("Success"); variant: Pds.Tag.SuccessFrosted }
            Pds.Tag { text: qsTr("Info"); variant: Pds.Tag.InfoFrosted }
            Pds.Tag { text: qsTr("Compact"); compact: true }
        }
    }

    Component {
        id: spinnerFixture
        Row {
            spacing: Pds.Tokens.spacingStaticXl
            Pds.Spinner { extent: 16 }
            Pds.Spinner { extent: 24 }
            Pds.Spinner { extent: 40 }
            Pds.Button { text: qsTr("Loading"); loading: true }
        }
    }

    Component {
        id: linkFixture
        Row {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Link { text: qsTr("Primary") }
            Pds.Link { text: qsTr("Secondary"); variant: Pds.Link.Secondary }
            Pds.Link { text: qsTr("Compact"); compact: true }
            Pds.Link { text: qsTr("Hidden label"); hideLabel: true }
        }
    }

    Component {
        id: linkPureFixture
        Row {
            spacing: Pds.Tokens.spacingStaticLg
            Pds.LinkPure { text: qsTr("Discover more"); underline: true }
            Pds.LinkPure { text: qsTr("External link"); iconName: "external" }
            Pds.LinkPure { text: qsTr("Active"); active: true }
            Pds.LinkPure { text: qsTr("Small"); size: Pds.LinkPure.SizeXs }
        }
    }

    Component {
        id: tabsFixture
        Pds.Tabs {
            accessibleName: qsTr("Vehicle information")
            items: [
                { label: qsTr("Overview"), content: qsTr("Essential vehicle information and current status.") },
                { label: qsTr("Charging"), content: qsTr("Charging target, power and estimated completion.") },
                { label: qsTr("Range"), content: qsTr("Estimated range based on the current drive profile.") }
            ]
        }
    }

    Component {
        id: modalFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Text {
                Layout.fillWidth: true
                text: qsTr("The real modal manages focus, backdrop dismissal, Escape and restoration.")
                wrapMode: Text.WordWrap
            }
            Pds.Button {
                text: qsTr("Open Modal")
                onClicked: window.modalOpen = true
            }
        }
    }

    Component {
        id: accessibilityFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.InputText { Layout.fillWidth: true; label: qsTr("Accessible name"); description: qsTr("Description announced by assistive technology") }
            Row {
                spacing: Pds.Tokens.spacingStaticMd
                Pds.Button { text: qsTr("Focusable action") }
                Pds.Checkbox { text: qsTr("Named checkbox"); checked: true }
            }
        }
    }

    Component {
        id: rtlFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Text {
                Layout.fillWidth: true
                text: qsTr("برای بررسی چیدمان راست‌به‌چپ، کنترل RTL را در بالای صفحه فعال کنید.")
                alignment: Pds.Text.Start
                wrapMode: Text.WordWrap
            }
            Row {
                spacing: Pds.Tokens.spacingStaticMd
                Pds.ButtonPure { text: qsTr("ادامه") }
                Pds.LinkPure { text: qsTr("اطلاعات بیشتر") }
            }
        }
    }

    Component {
        id: darkFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Text {
                Layout.fillWidth: true
                text: qsTr("Switch to Dark or System in the page header. Every control below resolves semantic tokens.")
                wrapMode: Text.WordWrap
            }
            Row {
                spacing: Pds.Tokens.spacingStaticMd
                Pds.Button { text: qsTr("Primary") }
                Pds.Button { text: qsTr("Secondary"); variant: Pds.Button.Secondary }
                Pds.Tag { text: qsTr("Theme-aware"); variant: Pds.Tag.InfoFrosted }
            }
        }
    }

    Component {
        id: expansionFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Heading {
                Layout.fillWidth: true
                text: qsTr("Fahrzeugkonfigurationen und Benachrichtigungsoptionen")
                size: Pds.Heading.SizeXl
                hyphens: Pds.Heading.Auto
                wrapMode: Text.WordWrap
            }
            Pds.InlineNotification {
                Layout.fillWidth: true
                heading: qsTr("Ausführliche Ladebenachrichtigung")
                description: qsTr("Der gewünschte Ladezustand wird voraussichtlich in ungefähr zwei Stunden und fünfundzwanzig Minuten erreicht.")
                state: "info"
            }
        }
    }

    Component {
        id: fidelityFixture
        ColumnLayout {
            spacing: Pds.Tokens.spacingStaticMd
            Pds.Heading { text: qsTr("Button fidelity gate"); size: Pds.Heading.SizeLg }
            Pds.Text { text: qsTr("Geometry score: 0.99622") }
            Pds.Text { text: qsTr("Pixel similarity: 0.99482") }
            Pds.Text { text: qsTr("Mean RGB delta: 1.321") }
            Pds.Text {
                Layout.fillWidth: true
                text: qsTr("Restricted Porsche Next and icon assets are reported as unavailable when a licensed provider is not configured; they are never replaced with fake glyphs.")
                semanticColor: Pds.Text.ContrastMedium
                wrapMode: Text.WordWrap
            }
        }
    }
}
