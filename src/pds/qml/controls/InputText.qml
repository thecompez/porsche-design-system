import QtQuick as QQ

QQ.Item {
    id: control

    property string label: ""
    property string description: ""
    property bool compact: false
    property string name: ""
    property alias value: editor.text
    property string autoComplete: ""
    property bool readOnly: false
    property string formId: ""
    property int maximumLength: 32767
    property int minimumLength: 0
    property string placeholder: ""
    property bool disabled: false
    property bool required: false
    property bool loading: false
    // Uses Item.state directly with the exact upstream values:
    // "none", "success", and "error".
    state: "none"
    property string message: ""
    property bool hideLabel: false
    property bool counter: false
    property bool spellCheck: false
    property int echoMode: QQ.TextInput.Normal
    property int inputMethodHints: Qt.ImhNone
    property QQ.Component leading
    property QQ.Component trailing
    readonly property alias editorItem: editor
    readonly property bool invalid: state === "error"
    readonly property bool successful: state === "success"
    readonly property bool interactive: !disabled && !loading && !readOnly
    readonly property real fieldHeight: compact ? 36 : 56
    readonly property real inlinePadding: compact ? 8 : 16
    readonly property var stateColor:
        invalid ? Tokens.colorError
                : successful ? Tokens.colorSuccess : Tokens.colorPrimary
    readonly property var stateBackground:
        invalid ? Tokens.colorErrorFrostedSoft
                : successful ? Tokens.colorSuccessFrostedSoft : Tokens.colorFrosted
    readonly property var stateBorder:
        invalid ? Tokens.colorError
                : successful ? Tokens.colorSuccess : Tokens.colorContrastLower

    signal edited(string value)
    signal accepted()

    implicitWidth: 320
    implicitHeight: content.implicitHeight
    width: implicitWidth
    height: implicitHeight

    function forceEditorFocus() {
        editor.forceActiveFocus(Qt.TabFocusReason)
    }

    QQ.Column {
        id: content
        width: parent.width
        spacing: Tokens.spacingStaticXs

        QQ.Column {
            width: parent.width
            spacing: 0
            visible: !control.hideLabel && (control.label.length > 0
                                            || control.description.length > 0)

            Text {
                width: parent.width
                visible: control.label.length > 0
                text: control.label + (control.required ? " *" : "")
                size: 2
                opacity: control.disabled ? 0.4 : 1
            }

            Text {
                width: parent.width
                visible: control.description.length > 0
                text: control.description
                size: 1
                semanticColor: 2
                hyphens: 2
                wrapMode: QQ.Text.WordWrap
                opacity: control.disabled ? 0.4 : 1
            }
        }

        QQ.Rectangle {
            id: field
            width: parent.width
            height: control.fieldHeight
            radius: control.compact ? Tokens.radiusLg : Tokens.radiusXl
            color: control.readOnly ? Tokens.colorFrosted : control.stateBackground
            border.width: control.readOnly ? 0 : 1
            border.color: control.readOnly ? "transparent"
                          : editor.activeFocus || hoverArea.containsMouse
                            ? control.stateColor : control.stateBorder
            opacity: control.disabled ? 0.4 : 1

            QQ.MouseArea {
                id: hoverArea
                anchors.fill: parent
                acceptedButtons: Qt.NoButton
                hoverEnabled: control.interactive
                cursorShape: control.disabled || control.loading
                             ? Qt.ForbiddenCursor : Qt.IBeamCursor
            }

            QQ.Loader {
                id: leadingLoader
                anchors.left: parent.left
                anchors.leftMargin: control.inlinePadding
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: control.leading
                visible: active
            }

            QQ.Loader {
                id: trailingLoader
                anchors.right: loadingSpinner.visible
                               ? loadingSpinner.left : counterLabel.visible
                                 ? counterLabel.left : parent.right
                anchors.rightMargin: active ? Tokens.spacingStaticXs : 0
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: control.trailing
                visible: active
            }

            QQ.Text {
                id: counterLabel
                anchors.right: loadingSpinner.visible
                               ? loadingSpinner.left : parent.right
                anchors.rightMargin: visible ? control.inlinePadding : 0
                anchors.verticalCenter: parent.verticalCenter
                visible: control.counter && !control.loading
                text: control.maximumLength < 32767
                      ? editor.length + "/" + control.maximumLength
                      : String(editor.length)
                color: Tokens.colorContrastHigh
                font.family: Typography.family
                font.pixelSize: 16
                renderType: QQ.Text.NativeRendering
                height: Tokens.leadingNormal
                verticalAlignment: QQ.Text.AlignVCenter
                QQ.Accessible.ignored: true
            }

            Spinner {
                id: loadingSpinner
                anchors.right: parent.right
                anchors.rightMargin: visible ? control.inlinePadding : 0
                anchors.verticalCenter: parent.verticalCenter
                visible: control.loading
                extent: Tokens.leadingNormal
            }

            QQ.TextInput {
                id: editor
                objectName: "_inputEditor"
                anchors.left: leadingLoader.active ? leadingLoader.right : parent.left
                anchors.leftMargin: leadingLoader.active
                                    ? (control.compact ? 4 : 12)
                                    : control.inlinePadding
                anchors.right: trailingLoader.active ? trailingLoader.left
                               : counterLabel.visible ? counterLabel.left
                                 : loadingSpinner.visible ? loadingSpinner.left : parent.right
                anchors.rightMargin: trailingLoader.active || counterLabel.visible
                                     || loadingSpinner.visible
                                     ? Tokens.spacingStaticXs : control.inlinePadding
                anchors.verticalCenter: parent.verticalCenter
                height: Math.min(parent.height, 30)
                enabled: !control.disabled && !control.loading
                readOnly: control.readOnly
                echoMode: control.echoMode
                inputMethodHints: control.inputMethodHints
                maximumLength: control.maximumLength
                color: control.readOnly ? Tokens.colorContrastMedium : Tokens.colorPrimary
                selectionColor: Tokens.colorFocus
                selectedTextColor: Tokens.colorCanvas
                font.family: Typography.family
                font.pixelSize: 16
                font.weight: Tokens.fontWeightNormal
                renderType: QQ.TextInput.NativeRendering
                verticalAlignment: QQ.TextInput.AlignVCenter
                clip: true
                activeFocusOnTab: !control.disabled && !control.loading
                QQ.Accessible.role: QQ.Accessible.EditableText
                QQ.Accessible.name: control.label
                QQ.Accessible.description:
                    [control.description, control.message].filter(v => v.length > 0).join(". ")
                QQ.Accessible.readOnly: control.readOnly
                onTextEdited: control.edited(text)
                onAccepted: control.accepted()

                QQ.Text {
                    anchors.fill: parent
                    visible: editor.text.length === 0 && !editor.activeFocus
                    text: control.placeholder
                    color: Tokens.colorContrastMedium
                    font: editor.font
                    renderType: QQ.Text.NativeRendering
                    verticalAlignment: QQ.Text.AlignVCenter
                    elide: QQ.Text.ElideRight
                    horizontalAlignment: QQ.LayoutMirroring.enabled
                                         ? QQ.Text.AlignRight : QQ.Text.AlignLeft
                    QQ.Accessible.ignored: true
                }
            }

        }

        Text {
            width: parent.width
            visible: control.message.length > 0 && control.state !== "none"
            text: control.message
            semanticColor: control.invalid ? 6 : 4
            hyphens: 2
            wrapMode: QQ.Text.WordWrap
        }
    }
}
