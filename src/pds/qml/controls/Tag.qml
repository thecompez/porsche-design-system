import QtQuick as QQ
import QtQuick.Templates as T

T.Control {
    id: control

    enum Variant {
        Primary, Secondary, Info, InfoFrosted, Warning,
        WarningFrosted, Success, SuccessFrosted, Error, ErrorFrosted
    }

    property int variant: Tag.Secondary
    property string text: ""
    property string iconName: "none"
    property url iconSource: ""
    property bool compact: false
    property string accessibleName: text
    readonly property bool hasIcon:
        iconName !== "none" || iconSource.toString().length > 0
    readonly property var foregroundColor:
        [Tag.Primary, Tag.Info, Tag.Warning, Tag.Success, Tag.Error]
        .indexOf(variant) !== -1 ? Tokens.colorCanvas : Tokens.colorPrimary
    readonly property var normalBackground: {
        switch (variant) {
        case Tag.Primary: return Tokens.colorPrimary
        case Tag.Info: return Tokens.colorInfo
        case Tag.InfoFrosted: return Tokens.colorInfoFrosted
        case Tag.Warning: return Tokens.colorWarning
        case Tag.WarningFrosted: return Tokens.colorWarningFrosted
        case Tag.Success: return Tokens.colorSuccess
        case Tag.SuccessFrosted: return Tokens.colorSuccessFrosted
        case Tag.Error: return Tokens.colorError
        case Tag.ErrorFrosted: return Tokens.colorErrorFrosted
        default: return Tokens.colorFrostedStrong
        }
    }

    implicitWidth: contentItem.implicitWidth + leftPadding + rightPadding
    implicitHeight: Tokens.leadingNormal + topPadding + bottomPadding
    leftPadding: 12
    rightPadding: leftPadding
    topPadding: compact ? 2 : 4
    bottomPadding: topPadding
    QQ.Accessible.role: QQ.Accessible.StaticText
    QQ.Accessible.name: accessibleName

    background: QQ.Rectangle {
        radius: control.height / 2
        color: control.normalBackground
        opacity: control.enabled ? 1 : 0.4
    }

    contentItem: QQ.Row {
        spacing: control.hasIcon ? 2 : 0
        Icon {
            visible: control.hasIcon
            name: control.iconName
            source: control.iconSource
            size: Icon.SizeXs
            inheritedColor: control.foregroundColor
            semanticColor: Icon.Inherit
            decorative: true
        }
        QQ.Text {
            text: control.text
            color: control.foregroundColor
            font.family: Typography.family
            font.pixelSize: 14
            font.weight: Tokens.fontWeightNormal
            renderType: QQ.Text.NativeRendering
            height: Tokens.leadingNormal
            verticalAlignment: QQ.Text.AlignVCenter
            QQ.Accessible.ignored: true
        }
    }
}
