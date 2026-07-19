import QtQuick as QQ

QQ.Rectangle {
    id: root

    enum Direction { Horizontal, Vertical }
    enum Color { ContrastLower, ContrastLow, ContrastMedium, ContrastHigh }

    property int direction: 0
    property int semanticColor: 0

    implicitWidth: direction === Divider.Horizontal ? 160 : 1
    implicitHeight: direction === Divider.Horizontal ? 1 : 160
    color: {
        switch (semanticColor) {
        case Divider.ContrastLow: return Tokens.colorContrastLow
        case Divider.ContrastMedium: return Tokens.colorContrastMedium
        case Divider.ContrastHigh: return Tokens.colorContrastHigh
        default: return Tokens.colorContrastLower
        }
    }
    QQ.Accessible.role: QQ.Accessible.Separator
    QQ.Accessible.name: direction === Divider.Horizontal
                        ? qsTr("Horizontal separator") : qsTr("Vertical separator")
}
