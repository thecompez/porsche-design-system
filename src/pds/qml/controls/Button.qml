import QtQuick as QQ
import QtQuick.Templates as T

T.Button {
    id: control

    enum Variant { Primary, Secondary }
    enum ButtonType { Submit, Reset, Button }

    property int variant: Button.Primary
    property int buttonType: Button.Submit
    property string name: ""
    property string value: ""
    property bool disabled: false
    property bool loading: false
    property bool compact: false
    property bool hideLabel: false
    property string iconName: ""
    property url iconSource: ""
    property string formId: ""
    property string accessibleName: text
    readonly property bool interactive: !disabled && !loading
    readonly property bool accessibilityDisabled: !interactive

    implicitWidth: contentItem.implicitWidth + leftPadding + rightPadding
    implicitHeight: Typography.buttonLineHeight + topPadding + bottomPadding
    leftPadding: hideLabel ? topPadding : compact ? 16 : 28
    rightPadding: leftPadding
    topPadding: compact ? 6 : 16
    bottomPadding: topPadding
    activeFocusOnTab: true
    hoverEnabled: false
    QQ.Keys.priority: QQ.Keys.BeforeItem

    QQ.Accessible.role: QQ.Accessible.Button
    QQ.Accessible.name: accessibleName
    QQ.Accessible.description: loading ? qsTr("Loading") : ""
    QQ.Accessible.focusable: true

    contentItem: QQ.Item {
        id: content
        implicitWidth: control.hideLabel
                       ? Typography.buttonLineHeight
                       : icon.visible
                         ? Typography.buttonLineHeight + label.calibratedWidth
                         : label.calibratedWidth
        implicitHeight: Typography.buttonLineHeight

        QQ.Image {
            id: icon
            visible: control.iconSource.toString().length > 0
            source: control.iconSource
            width: Typography.buttonLineHeight
            height: width
            x: control.hideLabel ? 0 : -controlGap
            anchors.verticalCenter: parent.verticalCenter
            fillMode: QQ.Image.PreserveAspectFit
            mirror: control.mirrored
            opacity: control.loading ? 0 : control.disabled ? 0.4 : 1
            QQ.Accessible.ignored: true

            QQ.Behavior on opacity {
                QQ.NumberAnimation {
                    duration: Motion.durationSm
                    easing.type: Motion.easingType
                    easing.bezierCurve: Motion.easeInOutCurve
                }
            }
        }

        QQ.Text {
            id: label
            visible: !control.hideLabel
            text: control.text
            x: icon.visible ? Typography.buttonLineHeight : 0
            width: implicitWidth
            readonly property real calibratedWidth:
                implicitWidth * (Typography.usingFallback
                                 ? Typography.fallbackHorizontalScale : 1)
            height: Typography.buttonLineHeight
            color: foregroundColor
            // Button retains the independently measured Arial Narrow metric
            // calibration. Other type scales use the undistorted body fallback.
            font.family: Typography.buttonFamily
            font.pixelSize: Typography.buttonPixelSize
            font.weight: Typography.buttonWeight
            font.letterSpacing: Typography.usingFallback
                                ? Typography.fallbackLetterSpacing : 0
            verticalAlignment: QQ.Text.AlignVCenter
            opacity: control.loading ? 0 : control.disabled ? 0.4 : 1
            QQ.Accessible.ignored: true
            transform: QQ.Scale {
                origin.x: 0
                origin.y: label.height / 2
                xScale: Typography.usingFallback
                        ? Typography.fallbackHorizontalScale : 1
            }

            QQ.Behavior on opacity {
                QQ.NumberAnimation {
                    duration: Motion.durationSm
                    easing.type: Motion.easingType
                    easing.bezierCurve: Motion.easeInOutCurve
                }
            }
        }

        Spinner {
            anchors.centerIn: parent
            visible: control.loading
            spinnerColor: foregroundColor
            trackColor: Tokens.colorContrastLower
            extent: Typography.buttonLineHeight
        }
    }

    background: QQ.Rectangle {
        id: backgroundRect
        radius: control.hideLabel ? Tokens.radiusFull
                                  : control.compact ? Tokens.radiusLg : Tokens.radiusXl
        color: {
            if (control.variant === Button.Primary) {
                return interaction.visualHovered || interaction.visualPressed
                       ? Tokens.colorContrastHigh : Tokens.colorPrimary
            }
            return interaction.visualHovered || interaction.visualPressed
                   ? Tokens.colorFrosted : Tokens.colorFrostedStrong
        }
        opacity: control.disabled ? 0.4 : 1

        QQ.Behavior on color {
            QQ.ColorAnimation {
                duration: Motion.durationSm
                easing.type: Motion.easingType
                easing.bezierCurve: Motion.easeInOutCurve
            }
        }

    }

    readonly property real controlGap: compact ? 4 : 8
    readonly property var foregroundColor:
        variant === Button.Primary ? Tokens.colorCanvas : Tokens.colorPrimary

    InteractiveArea {
        id: interaction
        objectName: "_buttonInteractionArea"
        anchors.fill: parent
        interactive: control.interactive
        onPressed: control.forceActiveFocus(Qt.MouseFocusReason)
        onActivated: control.clicked()
    }

    FocusRing { target: control }

    QQ.Keys.onSpacePressed: event => {
        if (interactive && !event.isAutoRepeat)
            clicked()
        event.accepted = true
    }
    QQ.Keys.onReturnPressed: event => {
        if (interactive && !event.isAutoRepeat)
            clicked()
        event.accepted = true
    }
    QQ.Keys.onEnterPressed: event => {
        if (interactive && !event.isAutoRepeat)
            clicked()
        event.accepted = true
    }
}
