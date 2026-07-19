import QtQuick
import QtQuick.Controls as QQC
import QtQuick.Layouts
import Pds.Native as Pds

QQC.ApplicationWindow {
    id: window
    width: 1080
    height: 760
    visible: true
    title: qsTr("PDS v4 Component Lab")
    color: Pds.Tokens.colorCanvas
    font.family: Pds.Typography.family
    font.pixelSize: Pds.Tokens.typescaleSm
    onWidthChanged: Pds.Theme.viewportWidth = width

    property bool expandedText: false
    property bool modalOpen: false
    property bool bannerOpen: false

    Component.onCompleted: {
        // Diagnostic app consumes the same externally hosted, version-locked
        // icon filenames as the official configurator without packaging them.
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

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Pds.Tokens.spacingStaticLg
        spacing: Pds.Tokens.spacingStaticLg

        ColumnLayout {
            Layout.fillWidth: true
            spacing: Pds.Tokens.spacingStaticSm

            Pds.Text {
                Layout.fillWidth: true
                text: qsTr("Native component lab · locked upstream v4.4.0")
                weight: Pds.Text.Semibold
            }

            RowLayout {
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
                    text: window.LayoutMirroring.enabled ? qsTr("LTR") : qsTr("RTL")
                    compact: true
                    variant: Pds.Button.Secondary
                    onClicked: window.LayoutMirroring.enabled = !window.LayoutMirroring.enabled
                }
                Pds.Button {
                    text: qsTr("Expand text")
                    compact: true
                    variant: Pds.Button.Secondary
                    onClicked: window.expandedText = !window.expandedText
                }
                Pds.Button {
                    text: Pds.Theme.reducedMotion ? qsTr("Motion on")
                                                  : qsTr("Reduce motion")
                    compact: true
                    variant: Pds.Button.Secondary
                    onClicked: Pds.Theme.reducedMotion = !Pds.Theme.reducedMotion
                }

                Item { Layout.fillWidth: true }
            }
        }

        QQC.ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: availableWidth

            ColumnLayout {
                width: parent.width
                spacing: Pds.Tokens.spacingStaticLg

                Pds.Heading {
                    Layout.fillWidth: true
                    text: qsTr("Feedback, status and composites")
                    size: Pds.Heading.SizeXl
                }

                Pds.InlineNotification {
                    Layout.fillWidth: true
                    heading: qsTr("Charging status")
                    description: window.expandedText
                                 ? qsTr("Fahrzeug wird geladen. Der gewünschte Ladezustand wird in ungefähr zwei Stunden erreicht.")
                                 : qsTr("Charging target will be reached in two hours.")
                    state: "info"
                    actionLabel: qsTr("Details")
                }

                GridLayout {
                    Layout.fillWidth: true
                    columns: 4
                    rowSpacing: Pds.Tokens.spacingStaticSm
                    columnSpacing: Pds.Tokens.spacingStaticSm

                    Pds.Tag { text: qsTr("Primary"); variant: Pds.Tag.Primary }
                    Pds.Tag { text: qsTr("Secondary") }
                    Pds.Tag { text: qsTr("Success"); variant: Pds.Tag.SuccessFrosted }
                    Pds.Tag { text: qsTr("Compact"); compact: true }
                }

                Pds.Tabs {
                    Layout.fillWidth: true
                    accessibleName: qsTr("Diagnostic panels")
                    items: [
                        { label: qsTr("States"), content: qsTr("Default, hover, focus and disabled states.") },
                        { label: qsTr("RTL"), content: qsTr("Directional and mirrored layout fixture.") },
                        { label: qsTr("A11y"), content: qsTr("Roles, names and keyboard behavior.") }
                    ]
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: Pds.Tokens.spacingStaticMd
                    Pds.Button {
                        text: qsTr("Open Modal")
                        onClicked: window.modalOpen = true
                    }
                    Pds.Button {
                        text: qsTr("Show Banner")
                        variant: Pds.Button.Secondary
                        onClicked: window.bannerOpen = true
                    }
                }

                Pds.Heading {
                    Layout.fillWidth: true
                    text: qsTr("Foundations and links")
                    size: Pds.Heading.SizeXl
                }

                Pds.Text {
                    Layout.fillWidth: true
                    text: window.expandedText
                          ? qsTr("German expansion fixture: Fahrzeugeinstellungen und Benachrichtigungsoptionen")
                          : qsTr("Inspect typography, semantic color, icon injection, direction and link states.")
                    hyphens: Pds.Text.Auto
                    wrapMode: Text.WordWrap
                }

                Pds.Divider { Layout.fillWidth: true }

                GridLayout {
                    Layout.fillWidth: true
                    columns: 3
                    rowSpacing: Pds.Tokens.spacingStaticMd
                    columnSpacing: Pds.Tokens.spacingStaticMd

                    Pds.Icon { accessibleName: qsTr("Injected icon fixture") }
                    Pds.Icon {
                        size: Pds.Icon.SizeLg
                        semanticColor: Pds.Icon.Success
                        accessibleName: qsTr("Large success icon")
                    }
                    Pds.Icon {
                        name: "arrow-left"
                        accessibleName: qsTr("Directional icon")
                    }

                    Pds.Text { text: qsTr("Normal body") }
                    Pds.Text {
                        text: qsTr("Semibold information")
                        weight: Pds.Text.Semibold
                        semanticColor: Pds.Text.Info
                    }
                    Pds.Text {
                        text: qsTr("Error message")
                        semanticColor: Pds.Text.Error
                    }

                    Pds.Link { text: qsTr("Primary link") }
                    Pds.Link {
                        text: qsTr("Secondary link")
                        variant: Pds.Link.Secondary
                    }
                    Pds.LinkPure { text: qsTr("Pure link") }

                    Pds.ButtonPure { text: qsTr("Pure button") }
                    Pds.ButtonPure {
                        text: qsTr("Active pure")
                        active: true
                    }
                    Pds.ButtonPure {
                        text: qsTr("Loading pure")
                        loading: true
                    }
                }

                Pds.Heading {
                    Layout.fillWidth: true
                    text: qsTr("Form controls")
                    size: Pds.Heading.SizeXl
                }

                GridLayout {
                    Layout.fillWidth: true
                    columns: 2
                    rowSpacing: Pds.Tokens.spacingStaticMd
                    columnSpacing: Pds.Tokens.spacingStaticMd

                    Pds.InputText {
                        Layout.fillWidth: true
                        label: qsTr("Input Text")
                        description: qsTr("Default, focused, validation and counter fixture")
                        placeholder: qsTr("Enter a value")
                        counter: true
                        maximumLength: 40
                    }
                    Pds.InputText {
                        Layout.fillWidth: true
                        label: qsTr("Invalid Input")
                        value: qsTr("Invalid value")
                        state: "error"
                        message: qsTr("Please check this value.")
                    }
                    Pds.InputPassword {
                        Layout.fillWidth: true
                        label: qsTr("Password")
                        value: "precision"
                        toggle: true
                    }
                    Pds.InputText {
                        Layout.fillWidth: true
                        label: qsTr("Read only")
                        value: qsTr("Vehicle ID 911")
                        readOnly: true
                    }
                    Pds.Switch {
                        text: qsTr("Enable notifications")
                        checked: true
                        onUpdate: value => checked = value
                    }
                    Pds.Switch {
                        text: qsTr("Compact switch")
                        compact: true
                        onUpdate: value => checked = value
                    }
                    Pds.Checkbox {
                        text: qsTr("Accept terms")
                        checked: true
                    }
                    Pds.Checkbox {
                        text: qsTr("Partial selection")
                        indeterminate: true
                    }
                    Pds.RadioGroup {
                        Layout.fillWidth: true
                        label: qsTr("Drive mode")
                        value: "normal"
                        options: [
                            { label: qsTr("Normal"), value: "normal" },
                            { label: qsTr("Sport"), value: "sport" },
                            { label: qsTr("Individual"), value: "individual" }
                        ]
                    }
                    Pds.Select {
                        Layout.fillWidth: true
                        label: qsTr("Model")
                        value: "911"
                        filter: true
                        options: [
                            { text: "718 Cayman", value: "718" },
                            { text: "911 Carrera", value: "911" },
                            { text: "Taycan", value: "taycan" },
                            { text: "Panamera", value: "panamera" }
                        ]
                    }
                }

                Pds.Heading {
                    Layout.fillWidth: true
                    text: qsTr("Button regression matrix")
                    size: Pds.Heading.SizeXl
                }

                GridLayout {
                    Layout.fillWidth: true
                    columns: 2
                    rowSpacing: Pds.Tokens.spacingStaticMd
                    columnSpacing: Pds.Tokens.spacingStaticMd

                    Pds.Button { text: qsTr("Primary") }
                    Pds.Button {
                        text: qsTr("Secondary")
                        variant: Pds.Button.Secondary
                    }
                    Pds.Button { text: qsTr("Compact"); compact: true }
                    Pds.Button {
                        text: qsTr("Compact secondary")
                        compact: true
                        variant: Pds.Button.Secondary
                    }
                    Pds.Button { text: qsTr("Disabled"); disabled: true }
                    Pds.Button { text: qsTr("Loading"); loading: true }
                }
            }
        }
    }

    Pds.Modal {
        open: window.modalOpen
        heading: qsTr("Modal diagnostic fixture")
        description: qsTr("Verify focus trapping, Escape dismissal, backdrop behavior, RTL and reduced motion.")
        onDismiss: window.modalOpen = false
    }

    Pds.Banner {
        open: window.bannerOpen
        heading: qsTr("Banner diagnostic fixture")
        description: qsTr("Information, success, warning and error states use semantic tokens.")
        onDismiss: window.bannerOpen = false
    }
}
