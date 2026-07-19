import QtQuick as QQ
import QtQuick.Templates as T

T.AbstractButton {
    id: control

    enum AlignLabel { Start, End }

    property int alignLabel: 1
    property bool hideLabel: false
    property bool stretch: false
    property bool disabled: false
    property bool loading: false
    property bool compact: false
    property string accessibleName: text
    checkable: false
    readonly property bool interactive: !disabled && !loading
    readonly property real scaleFactor: compact ? 0.64285714 : 1
    readonly property real trackWidth: 48 * scaleFactor
    readonly property real trackHeight: 28 * scaleFactor
    readonly property real thumbExtent: 20 * scaleFactor
    signal update(bool checked)

    implicitWidth: stretch ? 160 : contentItem.implicitWidth
    implicitHeight: Math.max(trackHeight, Tokens.leadingNormal)
    activeFocusOnTab: true
    hoverEnabled: false
    padding: 0
    QQ.Accessible.role: QQ.Accessible.Button
    QQ.Accessible.name: accessibleName
    QQ.Accessible.description: loading ? qsTr("Loading") : ""
    QQ.Accessible.checkable: true
    QQ.Accessible.checked: checked

    contentItem: QQ.Row {
        spacing: control.hideLabel ? 0 : control.compact ? 4 : 8
        layoutDirection: control.alignLabel === Switch.Start
                         ? Qt.RightToLeft : Qt.LeftToRight

        QQ.Rectangle {
            id: track
            width: control.trackWidth
            height: control.trackHeight
            anchors.verticalCenter: parent.verticalCenter
            radius: Tokens.radiusFull
            color: control.checked ? Tokens.colorSuccessFrostedSoft
                                   : Tokens.colorFrostedSoft
            border.width: 1
            border.color: interaction.visualHovered
                          ? control.checked ? Tokens.colorSuccess : Tokens.colorPrimary
                          : control.checked ? Tokens.colorSuccessLow : Tokens.colorContrastLow
            opacity: control.disabled ? 0.4 : 1

            QQ.Rectangle {
                width: control.thumbExtent
                height: width
                radius: Tokens.radiusFull
                color: control.loading ? "transparent"
                                      : control.checked ? Tokens.colorSuccess : Tokens.colorPrimary
                y: (parent.height - height) / 2
                x: {
                    const inset = 3 * control.scaleFactor
                    const off = inset
                    const on = parent.width - width - inset
                    const logical = control.checked ? on : off
                    return control.mirrored ? parent.width - width - logical : logical
                }
                QQ.Behavior on x {
                    QQ.NumberAnimation { duration: Motion.durationSm; easing.type: Motion.easingType }
                }
            }

            Spinner {
                anchors.centerIn: parent
                visible: control.loading
                extent: control.trackHeight - 2
            }
        }

        QQ.Text {
            visible: !control.hideLabel
            text: control.text
            color: Tokens.colorPrimary
            opacity: control.disabled ? 0.4 : 1
            font.family: Typography.family
            font.pixelSize: 16
            renderType: QQ.Text.NativeRendering
            height: Math.max(Tokens.leadingNormal, control.trackHeight)
            verticalAlignment: QQ.Text.AlignVCenter
            QQ.Accessible.ignored: true
        }
    }

    InteractiveArea {
        id: interaction
        anchors.fill: parent
        interactive: control.interactive
        onPressed: control.forceActiveFocus(Qt.MouseFocusReason)
        onActivated: control.update(!control.checked)
    }
    FocusRing { target: control }

    QQ.Keys.onSpacePressed: event => {
        if (interactive && !event.isAutoRepeat)
            update(!checked)
        event.accepted = true
    }
}
