import QtQuick as QQ

Button {
    id: control

    enum Variant { Primary, Secondary }

    property url href: ""
    property string target: "_self"
    property string download: ""
    property string rel: ""
    property string accessibleDescription: ""
    signal activated(url href)

    buttonType: Button.Button
    QQ.Accessible.role: QQ.Accessible.Link
    QQ.Accessible.name: accessibleName
    QQ.Accessible.description: accessibleDescription

    onClicked: {
        activated(href)
        if (href.toString().length > 0)
            Qt.openUrlExternally(href)
    }
}
