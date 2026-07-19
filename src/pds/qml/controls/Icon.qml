import QtQuick as QQ
import QtQuick.Effects

QQ.Item {
    id: root

    enum Size {
        Size2Xs, SizeXs, SizeSm, SizeMd, SizeLg, SizeXl,
        Size2Xl, Size3Xl, Size4Xl, Size5Xl, SizeInherit
    }
    enum Color {
        Primary, ContrastHigher, ContrastHigh, ContrastMedium,
        ContrastLow, ContrastLower, Success, Warning, Error, Info, Inherit
    }

    property string name: "arrow-right"
    property url source: ""
    property int size: 2
    property int semanticColor: 0
    property var inheritedColor: Tokens.colorPrimary
    property real inheritedPixelSize: 16
    property string accessibleName: ""
    property bool decorative: accessibleName.length === 0
    property bool disabled: false

    readonly property url resolvedSource:
        source.toString().length > 0 ? source : IconProvider.resolve(name)
    readonly property bool missing:
        resolvedSource.toString().length === 0 || image.status === QQ.Image.Error
    readonly property bool directional: [
        "arrow-compact-left", "arrow-compact-right", "arrow-double-left",
        "arrow-double-right", "arrow-first", "arrow-head-left",
        "arrow-head-right", "arrow-last", "arrow-left", "arrow-right",
        "chart", "chat", "copy", "external", "increase", "list", "logout",
        "return", "send"
    ].indexOf(name) !== -1 && source.toString().length === 0
    readonly property bool mirroredLayout: QQ.LayoutMirroring.enabled
    readonly property real pixelSize:
        Typography.typeSize(size, Theme.viewportWidth, inheritedPixelSize)
    readonly property real extent:
        Math.round(Typography.lineHeight(pixelSize))
    readonly property real devicePixelRatio:
        root.window ? root.window.devicePixelRatio : 1
    readonly property var resolvedColor:
        Typography.semanticColor(semanticColor, inheritedColor)

    implicitWidth: extent
    implicitHeight: extent
    opacity: disabled ? 0.4 : 1

    QQ.Accessible.role: QQ.Accessible.Graphic
    QQ.Accessible.name: accessibleName
    QQ.Accessible.ignored: decorative

    QQ.Image {
        id: image
        anchors.fill: parent
        source: root.resolvedSource
        sourceSize: Qt.size(
                        Math.max(1, Math.ceil(width * root.devicePixelRatio)),
                        Math.max(1, Math.ceil(height * root.devicePixelRatio)))
        fillMode: QQ.Image.PreserveAspectFit
        mirror: root.directional && root.mirroredLayout
        asynchronous: true
        cache: true
        smooth: true
        visible: !root.missing
        QQ.Accessible.ignored: true
        layer.enabled: visible
        layer.effect: MultiEffect {
            colorization: 1
            colorizationColor: root.resolvedColor
        }
    }
}
