import QtQuick as QQ
import QtQuick.Templates as T

T.AbstractButton {
    id: control

    enum ButtonType { Submit, Reset, Button }
    enum AlignLabel { Start, End }
    enum Size {
        Size2Xs, SizeXs, SizeSm, SizeMd, SizeLg, SizeXl,
        Size2Xl, Size3Xl, Size4Xl, Size5Xl, SizeInherit
    }
    enum Color { Primary, ContrastHigher, ContrastHigh, ContrastMedium, Inherit }

    property int buttonType: ButtonPure.Submit
    property string name: ""
    property string value: ""
    property bool disabled: false
    property bool loading: false
    property int size: 2
    property int semanticColor: 0
    property string iconName: "arrow-right"
    property url iconSource: ""
    property bool underline: false
    property bool active: false
    property bool hideLabel: false
    property int alignLabel: 1
    property bool stretch: false
    property string formId: ""
    property string accessibleName: text
    readonly property bool interactive: !disabled && !loading
    readonly property bool accessibilityDisabled: !interactive
    readonly property var foregroundColor: {
        if (disabled)
            return Tokens.colorContrastLow
        switch (semanticColor) {
        case ButtonPure.ContrastHigher: return Tokens.colorContrastHigher
        case ButtonPure.ContrastHigh: return Tokens.colorContrastHigh
        case ButtonPure.ContrastMedium: return Tokens.colorContrastMedium
        case ButtonPure.Inherit: return parent && parent.color !== undefined
                                 ? parent.color : Tokens.colorPrimary
        default: return Tokens.colorPrimary
        }
    }
    readonly property real textPixelSize:
        Typography.typeSize(size, Theme.viewportWidth, 16)

    implicitWidth: stretch ? 160 : contentItem.implicitWidth
    implicitHeight: contentItem.implicitHeight
    activeFocusOnTab: true
    hoverEnabled: false
    padding: 0
    QQ.Keys.priority: QQ.Keys.BeforeItem

    QQ.Accessible.role: QQ.Accessible.Button
    QQ.Accessible.name: accessibleName
    QQ.Accessible.description: loading ? qsTr("Loading") : ""
    QQ.Accessible.focusable: true

    background: QQ.Rectangle {
        x: control.hideLabel ? -2 : -4
        y: -2
        width: control.width + (control.hideLabel ? 4 : 8)
        height: control.height + 4
        radius: control.hideLabel ? Tokens.radiusFull : Tokens.radiusLg
        color: interaction.visualHovered || interaction.visualPressed
               ? Tokens.colorFrostedStrong
               : control.active ? Tokens.colorFrosted : "transparent"
    }

    contentItem: QQ.Row {
        spacing: control.hideLabel ? 0 : Tokens.spacingStaticXs
        layoutDirection: control.alignLabel === ButtonPure.Start
                         ? Qt.RightToLeft : Qt.LeftToRight

        Spinner {
            visible: control.loading
            extent: Typography.lineHeight(control.textPixelSize)
            spinnerColor: control.foregroundColor
            trackColor: Tokens.colorContrastLower
        }

        Icon {
            id: icon
            visible: !control.loading
                     && (control.iconName !== "none"
                         || control.iconSource.toString().length > 0)
                     && !missing
            name: control.iconName
            source: control.iconSource
            size: control.size
            semanticColor: control.semanticColor
            inheritedColor: control.foregroundColor
            disabled: control.disabled
            decorative: true
        }

        QQ.Text {
            visible: !control.hideLabel
            text: control.text
            color: control.foregroundColor
            opacity: control.loading && control.iconName === "none"
                     && control.iconSource.toString().length === 0 ? 0 : 1
            font.family: Typography.family
            font.pixelSize: control.textPixelSize
            font.weight: Tokens.fontWeightNormal
            renderType: QQ.Text.NativeRendering
            font.underline: control.underline
            height: Typography.lineHeight(control.textPixelSize)
            verticalAlignment: QQ.Text.AlignVCenter
            QQ.Accessible.ignored: true
        }
    }

    InteractiveArea {
        id: interaction
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
