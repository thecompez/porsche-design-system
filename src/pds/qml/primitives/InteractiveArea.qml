import QtQuick

MouseArea {
    id: root

    signal activated()
    required property bool interactive
    // Writable so offscreen visual tests can deterministically force :hover.
    property bool visualHovered: containsMouse && interactive
    readonly property bool visualPressed: pressed && interactive

    enabled: true
    hoverEnabled: interactive
    preventStealing: true
    cursorShape: interactive ? Qt.PointingHandCursor : Qt.ForbiddenCursor
    onClicked: if (interactive) activated()
}
