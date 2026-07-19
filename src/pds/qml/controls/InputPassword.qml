import QtQuick as QQ

InputText {
    id: control

    property bool toggle: false
    property bool showPassword: false

    echoMode: showPassword ? QQ.TextInput.Normal : QQ.TextInput.Password
    trailing: toggle ? toggleComponent : null
    inputMethodHints: Qt.ImhSensitiveData | Qt.ImhNoPredictiveText

    function togglePasswordVisibility() {
        if (disabled)
            return
        showPassword = !showPassword
        forceEditorFocus()
    }

    QQ.Component {
        id: toggleComponent
        ButtonPure {
            objectName: "_passwordToggle"
            text: qsTr("Toggle password visibility")
            hideLabel: true
            iconName: control.showPassword ? "view-off" : "view"
            disabled: control.disabled
            accessibleName: qsTr("Toggle password visibility")
            onClicked: control.togglePasswordVisibility()
        }
    }
}
