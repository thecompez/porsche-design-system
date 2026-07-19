import QtQuick as QQ
import QtQuick.Controls as QQC

QQ.Item {
    id: control

    enum Position { Top, Bottom }

    property bool open: false
    property string heading: ""
    property int headingLevel: 5
    property string description: ""
    property int position: Theme.viewportWidth >= Tokens.breakpointSm ? 0 : 1
    property bool dismissButton: true
    readonly property real horizontalInset:
        Math.max(22, Theme.viewportWidth * 0.10625 - 12)
    signal dismiss()

    state: "info"
    visible: false
    implicitWidth: 640
    implicitHeight: bannerContent.implicitHeight

    onOpenChanged: {
        if (open)
            popup.open()
        else
            popup.close()
    }
    QQ.Component.onCompleted: {
        if (open)
            popup.open()
    }

    QQC.Popup {
        id: popup
        parent: QQC.Overlay.overlay
        width: Math.min(parent ? parent.width - 2 * control.horizontalInset : 640, 800)
        height: bannerContent.implicitHeight
        padding: 0
        modal: false
        focus: true
        closePolicy: QQC.Popup.NoAutoClose
        x: parent ? (parent.width - width) / 2 : 0
        y: {
            if (!parent)
                return 56
            return control.position === Banner.Top
                   ? 56 : parent.height - height - 56
        }
        opacity: control.open ? 1 : 0

        contentItem: InlineNotification {
            id: bannerContent
            width: popup.width
            heading: control.heading
            headingLevel: control.headingLevel
            description: control.description
            state: control.state
            dismissButton: control.dismissButton
            QQ.Keys.onEscapePressed: event => {
                if (control.dismissButton && control.open)
                    control.dismiss()
                event.accepted = true
            }
            onDismiss: control.dismiss()
        }

        background: null
    }
}
