pragma Singleton
import QtQuick

QtObject {
    // The restricted Porsche Next font remains externally injectable.  Arial
    // is deliberately used for general fallback text: stretching Arial Narrow
    // at arbitrary type scales visibly distorts headings and body copy.
    readonly property string fallbackFamily: "Arial"
    readonly property string buttonFallbackFamily: "Arial Narrow"
    readonly property string family:
        Theme.fontFamily.length > 0 ? Theme.fontFamily : fallbackFamily
    readonly property string buttonFamily:
        Theme.fontFamily.length > 0 ? Theme.fontFamily : buttonFallbackFamily
    readonly property bool usingFallback: Theme.fontFamily.length === 0
    // Measured against the locked Porsche Next webfont at 16px on macOS.
    readonly property real fallbackHorizontalScale: 1.295
    readonly property real fallbackLetterSpacing: -0.936
    readonly property real buttonPixelSize: Tokens.typescaleSm
    readonly property int buttonWeight: Tokens.fontWeightNormal
    readonly property real buttonLineHeight: Tokens.leadingNormal

    // Current v4.4.0 size-map order used by every native typography-bearing
    // component: 2xs, xs, sm, md, lg, xl, 2xl, 3xl, 4xl, 5xl, inherit.
    function typeSize(size, viewportWidth, inheritedSize) {
        const width = viewportWidth > 0 ? viewportWidth : 1280
        switch (size) {
        case 0: return 12
        case 1: return 14
        case 2: return 16
        case 3: return Math.max(18.08, Math.min(21.28, width * 0.0021 + 17.28))
        case 4: return Math.max(20.32, Math.min(28.48, width * 0.0051 + 18.56))
        case 5: return Math.max(22.72, Math.min(37.92, width * 0.0094 + 19.68))
        case 6: return Math.max(25.6, Math.min(50.56, width * 0.0156 + 20.64))
        case 7: return Math.max(28.8, Math.min(67.36, width * 0.0241 + 21.12))
        case 8: return Math.max(32.48, Math.min(89.76, width * 0.0358 + 20.96))
        case 9: return Math.max(36.48, Math.min(119.68, width * 0.052 + 19.84))
        case 10: return inheritedSize > 0 ? inheritedSize : 16
        default: return 16
        }
    }

    function lineHeight(pixelSize) {
        return Math.round((6 + pixelSize * 1.125) * 100) / 100
    }

    function spacingFluidSm(viewportWidth) {
        const width = viewportWidth > 0 ? viewportWidth : 1280
        return Math.max(8, Math.min(16, width * 0.005 + 6))
    }

    function fontWeight(weight) {
        switch (weight) {
        case 1: return Tokens.fontWeightSemibold
        case 2: return Tokens.fontWeightBold
        default: return Tokens.fontWeightNormal
        }
    }

    function semanticColor(role, inheritedColor) {
        switch (role) {
        case 1: return Tokens.colorContrastHigher
        case 2: return Tokens.colorContrastHigh
        case 3: return Tokens.colorContrastMedium
        case 4: return Tokens.colorContrastLow
        case 5: return Tokens.colorContrastLower
        case 6: return Tokens.colorSuccess
        case 7: return Tokens.colorWarning
        case 8: return Tokens.colorError
        case 9: return Tokens.colorInfo
        case 10: return inheritedColor || Tokens.colorPrimary
        default: return Tokens.colorPrimary
        }
    }
}
