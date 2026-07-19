import QtQuick as QQ
import QtQuick.Templates as T

T.Control {
    id: control

    enum Background { Canvas, Surface, Frosted, None }
    enum Size { Small, Medium }

    property int activeTabIndex: 0
    property var items: []
    property int backgroundStyle: Tabs.None
    property bool compact: false
    property int size: Tabs.Small
    property string accessibleName: ""
    property string accessibleDescription: ""
    property QQ.Component panel
    readonly property int itemCount: items ? items.length : 0
    readonly property real tabHeight: compact ? 36 : 56
    readonly property real tabPadding: compact ? 16 : 28
    readonly property real labelPixelSize:
        size === Tabs.Medium
        ? Typography.typeSize(3, Theme.viewportWidth, 18)
        : Typography.typeSize(2, Theme.viewportWidth, 16)
    readonly property var activeItem:
        itemCount > 0 && activeTabIndex >= 0 && activeTabIndex < itemCount
        ? items[activeTabIndex] : null
    readonly property string activeContent:
        activeItem && activeItem.content !== undefined
        ? String(activeItem.content) : ""
    readonly property QQ.Component activeComponent:
        activeItem && activeItem.component !== undefined
        ? activeItem.component : panel

    signal update(int activeTabIndex)

    implicitWidth: 480
    implicitHeight: layout.implicitHeight
    padding: 0
    background: null

    function itemLabel(index) {
        const item = index >= 0 && index < itemCount ? items[index] : null
        return item && item.label !== undefined ? String(item.label) : ""
    }

    function normalizedIndex(index) {
        return itemCount === 0 ? -1 : Math.max(0, Math.min(itemCount - 1, index))
    }

    function select(index, userInitiated) {
        const selected = normalizedIndex(index)
        if (selected < 0)
            return
        activeTabIndex = selected
        tabList.currentIndex = selected
        if (userInitiated)
            update(selected)
    }

    function move(index, delta) {
        if (itemCount === 0)
            return
        const direction = QQ.LayoutMirroring.enabled ? -delta : delta
        select((index + direction + itemCount) % itemCount, true)
        const item = tabList.itemAtIndex(activeTabIndex)
        if (item)
            item.forceActiveFocus(Qt.TabFocusReason)
    }

    onItemsChanged: select(activeTabIndex, false)
    onActiveTabIndexChanged: {
        const selected = normalizedIndex(activeTabIndex)
        if (selected >= 0 && selected !== activeTabIndex)
            activeTabIndex = selected
        tabList.currentIndex = selected
    }

    contentItem: QQ.Column {
        id: layout
        width: control.width
        spacing: Tokens.spacingStaticMd

        QQ.Rectangle {
            width: parent.width
            height: control.tabHeight
            color: {
                switch (control.backgroundStyle) {
                case Tabs.Canvas: return Tokens.colorCanvas
                case Tabs.Surface: return Tokens.colorSurface
                case Tabs.Frosted: return Tokens.colorFrosted
                default: return "transparent"
                }
            }

            QQ.ListView {
                id: tabList
                objectName: "_tabList"
                anchors.fill: parent
                orientation: QQ.ListView.Horizontal
                layoutDirection: QQ.LayoutMirroring.enabled
                                 ? Qt.RightToLeft : Qt.LeftToRight
                model: control.itemCount
                currentIndex: control.normalizedIndex(control.activeTabIndex)
                clip: true
                interactive: contentWidth > width
                boundsBehavior: QQ.Flickable.StopAtBounds
                QQ.Accessible.role: QQ.Accessible.PageTabList
                QQ.Accessible.name: control.accessibleName
                QQ.Accessible.description: control.accessibleDescription

                delegate: T.AbstractButton {
                    id: tab
                    required property int index
                    objectName: "_tab_" + index
                    height: control.tabHeight
                    implicitWidth: label.implicitWidth + leftPadding + rightPadding
                    leftPadding: control.compact ? 16 : 28
                    rightPadding: leftPadding
                    topPadding: control.compact ? 6 : 16
                    bottomPadding: topPadding
                    activeFocusOnTab: index === control.activeTabIndex
                    hoverEnabled: true
                    QQ.Accessible.role: QQ.Accessible.PageTab
                    QQ.Accessible.name: control.itemLabel(index)
                    QQ.Accessible.selected: index === control.activeTabIndex
                    QQ.Accessible.focusable: true

                    contentItem: QQ.Text {
                        id: label
                        text: control.itemLabel(tab.index)
                        color: Tokens.colorPrimary
                        font.family: Typography.family
                        font.pixelSize: control.labelPixelSize
                        font.weight: Tokens.fontWeightNormal
                        renderType: QQ.Text.NativeRendering
                        height: Typography.lineHeight(control.labelPixelSize)
                        verticalAlignment: QQ.Text.AlignVCenter
                        elide: QQ.Text.ElideRight
                        QQ.Accessible.ignored: true
                    }

                    background: QQ.Rectangle {
                        radius: control.compact ? Tokens.radiusLg : Tokens.radiusXl
                        color: tab.index === control.activeTabIndex
                               ? Tokens.colorFrostedStrong
                               : tab.hovered || tab.down
                                 ? Tokens.colorFrosted : "transparent"
                    }

                    FocusRing { target: tab }

                    onClicked: control.select(index, true)
                    QQ.Keys.onPressed: event => {
                        if (event.key === Qt.Key_Left) {
                            control.move(index, -1)
                            event.accepted = true
                        } else if (event.key === Qt.Key_Right) {
                            control.move(index, 1)
                            event.accepted = true
                        } else if (event.key === Qt.Key_Home) {
                            control.select(0, true)
                            const first = tabList.itemAtIndex(0)
                            if (first)
                                first.forceActiveFocus(Qt.TabFocusReason)
                            event.accepted = true
                        } else if (event.key === Qt.Key_End) {
                            control.select(control.itemCount - 1, true)
                            const last = tabList.itemAtIndex(
                                        control.itemCount - 1)
                            if (last)
                                last.forceActiveFocus(Qt.TabFocusReason)
                            event.accepted = true
                        }
                    }
                }
            }
        }

        QQ.Loader {
            id: panelLoader
            objectName: "_tabPanel"
            width: parent.width
            sourceComponent: control.activeComponent
                             ? control.activeComponent : fallbackPanel
            QQ.Accessible.role: QQ.Accessible.Pane
            QQ.Accessible.name: control.itemLabel(control.activeTabIndex)
        }
    }

    QQ.Component {
        id: fallbackPanel
        Text {
            width: panelLoader.width
            text: control.activeContent
            hyphens: Text.Auto
            wrapMode: QQ.Text.WordWrap
        }
    }
}
