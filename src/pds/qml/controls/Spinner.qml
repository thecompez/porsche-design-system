import QtQuick
import QtQuick.Shapes

Item {
    id: root

    property color spinnerColor: Tokens.colorPrimary
    property color trackColor: Tokens.colorContrastLower
    property real extent: Tokens.leadingNormal

    implicitWidth: extent
    implicitHeight: extent
    Accessible.role: Accessible.AlertMessage
    Accessible.name: qsTr("Loading")

    Shape {
        anchors.fill: parent
        layer.enabled: false

        ShapePath {
            strokeColor: root.trackColor
            strokeWidth: root.extent * 1.5 / 32
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            startX: root.width / 2
            startY: root.height * 5 / 32
            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root.width * 11 / 32
                radiusY: root.height * 11 / 32
                startAngle: -90
                sweepAngle: 360
            }
        }

        ShapePath {
            strokeColor: root.spinnerColor
            strokeWidth: root.extent * 1.5 / 32
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            startX: root.width / 2
            startY: root.height * 5 / 32
            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root.width * 11 / 32
                radiusY: root.height * 11 / 32
                startAngle: -90
                sweepAngle: 235
            }
        }
    }

    RotationAnimator on rotation {
        from: 0
        to: 360
        duration: Motion.durationXl
        loops: Animation.Infinite
        running: root.visible
    }
}
