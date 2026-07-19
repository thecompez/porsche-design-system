import QtQuick as QQ
import QtQuick.Controls as QQC
import QtQuick.Effects
import QtQuick.Templates as T

T.Control {
    id: control

    enum DropdownDirection { Auto, Up, Down }

    property string label: ""
    property string description: ""
    property string name: ""
    property var value: undefined
    property var options: []
    property string message: ""
    property bool hideLabel: false
    property bool disabled: false
    property bool required: false
    property int dropdownDirection: Select.Auto
    property bool filter: false
    property bool compact: false
    property string formId: ""
    property string filterText: ""
    readonly property bool invalid: state === "error"
    readonly property bool successful: state === "success"
    readonly property bool isOpen: popup.opened
    readonly property int currentIndex: indexForValue(value)
    readonly property string currentText:
        currentIndex >= 0 ? optionText(currentIndex) : ""
    property int highlightedIndex: currentIndex >= 0 ? currentIndex : firstEnabled(0, 1)
    signal change(var value)
    signal toggle(bool open)

    state: "none"
    implicitWidth: 320
    implicitHeight: content.implicitHeight
    width: implicitWidth
    height: implicitHeight
    padding: 0

    function option(index) {
        return index >= 0 && index < options.length ? options[index] : null
    }
    function optionText(index) {
        const item = option(index)
        return item && item.text !== undefined ? String(item.text) : ""
    }
    function optionValue(index) {
        const item = option(index)
        return item ? item.value : undefined
    }
    function optionDisabled(index) {
        const item = option(index)
        return !item || !!item.disabled
    }
    function optionVisible(index) {
        return filterText.length === 0
               || optionText(index).toLocaleLowerCase()
                  .includes(filterText.toLocaleLowerCase())
    }
    function indexForValue(candidate) {
        for (let index = 0; index < options.length; ++index) {
            if (optionValue(index) === candidate)
                return index
        }
        return -1
    }
    function firstEnabled(start, step) {
        if (options.length === 0)
            return -1
        let index = Math.max(0, Math.min(options.length - 1, start))
        for (let count = 0; count < options.length; ++count) {
            if (!optionDisabled(index) && optionVisible(index))
                return index
            index = (index + step + options.length) % options.length
        }
        return -1
    }
    function moveHighlight(step) {
        if (options.length === 0)
            return
        let index = highlightedIndex
        for (let count = 0; count < options.length; ++count) {
            index = (index + step + options.length) % options.length
            if (!optionDisabled(index) && optionVisible(index)) {
                highlightedIndex = index
                return
            }
        }
    }
    function open() {
        if (disabled || popup.opened)
            return
        highlightedIndex = currentIndex >= 0 ? currentIndex : firstEnabled(0, 1)
        popup.open()
    }
    function close() {
        popup.close()
    }
    function selectIndex(index) {
        if (index < 0 || optionDisabled(index) || !optionVisible(index))
            return
        value = optionValue(index)
        highlightedIndex = index
        change(value)
        close()
    }

    contentItem: QQ.Column {
        id: content
        width: control.width
        spacing: Tokens.spacingStaticXs

        QQ.Column {
            width: parent.width
            visible: !control.hideLabel && (control.label.length > 0
                                            || control.description.length > 0)
            spacing: 0
            Text {
                width: parent.width
                text: control.label + (control.required ? " *" : "")
                visible: control.label.length > 0
                opacity: control.disabled ? 0.4 : 1
            }
            Text {
                width: parent.width
                text: control.description
                visible: control.description.length > 0
                size: 1
                semanticColor: 2
                hyphens: 2
                wrapMode: QQ.Text.WordWrap
                opacity: control.disabled ? 0.4 : 1
            }
        }

        T.AbstractButton {
            id: button
            objectName: "_selectButton"
            width: parent.width
            height: control.compact ? 36 : 56
            leftPadding: control.compact ? 8 : 16
            rightPadding: leftPadding
            activeFocusOnTab: !control.disabled
            enabled: !control.disabled
            hoverEnabled: true
            QQ.Accessible.role: QQ.Accessible.ComboBox
            QQ.Accessible.name: control.label
            QQ.Accessible.description:
                [control.description, control.message].filter(v => v.length > 0).join(". ")

            background: QQ.Rectangle {
                radius: control.compact ? Tokens.radiusLg : Tokens.radiusXl
                color: control.invalid ? Tokens.colorErrorFrostedSoft
                       : control.successful ? Tokens.colorSuccessFrostedSoft : Tokens.colorFrosted
                border.width: 1
                border.color: control.invalid ? Tokens.colorError
                              : control.successful ? Tokens.colorSuccess
                                : control.isOpen || button.hovered
                                  ? Tokens.colorPrimary : Tokens.colorContrastLower
                opacity: control.disabled ? 0.4 : 1
            }

            contentItem: QQ.Row {
                spacing: control.compact ? 4 : 12
                QQ.Text {
                    width: Math.max(0, button.availableWidth - arrow.implicitWidth
                                    - parent.spacing)
                    text: control.currentText
                    color: Tokens.colorPrimary
                    font.family: Typography.family
                    font.pixelSize: 16
                    renderType: QQ.Text.NativeRendering
                    height: Tokens.leadingNormal
                    verticalAlignment: QQ.Text.AlignVCenter
                    elide: QQ.Text.ElideRight
                    QQ.Accessible.ignored: true
                }
                Icon {
                    id: arrow
                    visible: !missing
                    name: "arrow-head-down"
                    rotation: control.isOpen ? 180 : 0
                    QQ.Behavior on rotation {
                        QQ.NumberAnimation {
                            duration: Motion.durationSm
                            easing.type: Motion.easingType
                        }
                    }
                }
            }

            onClicked: control.isOpen ? control.close() : control.open()
            QQ.Keys.onPressed: event => {
                switch (event.key) {
                case Qt.Key_Down:
                    if (!control.isOpen) control.open()
                    else control.moveHighlight(1)
                    event.accepted = true
                    break
                case Qt.Key_Up:
                    if (!control.isOpen) control.open()
                    else control.moveHighlight(-1)
                    event.accepted = true
                    break
                case Qt.Key_Home:
                    control.open()
                    control.highlightedIndex = control.firstEnabled(0, 1)
                    event.accepted = true
                    break
                case Qt.Key_End:
                    control.open()
                    control.highlightedIndex = control.firstEnabled(
                                control.options.length - 1, -1)
                    event.accepted = true
                    break
                case Qt.Key_Return:
                case Qt.Key_Enter:
                case Qt.Key_Space:
                    if (control.isOpen)
                        control.selectIndex(control.highlightedIndex)
                    else
                        control.open()
                    event.accepted = true
                    break
                case Qt.Key_Escape:
                    control.close()
                    event.accepted = true
                    break
                }
            }
        }

        Text {
            visible: control.message.length > 0 && control.state !== "none"
            text: control.message
            semanticColor: control.invalid ? 6 : 4
            hyphens: 2
            wrapMode: QQ.Text.WordWrap
        }
    }

    QQC.Popup {
        id: popup
        parent: QQC.Overlay.overlay
        width: control.width
        height: Math.min(280, popupContent.implicitHeight + topPadding + bottomPadding)
        padding: control.compact ? 4 : 8
        modal: false
        focus: false
        closePolicy: QQC.Popup.CloseOnEscape | QQC.Popup.CloseOnPressOutside
        x: {
            if (!parent)
                return 0
            const mapped = control.mapToItem(parent, 0, 0).x
            return Math.max(8, Math.min(mapped, parent.width - width - 8))
        }
        y: {
            if (!parent)
                return 0
            const mapped = control.mapToItem(parent, 0, 0)
            const below = mapped.y + control.height
            const above = mapped.y - height
            if (control.dropdownDirection === Select.Up)
                return Math.max(8, above)
            if (control.dropdownDirection === Select.Down)
                return Math.min(parent.height - height - 8, below)
            return below + height <= parent.height - 8
                   ? below : Math.max(8, above)
        }
        onOpened: {
            control.filterText = ""
            control.toggle(true)
        }
        onClosed: {
            control.filterText = ""
            control.toggle(false)
            button.forceActiveFocus(Qt.PopupFocusReason)
        }

        background: QQ.Rectangle {
            color: Tokens.colorCanvas
            border.width: 1
            border.color: Tokens.colorContrastLow
            radius: Tokens.radiusXl
            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowBlur: 0.35
                shadowOpacity: 0.15
            }
        }

        contentItem: QQ.Column {
            id: popupContent
            spacing: control.compact ? 4 : 8

            InputText {
                width: parent.width
                visible: control.filter
                compact: true
                hideLabel: true
                label: qsTr("Filter options")
                placeholder: qsTr("Filter options")
                onEdited: text => control.filterText = text
            }

            QQ.ListView {
                id: optionList
                width: parent.width
                implicitHeight: Math.min(contentHeight, 220)
                height: implicitHeight
                clip: true
                spacing: control.compact ? 4 : 8
                model: control.options.length

                delegate: T.AbstractButton {
                    id: optionControl
                    required property int index
                    width: optionList.width
                    height: visible ? control.compact ? 40 : 44 : 0
                    visible: control.optionVisible(index)
                    enabled: !control.optionDisabled(index)
                    leftPadding: control.compact ? 6 : 12
                    rightPadding: leftPadding
                    hoverEnabled: true
                    QQ.Accessible.role: QQ.Accessible.ListItem
                    QQ.Accessible.name: control.optionText(index)
                    QQ.Accessible.selected: control.currentIndex === index

                    background: QQ.Rectangle {
                        radius: Tokens.radiusSm
                        color: optionControl.index === control.highlightedIndex
                               || optionControl.hovered ? Tokens.colorFrosted : "transparent"
                        opacity: optionControl.enabled ? 1 : 0.4
                    }
                    contentItem: QQ.Text {
                        text: control.optionText(optionControl.index)
                        color: control.currentIndex === optionControl.index
                               ? Tokens.colorPrimary : Tokens.colorContrastHigh
                        font.family: Typography.family
                        font.pixelSize: 16
                        renderType: QQ.Text.NativeRendering
                        verticalAlignment: QQ.Text.AlignVCenter
                        wrapMode: QQ.Text.WordWrap
                    }
                    onHoveredChanged: {
                        if (hovered && enabled)
                            control.highlightedIndex = index
                    }
                    onClicked: control.selectIndex(index)
                }
            }
        }
    }
}
