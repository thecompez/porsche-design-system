pragma Singleton
import QtQuick

QtObject {
    readonly property int durationSm: Tokens.durationSm
    readonly property int durationMd: Tokens.durationMd
    readonly property int durationLg: Tokens.durationLg
    readonly property int durationXl: Tokens.durationXl
    readonly property bool reduced: Theme.reducedMotion
    readonly property int easingType: Easing.BezierSpline
    readonly property var easeInOutCurve: [0.25, 0.1, 0.25, 1.0, 1.0, 1.0]
}
