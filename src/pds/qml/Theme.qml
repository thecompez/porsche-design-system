pragma Singleton
import QtQuick
import QtQuick.Controls

QtObject {
    enum ColorScheme { Light, Dark, System }

    property int mode: Theme.System
    property string fontFamily: ""
    property real viewportWidth: 1280
    property bool reducedMotion: false
    readonly property bool systemDark:
        Application.styleHints.colorScheme === Qt.Dark
    readonly property bool effectiveDark:
        mode === Theme.Dark || (mode === Theme.System && systemDark)
}
