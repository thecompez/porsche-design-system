import QtQuick as QQ
import QtQuick.Controls as QQC
import QtQuick.Effects
import QtQuick.Templates as T

QQ.Item {
    id: control

    enum Backdrop { Blur, Shading }
    enum Background { Canvas, Surface }

    property bool open: false
    property int backdrop: Modal.Blur
    property int backgroundStyle: Modal.Canvas
    property bool disableBackdropClick: false
    property bool dismissButton: true
    property bool fullscreen: false
    property string accessibleName: heading
    property int accessibleRole: QQ.Accessible.Dialog
    property string heading: ""
    property string description: ""
    property QQ.Component header
    property QQ.Component content
    property QQ.Component footer
    readonly property bool opened: popup.opened
    readonly property real horizontalMargin:
        Math.max(22, Theme.viewportWidth * 0.10625 - 12)
    readonly property real verticalMargin:
        Math.max(16, Math.min(192, (popup.parent ? popup.parent.height : 800) * 0.1))
    readonly property real panelWidth:
        Math.max(276, Math.min(640, Theme.viewportWidth * 0.4525 + 131))
    readonly property real fluidMd:
        Math.max(16, Math.min(36, Theme.viewportWidth * 0.0125 + 12))
    readonly property real fluidLg:
        Math.max(32, Math.min(76, Theme.viewportWidth * 0.0275 + 23))
    property QQ.Item previousFocusItem: null

    signal dismiss()
    signal motionVisibleEnd()
    signal motionHiddenEnd()

    visible: false
    implicitWidth: panelWidth
    implicitHeight: panel.implicitHeight

    function requestDismiss() {
        if (open)
            dismiss()
    }

    onOpenChanged: {
        if (open) {
            previousFocusItem = control.window ? control.window.activeFocusItem : null
            popup.open()
        } else {
            popup.close()
        }
    }

    QQ.Component.onCompleted: {
        if (open)
            popup.open()
    }

    QQC.Popup {
        id: popup
        objectName: "_modalPopup"
        parent: QQC.Overlay.overlay
        x: 0
        y: 0
        width: parent ? parent.width : 0
        height: parent ? parent.height : 0
        padding: 0
        modal: true
        focus: true
        closePolicy: QQC.Popup.NoAutoClose

        onOpened: {
            if (control.dismissButton)
                closeButton.forceActiveFocus(Qt.PopupFocusReason)
            else
                panel.forceActiveFocus(Qt.PopupFocusReason)
            openMotion.restart()
        }
        onClosed: {
            if (control.previousFocusItem)
                control.previousFocusItem.forceActiveFocus(Qt.PopupFocusReason)
            closeMotion.restart()
        }

        background: QQ.Rectangle {
            color: control.backdrop === Modal.Shading
                   ? Tokens.colorBackdrop : Qt.rgba(0.14, 0.14, 0.16, 0.32)
        }

        contentItem: QQ.Item {
            QQ.MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!control.disableBackdropClick)
                        control.requestDismiss()
                }
            }

            QQ.Rectangle {
                id: panel
                objectName: "_modalPanel"
                width: control.fullscreen
                       ? parent.width
                       : Math.min(control.panelWidth,
                                  parent.width - 2 * control.horizontalMargin)
                height: control.fullscreen
                        ? parent.height
                        : Math.min(implicitHeight,
                                   parent.height - 2 * control.verticalMargin)
                implicitHeight: Math.max(276,
                    control.fluidMd + headerLoader.implicitHeight
                    + (headerLoader.active ? control.fluidMd : 0)
                    + bodyScroller.implicitHeight
                    + (footerLoader.active ? control.fluidMd : 0)
                    + footerLoader.implicitHeight
                    + Tokens.radius3Xl + control.fluidMd)
                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                radius: control.fullscreen ? 0 : Tokens.radius3Xl
                color: control.backgroundStyle === Modal.Surface
                       ? Tokens.colorSurface : Tokens.colorCanvas
                clip: true
                activeFocusOnTab: !control.dismissButton
                QQ.Accessible.role: control.accessibleRole
                QQ.Accessible.name: control.accessibleName
                QQ.Accessible.description: control.description
                QQ.Accessible.focusable: true
                layer.enabled: !control.fullscreen
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowOpacity: 0.16
                    shadowBlur: 0.45
                    shadowVerticalOffset: 8
                }

                QQ.MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.AllButtons
                    onPressed: mouse => mouse.accepted = true
                }

                QQ.Column {
                    anchors.fill: parent
                    anchors.topMargin: control.fluidMd
                    anchors.leftMargin: control.fluidLg
                    anchors.rightMargin: control.fluidLg
                    anchors.bottomMargin: Tokens.radius3Xl + control.fluidMd
                    spacing: control.fluidMd

                    QQ.Loader {
                        id: headerLoader
                        width: parent.width
                        sourceComponent: control.header
                                         ? control.header : defaultHeader
                        active: control.header !== null
                                || control.heading.length > 0
                    }

                    QQC.ScrollView {
                        id: bodyScroller
                        width: parent.width
                        implicitHeight: Math.min(
                            bodyLoader.implicitHeight,
                            Math.max(80, panel.height
                                - control.fluidMd
                                - headerLoader.implicitHeight
                                - footerLoader.implicitHeight
                                - Tokens.radius3Xl
                                - control.fluidMd * 4))
                        height: implicitHeight
                        contentWidth: availableWidth
                        clip: true

                        QQ.Loader {
                            id: bodyLoader
                            width: bodyScroller.availableWidth
                            sourceComponent: control.content
                                             ? control.content : defaultBody
                        }
                    }

                    QQ.Loader {
                        id: footerLoader
                        width: parent.width
                        sourceComponent: control.footer
                        active: control.footer !== null
                    }
                }

                T.AbstractButton {
                    id: closeButton
                    objectName: "_modalDismiss"
                    visible: control.dismissButton
                    width: 36
                    height: 36
                    anchors.top: parent.top
                    anchors.topMargin: control.fluidMd
                    anchors.right: parent.right
                    anchors.rightMargin: control.fluidMd
                    activeFocusOnTab: true
                    hoverEnabled: true
                    QQ.Accessible.role: QQ.Accessible.Button
                    QQ.Accessible.name: qsTr("Dismiss modal")

                    background: QQ.Rectangle {
                        radius: Tokens.radiusFull
                        color: closeButton.hovered || closeButton.down
                               ? Tokens.colorContrastHigh : Tokens.colorPrimary
                    }
                    contentItem: Icon {
                        name: "close"
                        inheritedColor: Tokens.colorCanvas
                        semanticColor: Icon.Inherit
                        accessibleName: ""
                        decorative: true
                    }
                    FocusRing { target: closeButton }
                    onClicked: control.requestDismiss()
                }

                QQ.Keys.onEscapePressed: event => {
                    control.requestDismiss()
                    event.accepted = true
                }
            }
        }

        enter: QQ.Transition {
            QQ.NumberAnimation {
                target: panel
                properties: "opacity"
                from: 0
                to: 1
                duration: Motion.reduced ? 0 : Motion.durationSm
                easing.type: Motion.easingType
            }
            QQ.NumberAnimation {
                target: panel
                property: "y"
                from: popup.height * 0.25
                to: (popup.height - panel.height) / 2
                duration: Motion.reduced ? 0 : Motion.durationSm
                easing.type: Motion.easingType
            }
        }

        exit: QQ.Transition {
            QQ.NumberAnimation {
                target: panel
                property: "opacity"
                from: 1
                to: 0
                duration: Motion.reduced ? 0 : Motion.durationSm
                easing.type: Motion.easingType
            }
        }
    }

    QQ.Component {
        id: defaultHeader
        Heading {
            width: headerLoader.width
            text: control.heading
            size: Heading.SizeLg
            level: 2
            hyphens: Heading.Auto
            wrapMode: QQ.Text.WordWrap
        }
    }

    QQ.Component {
        id: defaultBody
        Text {
            width: bodyLoader.width
            text: control.description
            hyphens: Text.Auto
            wrapMode: QQ.Text.WordWrap
        }
    }

    QQ.SequentialAnimation {
        id: openMotion
        QQ.PauseAnimation { duration: Motion.reduced ? 0 : Motion.durationSm }
        QQ.ScriptAction { script: control.motionVisibleEnd() }
    }

    QQ.SequentialAnimation {
        id: closeMotion
        QQ.PauseAnimation { duration: Motion.reduced ? 0 : Motion.durationSm }
        QQ.ScriptAction { script: control.motionHiddenEnd() }
    }
}
