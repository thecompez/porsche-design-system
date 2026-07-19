import QtQuick as QQ

QQ.Text {
    id: root

    enum Size {
        Size2Xs, SizeXs, SizeSm, SizeMd, SizeLg, SizeXl,
        Size2Xl, Size3Xl, Size4Xl, Size5Xl, SizeInherit
    }
    enum Weight { Normal, Semibold, Bold }
    enum Alignment { Start, Center, End, Inherit }
    enum Color {
        Primary, ContrastHigher, ContrastHigh, ContrastMedium,
        Success, Warning, Error, Info, Inherit
    }
    enum Hyphens { None, Manual, Auto, Inherit }
    enum SemanticRole {
        Paragraph, Span, Division, Address, Blockquote, Figcaption,
        Citation, Time, Legend
    }

    property int size: 2
    property int weight: 0
    property int alignment: 0
    property int semanticColor: 0
    property int hyphens: 3
    property int semanticRole: 0
    property bool ellipsis: false
    property var inheritedColor: Tokens.colorPrimary
    property real inheritedPixelSize: 16
    readonly property real resolvedPixelSize:
        Typography.typeSize(size, Theme.viewportWidth, inheritedPixelSize)
    readonly property bool mirroredLayout: QQ.LayoutMirroring.enabled

    color: {
        switch (semanticColor) {
        case Text.ContrastHigher: return Tokens.colorContrastHigher
        case Text.ContrastHigh: return Tokens.colorContrastHigh
        case Text.ContrastMedium: return Tokens.colorContrastMedium
        case Text.Success: return Tokens.colorSuccess
        case Text.Warning: return Tokens.colorWarning
        case Text.Error: return Tokens.colorError
        case Text.Info: return Tokens.colorInfo
        case Text.Inherit: return inheritedColor
        default: return Tokens.colorPrimary
        }
    }
    font.family: Typography.family
    font.pixelSize: resolvedPixelSize
    font.weight: Typography.fontWeight(weight)
    renderType: QQ.Text.NativeRendering
    lineHeightMode: QQ.Text.FixedHeight
    lineHeight: Typography.lineHeight(resolvedPixelSize)
    horizontalAlignment: {
        if (alignment === Text.Center)
            return QQ.Text.AlignHCenter
        if (alignment === Text.End)
            return mirroredLayout ? QQ.Text.AlignLeft : QQ.Text.AlignRight
        if (alignment === Text.Inherit)
            return QQ.Text.AlignLeft
        return mirroredLayout ? QQ.Text.AlignRight : QQ.Text.AlignLeft
    }
    wrapMode: hyphens === Text.None ? QQ.Text.NoWrap : QQ.Text.Wrap
    elide: ellipsis ? QQ.Text.ElideRight : QQ.Text.ElideNone
    maximumLineCount: ellipsis ? 1 : 2147483647
    QQ.Accessible.role: QQ.Accessible.StaticText
    QQ.Accessible.name: text
}
