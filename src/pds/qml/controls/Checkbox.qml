import QtQuick as QQ
import QtQuick.Shapes
import QtQuick.Templates as T

T.AbstractButton {
    id: control

    property string name: ""
    property string value: "on"
    property string formId: ""
    property bool required: false
    property bool disabled: false
    property bool indeterminate: false
    property string message: ""
    property bool hideLabel: false
    property bool loading: false
    property bool compact: false
    property string accessibleName: text
    readonly property bool invalid: state === "error"
    readonly property bool successful: state === "success"
    readonly property bool interactive: !disabled && !loading
    readonly property real indicatorExtent: compact ? 18 : 28
    signal change(bool checked)

    state: "none"
    checkable: false
    implicitWidth: contentItem.implicitWidth
    implicitHeight: contentItem.implicitHeight + (messageLabel.visible
                                                  ? Tokens.spacingStaticXs
                                                    + messageLabel.implicitHeight : 0)
    activeFocusOnTab: true
    hoverEnabled: false
    padding: 0
    QQ.Accessible.role: QQ.Accessible.CheckBox
    QQ.Accessible.name: accessibleName
    QQ.Accessible.description: message
    QQ.Accessible.checkable: true
    QQ.Accessible.checked: checked

    contentItem: QQ.Row {
        spacing: control.hideLabel ? 0 : control.compact ? 4 : 8

        QQ.Rectangle {
            id: indicator
            width: control.indicatorExtent
            height: width
            radius: control.compact ? Tokens.radiusMd : Tokens.radiusLg
            color: control.checked || control.indeterminate
                   ? control.invalid ? Tokens.colorError
                     : control.successful ? Tokens.colorSuccess : Tokens.colorPrimary
                   : control.invalid ? Tokens.colorErrorFrostedSoft
                     : control.successful ? Tokens.colorSuccessFrostedSoft : Tokens.colorFrosted
            border.width: 1
            border.color: interaction.visualHovered
                          ? control.invalid ? Tokens.colorError
                            : control.successful ? Tokens.colorSuccess : Tokens.colorPrimary
                          : control.invalid ? Tokens.colorError
                            : control.successful ? Tokens.colorSuccess : Tokens.colorContrastLower
            opacity: control.disabled ? 0.4 : 1

            Shape {
                anchors.fill: parent
                visible: control.checked && !control.indeterminate && !control.loading
                ShapePath {
                    strokeColor: Tokens.colorCanvas
                    strokeWidth: Math.max(1.5, control.indicatorExtent / 10)
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin
                    startX: indicator.width * 0.25
                    startY: indicator.height * 0.52
                    QQ.PathLine { x: indicator.width * 0.43; y: indicator.height * 0.7 }
                    QQ.PathLine { x: indicator.width * 0.76; y: indicator.height * 0.31 }
                }
            }

            QQ.Rectangle {
                visible: control.indeterminate && !control.loading
                width: parent.width * 0.5
                height: Math.max(2, parent.height / 10)
                radius: height / 2
                anchors.centerIn: parent
                color: Tokens.colorCanvas
            }

            Spinner {
                anchors.centerIn: parent
                visible: control.loading
                extent: parent.width - 2
                spinnerColor: control.checked ? Tokens.colorCanvas : Tokens.colorPrimary
            }
        }

        QQ.Text {
            visible: !control.hideLabel
            text: control.text + (control.required ? " *" : "")
            color: Tokens.colorPrimary
            opacity: control.disabled ? 0.4 : 1
            font.family: Typography.family
            font.pixelSize: 16
            renderType: QQ.Text.NativeRendering
            height: Math.max(Tokens.leadingNormal, control.indicatorExtent)
            verticalAlignment: QQ.Text.AlignVCenter
            QQ.Accessible.ignored: true
        }
    }

    Text {
        id: messageLabel
        anchors.top: contentItem.bottom
        anchors.topMargin: visible ? Tokens.spacingStaticXs : 0
        anchors.left: contentItem.left
        visible: control.message.length > 0 && control.state !== "none"
        text: control.message
            semanticColor: control.invalid ? 6 : 4
    }

    InteractiveArea {
        id: interaction
        anchors.fill: contentItem
        interactive: control.interactive
        onPressed: control.forceActiveFocus(Qt.MouseFocusReason)
        onActivated: {
            control.checked = !control.checked
            control.indeterminate = false
            control.change(control.checked)
        }
    }
    FocusRing { target: control }

    QQ.Keys.onSpacePressed: event => {
        if (interactive && !event.isAutoRepeat) {
            checked = !checked
            indeterminate = false
            change(checked)
        }
        event.accepted = true
    }
}
