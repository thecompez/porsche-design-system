import QtQuick

Rectangle {
    id: root

    required property Item target
    property real semanticOffset: 2
    readonly property bool keyboardFocus:
        target.activeFocus
        && target.focusReason !== Qt.MouseFocusReason
        && target.focusReason !== Qt.PopupFocusReason

    anchors.fill: target
    anchors.margins: -(semanticOffset + border.width)
    radius: target.background && target.background.radius !== undefined
            ? target.background.radius + semanticOffset + border.width
            : Tokens.radiusXl + semanticOffset + border.width
    color: "transparent"
    border.width: 2
    border.color: Tokens.colorFocus
    visible: keyboardFocus
    z: 100
}
