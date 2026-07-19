import QtQuick as QQ
import QtQuick.Layouts
import QtQuick.Templates as T

T.Control {
    id: control

    property string heading: ""
    property int headingLevel: 5
    property string description: ""
    property bool dismissButton: true
    property string actionLabel: ""
    property bool actionLoading: false
    property string actionIcon: "arrow-right"
    property QQ.Component content
    readonly property bool assertive: state === "warning" || state === "error"
    readonly property real semanticPadding:
        Tokens.spacingStaticSm + Typography.spacingFluidSm(Theme.viewportWidth)
    readonly property var accentColor: {
        switch (state) {
        case "success": return Tokens.colorSuccess
        case "warning": return Tokens.colorWarning
        case "error": return Tokens.colorError
        default: return Tokens.colorInfo
        }
    }
    readonly property var panelColor: {
        switch (state) {
        case "success": return Tokens.colorSuccessFrosted
        case "warning": return Tokens.colorWarningFrosted
        case "error": return Tokens.colorErrorFrosted
        default: return Tokens.colorInfoFrosted
        }
    }
    signal dismiss()
    signal action()

    state: "info"
    padding: semanticPadding
    implicitWidth: Math.max(320, contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: contentItem.implicitHeight + topPadding + bottomPadding
    QQ.Accessible.role: assertive ? QQ.Accessible.AlertMessage : QQ.Accessible.StaticText
    QQ.Accessible.name: heading
    QQ.Accessible.description: description

    background: QQ.Rectangle {
        color: control.panelColor
        radius: Tokens.radius2Xl
    }

    contentItem: GridLayout {
        columns: 4
        columnSpacing: Tokens.spacingStaticSm
        rowSpacing: Tokens.spacingStaticMd

        Icon {
            id: statusIcon
            visible: !missing
            Layout.row: 0
            Layout.column: 0
            Layout.alignment: control.heading.length > 0
                              ? Qt.AlignVCenter : Qt.AlignTop
            name: {
                switch (control.state) {
                case "success": return "success"
                case "warning": return "warning"
                case "error": return "error"
                default: return "information"
                }
            }
            source: IconProvider.resolve(name)
            semanticColor: {
                switch (control.state) {
                case "success": return Icon.Success
                case "warning": return Icon.Warning
                case "error": return Icon.Error
                default: return Icon.Info
                }
            }
            accessibleName: qsTr("%1 notification").arg(control.state)
        }

        QQ.Column {
            Layout.row: 0
            Layout.column: 1
            Layout.fillWidth: true
            spacing: Tokens.spacingStaticXs

            Heading {
                width: parent.width
                visible: control.heading.length > 0
                text: control.heading
                level: control.headingLevel
                size: 2
                weight: 1
                hyphens: 2
                wrapMode: QQ.Text.WordWrap
            }

            Text {
                width: parent.width
                visible: control.description.length > 0 && !contentLoader.active
                text: control.description
                hyphens: 2
                wrapMode: QQ.Text.WordWrap
            }

            QQ.Loader {
                id: contentLoader
                width: parent.width
                sourceComponent: control.content
            }
        }

        ButtonPure {
            Layout.row: 0
            Layout.column: 2
            Layout.alignment: Qt.AlignTop
            visible: control.actionLabel.length > 0
            text: control.actionLabel
            iconName: control.actionIcon
            loading: control.actionLoading
            onClicked: control.action()
        }

        ButtonPure {
            objectName: "_notificationDismiss"
            Layout.row: 0
            Layout.column: 3
            Layout.alignment: Qt.AlignTop
            visible: control.dismissButton
            text: qsTr("Close notification")
            hideLabel: true
            iconName: "close"
            semanticColor: ButtonPure.Primary
            onClicked: control.dismiss()
        }
    }
}
