import QtQuick as QQ
import QtQuick.Templates as T

T.AbstractButton {
    id: control

    enum AlignLabel { Start, End }
    enum Size {
        Size2Xs, SizeXs, SizeSm, SizeMd, SizeLg, SizeXl,
        Size2Xl, Size3Xl, Size4Xl, Size5Xl, SizeInherit
    }
    enum Color { Primary, ContrastHigher, ContrastHigh, ContrastMedium, Inherit }

    property int alignLabel: 1
    property bool stretch: false
    property int size: 2
    property int semanticColor: 0
    property string iconName: "arrow-right"
    property url iconSource: ""
    property bool underline: false
    property url href: ""
    property bool active: false
    property bool hideLabel: false
    property string target: "_self"
    property string download: ""
    property string rel: ""
    property string accessibleName: text
    property string accessibleDescription: ""
    signal activated(url href)

    readonly property var foregroundColor: {
        switch (semanticColor) {
        case LinkPure.ContrastHigher: return Tokens.colorContrastHigher
        case LinkPure.ContrastHigh: return Tokens.colorContrastHigh
        case LinkPure.ContrastMedium: return Tokens.colorContrastMedium
        case LinkPure.Inherit: return parent && parent.color !== undefined
                               ? parent.color : Tokens.colorPrimary
        default: return Tokens.colorPrimary
        }
    }
    readonly property real textPixelSize:
        Typography.typeSize(size, Theme.viewportWidth, 16)
    readonly property bool interactive: enabled

    implicitWidth: stretch ? 160 : contentItem.implicitWidth
    implicitHeight: contentItem.implicitHeight
    activeFocusOnTab: true
    hoverEnabled: true
    padding: 0

    QQ.Accessible.role: QQ.Accessible.Link
    QQ.Accessible.name: accessibleName
    QQ.Accessible.description: accessibleDescription
    QQ.Accessible.focusable: true

    background: QQ.Rectangle {
        x: control.hideLabel ? -2 : -4
        y: -2
        width: control.width + (control.hideLabel ? 4 : 8)
        height: control.height + 4
        radius: control.hideLabel ? Tokens.radiusFull : Tokens.radiusLg
        color: control.down || control.hovered
               ? Tokens.colorFrostedStrong
               : control.active ? Tokens.colorFrosted : "transparent"
    }

    contentItem: QQ.Row {
        id: row
        spacing: control.hideLabel ? 0 : Tokens.spacingStaticXs
        layoutDirection: control.alignLabel === LinkPure.Start
                         ? Qt.RightToLeft : Qt.LeftToRight

        Icon {
            id: icon
            visible: (control.iconName !== "none"
                      || control.iconSource.toString().length > 0)
                     && !missing
            name: control.iconName
            source: control.iconSource
            size: control.size
            semanticColor: control.semanticColor
            inheritedColor: control.foregroundColor
            decorative: true
        }

        QQ.Text {
            visible: !control.hideLabel
            text: control.text
            color: control.foregroundColor
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

    FocusRing { target: control }

    onClicked: {
        activated(href)
        if (href.toString().length > 0)
            Qt.openUrlExternally(href)
    }
}
