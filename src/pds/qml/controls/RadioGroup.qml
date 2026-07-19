import QtQuick as QQ
import QtQuick.Layouts
import QtQuick.Templates as T

QQ.Item {
    id: control

    enum Direction { Row, Column }

    property string label: ""
    property string description: ""
    property bool compact: false
    property int direction: RadioGroup.Column
    property string name: ""
    property string value: ""
    property bool required: false
    property bool loading: false
    property bool disabled: false
    property string formId: ""
    property string message: ""
    property bool hideLabel: false
    property var options: []
    readonly property bool invalid: state === "error"
    readonly property bool successful: state === "success"
    readonly property int currentIndex: indexForValue(value)
    readonly property bool mirroredLayout: QQ.LayoutMirroring.enabled
    signal change(string value)

    state: "none"
    implicitWidth: 320
    implicitHeight: content.implicitHeight
    width: implicitWidth
    height: implicitHeight
    QQ.Accessible.role: QQ.Accessible.Grouping
    QQ.Accessible.name: label
    QQ.Accessible.description: [description, message].filter(v => v.length > 0).join(". ")

    function optionValue(index) {
        const option = options[index]
        return option && option.value !== undefined ? String(option.value) : ""
    }

    function optionLabel(index) {
        const option = options[index]
        return option && option.label !== undefined ? String(option.label) : optionValue(index)
    }

    function optionDisabled(index) {
        const option = options[index]
        return !!(disabled || loading || (option && (option.disabled || option.loading)))
    }

    function indexForValue(candidate) {
        for (let index = 0; index < options.length; ++index) {
            if (optionValue(index) === candidate)
                return index
        }
        return -1
    }

    function findEnabled(start, step) {
        if (options.length === 0)
            return -1
        let index = start
        for (let count = 0; count < options.length; ++count) {
            index = (index + step + options.length) % options.length
            if (!optionDisabled(index))
                return index
        }
        return start
    }

    function selectIndex(index, focusItem) {
        if (index < 0 || index >= options.length || optionDisabled(index))
            return
        if (focusItem)
            focusItem.forceActiveFocus(Qt.TabFocusReason)
        value = optionValue(index)
        change(value)
    }

    function navigate(from, step, focusItem) {
        const next = findEnabled(from, step)
        let target = focusItem
        for (let index = 0; index < optionsLayout.children.length; ++index) {
            const candidate = optionsLayout.children[index]
            if (candidate.objectName === "_radioOption" + next) {
                target = candidate
                break
            }
        }
        selectIndex(next, target)
    }

    QQ.Column {
        id: content
        width: parent.width
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

        GridLayout {
            id: optionsLayout
            columns: control.direction === RadioGroup.Row
                     ? Math.max(1, control.options.length) : 1
            columnSpacing: control.compact ? 8 : 16
            rowSpacing: control.compact ? 4 : 8

            QQ.Repeater {
                model: control.options.length

                delegate: T.AbstractButton {
                    id: optionControl
                    objectName: "_radioOption" + index
                    required property int index
                    readonly property bool selected: control.currentIndex === index
                    readonly property bool unavailable: control.optionDisabled(index)
                    readonly property real indicatorExtent: control.compact ? 18 : 28
                    activeFocusOnTab: !unavailable
                                      && (selected || (control.currentIndex < 0 && index === 0))
                    padding: 0
                    implicitWidth: contentItem.implicitWidth
                    implicitHeight: Math.max(indicatorExtent, Tokens.leadingNormal)
                    QQ.Accessible.role: QQ.Accessible.RadioButton
                    QQ.Accessible.name: control.optionLabel(index)
                    QQ.Accessible.checkable: true
                    QQ.Accessible.checked: selected

                    contentItem: QQ.Row {
                        spacing: control.compact ? 4 : 8

                        QQ.Rectangle {
                            width: optionControl.indicatorExtent
                            height: width
                            radius: Tokens.radiusFull
                            color: optionControl.selected
                                   ? control.invalid ? Tokens.colorError
                                     : control.successful ? Tokens.colorSuccess : Tokens.colorPrimary
                                   : control.invalid ? Tokens.colorErrorFrostedSoft
                                     : control.successful ? Tokens.colorSuccessFrostedSoft : Tokens.colorFrosted
                            border.width: 1
                            border.color: optionControl.hovered && !optionControl.unavailable
                                          ? control.invalid ? Tokens.colorError
                                            : control.successful ? Tokens.colorSuccess : Tokens.colorPrimary
                                          : control.invalid ? Tokens.colorError
                                            : control.successful ? Tokens.colorSuccess : Tokens.colorContrastLower
                            opacity: optionControl.unavailable ? 0.4 : 1

                            QQ.Rectangle {
                                visible: optionControl.selected
                                width: parent.width * 12 / 28
                                height: width
                                radius: width / 2
                                anchors.centerIn: parent
                                color: Tokens.colorCanvas
                            }
                        }

                        QQ.Text {
                            text: control.optionLabel(optionControl.index)
                            color: Tokens.colorPrimary
                            opacity: optionControl.unavailable ? 0.4 : 1
                            font.family: Typography.family
                            font.pixelSize: 16
                            renderType: QQ.Text.NativeRendering
                            height: Math.max(optionControl.indicatorExtent, Tokens.leadingNormal)
                            verticalAlignment: QQ.Text.AlignVCenter
                            QQ.Accessible.ignored: true
                        }
                    }

                    onClicked: control.selectIndex(index, optionControl)
                    QQ.Keys.onRightPressed: event => {
                        control.navigate(index, control.mirroredLayout ? -1 : 1,
                                         optionControl)
                        event.accepted = true
                    }
                    QQ.Keys.onLeftPressed: event => {
                        control.navigate(index, control.mirroredLayout ? 1 : -1,
                                         optionControl)
                        event.accepted = true
                    }
                    QQ.Keys.onDownPressed: event => {
                        control.navigate(index, 1, optionControl)
                        event.accepted = true
                    }
                    QQ.Keys.onUpPressed: event => {
                        control.navigate(index, -1, optionControl)
                        event.accepted = true
                    }
                    FocusRing { target: optionControl }
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
}
