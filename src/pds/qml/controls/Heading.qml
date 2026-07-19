import QtQuick as QQ

QQ.Text {
    id: root

    enum Size {
        Size2Xs, SizeXs, SizeSm, SizeMd, SizeLg, SizeXl,
        Size2Xl, Size3Xl, Size4Xl, Size5Xl, SizeInherit
    }
    enum Weight { Normal, Semibold, Bold }
    enum Alignment { Start, Center, End, Inherit }
    enum Color { Primary, ContrastHigher, ContrastHigh, ContrastMedium, Inherit }
    enum Hyphens { None, Manual, Auto, Inherit }

    property int size: 6
    property int weight: 0
    property int alignment: 0
    property int semanticColor: 0
    property int hyphens: 0
    property bool ellipsis: false
    property int level: 0
    property var inheritedColor: Tokens.colorPrimary
    property real inheritedPixelSize: 16
    readonly property int effectiveLevel: resolveLevel()
    function resolveLevel() {
        if (level > 0)
            return Math.min(6, level)
        switch (size) {
        case Heading.Size2Xs:
        case Heading.SizeXs:
        case Heading.SizeSm: return 6
        case Heading.SizeMd: return 5
        case Heading.SizeLg: return 4
        case Heading.SizeXl: return 3
        default: return 2
        }
    }
    readonly property real resolvedPixelSize:
        Typography.typeSize(size, Theme.viewportWidth, inheritedPixelSize)
    readonly property bool mirroredLayout: QQ.LayoutMirroring.enabled

    color: {
        switch (semanticColor) {
        case Heading.ContrastHigher: return Tokens.colorContrastHigher
        case Heading.ContrastHigh: return Tokens.colorContrastHigh
        case Heading.ContrastMedium: return Tokens.colorContrastMedium
        case Heading.Inherit: return inheritedColor
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
        if (alignment === Heading.Center)
            return QQ.Text.AlignHCenter
        if (alignment === Heading.End)
            return mirroredLayout ? QQ.Text.AlignLeft : QQ.Text.AlignRight
        if (alignment === Heading.Inherit)
            return QQ.Text.AlignLeft
        return mirroredLayout ? QQ.Text.AlignRight : QQ.Text.AlignLeft
    }
    wrapMode: hyphens === Heading.None ? QQ.Text.NoWrap : QQ.Text.Wrap
    elide: ellipsis ? QQ.Text.ElideRight : QQ.Text.ElideNone
    maximumLineCount: ellipsis ? 1 : 2147483647
    QQ.Accessible.role: QQ.Accessible.Heading
    QQ.Accessible.name: text
    QQ.Accessible.description: qsTr("Heading level %1").arg(effectiveLevel)
}
