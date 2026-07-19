import QtQuick
import QtTest
import Pds.Native
import Pds.Native as Pds

Rectangle {
    id: scene
    width: 600
    height: 900
    color: Tokens.colorCanvas

    Column {
        spacing: Tokens.spacingStaticSm
        Button { id: first; text: "First" }
        Button { id: second; text: "Second" }
        Button { id: disabledButton; text: "Disabled"; disabled: true }
        Button { id: loadingButton; text: "Loading"; loading: true }
        Link { id: link; text: "Link" }
        LinkPure { id: linkPure; text: "Pure link" }
        ButtonPure { id: buttonPure; text: "Pure button" }
        ButtonPure { id: disabledPure; text: "Disabled pure"; disabled: true }
        Pds.InputText { id: input; label: "Name" }
        Pds.InputPassword { id: password; label: "Password"; toggle: true }
        Pds.Switch { id: switchControl; text: "Switch" }
        Pds.Checkbox { id: checkbox; text: "Checkbox" }
        Pds.RadioGroup {
            id: radios
            label: "Mode"
            value: "normal"
            options: [
                { label: "Normal", value: "normal" },
                { label: "Sport", value: "sport" },
                { label: "Disabled", value: "disabled", disabled: true }
            ]
        }
        Pds.Select {
            id: select
            label: "Model"
            value: "718"
            options: [
                { text: "718", value: "718" },
                { text: "911", value: "911" }
            ]
        }
        Pds.Tabs {
            id: tabs
            accessibleName: "Sections"
            items: [
                { label: "Overview", content: "Overview" },
                { label: "Charging", content: "Charging" },
                { label: "Range", content: "Range" }
            ]
        }
    }

    Pds.Modal {
        id: modal
        heading: "Confirm"
        description: "Continue?"
        onDismiss: open = false
    }

    SignalSpy { id: firstSpy; target: first; signalName: "clicked" }
    SignalSpy { id: disabledSpy; target: disabledButton; signalName: "clicked" }
    SignalSpy { id: loadingSpy; target: loadingButton; signalName: "clicked" }
    SignalSpy { id: linkSpy; target: link; signalName: "activated" }
    SignalSpy { id: linkPureSpy; target: linkPure; signalName: "activated" }
    SignalSpy { id: buttonPureSpy; target: buttonPure; signalName: "clicked" }
    SignalSpy { id: disabledPureSpy; target: disabledPure; signalName: "clicked" }
    SignalSpy { id: switchSpy; target: switchControl; signalName: "update" }
    SignalSpy { id: checkboxSpy; target: checkbox; signalName: "change" }
    SignalSpy { id: radioSpy; target: radios; signalName: "change" }
    SignalSpy { id: selectSpy; target: select; signalName: "change" }
    SignalSpy { id: tabsSpy; target: tabs; signalName: "update" }
    SignalSpy { id: modalDismissSpy; target: modal; signalName: "dismiss" }

    TestCase {
        name: "ButtonInteraction"
        when: windowShown

        function init() {
            firstSpy.clear()
            disabledSpy.clear()
            loadingSpy.clear()
            linkSpy.clear()
            linkPureSpy.clear()
            buttonPureSpy.clear()
            disabledPureSpy.clear()
            switchSpy.clear()
            checkboxSpy.clear()
            radioSpy.clear()
            selectSpy.clear()
            tabsSpy.clear()
            modalDismissSpy.clear()
            first.forceActiveFocus(Qt.TabFocusReason)
        }

        function test_tabAndShiftTab() {
            verify(first.activeFocus)
            keyClick(Qt.Key_Tab)
            tryVerify(() => second.activeFocus)
            keyClick(Qt.Key_Backtab)
            tryVerify(() => first.activeFocus)
        }

        function test_enterAndSpaceActivation() {
            keyClick(Qt.Key_Return)
            compare(firstSpy.count, 1)
            keyClick(Qt.Key_Space)
            compare(firstSpy.count, 2)
        }

        function test_pointerActivation() {
            mouseClick(first, first.width / 2, first.height / 2, Qt.LeftButton)
            compare(firstSpy.count, 1)
        }

        function test_disabledAndLoadingBlockActivation() {
            disabledButton.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Return)
            mouseClick(disabledButton, 2, 2, Qt.LeftButton)
            compare(disabledSpy.count, 0)

            loadingButton.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Space)
            mouseClick(loadingButton, 2, 2, Qt.LeftButton)
            compare(loadingSpy.count, 0)
        }

        function test_linksActivateFromKeyboard() {
            link.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Return)
            compare(linkSpy.count, 1)

            linkPure.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Space)
            compare(linkPureSpy.count, 1)
        }

        function test_buttonPureKeyboardAndDisabled() {
            buttonPure.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Return)
            keyClick(Qt.Key_Space)
            compare(buttonPureSpy.count, 2)

            disabledPure.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Return)
            mouseClick(disabledPure, 2, 2, Qt.LeftButton)
            compare(disabledPureSpy.count, 0)
        }

        function test_inputEditingAndPasswordFocusRetention() {
            input.editorItem.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_P)
            keyClick(Qt.Key_O)
            keyClick(Qt.Key_R)
            keyClick(Qt.Key_S)
            keyClick(Qt.Key_C)
            keyClick(Qt.Key_H)
            keyClick(Qt.Key_E)
            compare(input.value, "porsche")

            password.editorItem.forceActiveFocus(Qt.TabFocusReason)
            verify(password.editorItem.activeFocus)
            password.togglePasswordVisibility()
            verify(password.showPassword)
            verify(password.editorItem.activeFocus)
        }

        function test_switchAndCheckboxSpace() {
            switchControl.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Space)
            compare(switchSpy.count, 1)

            checkbox.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Space)
            compare(checkboxSpy.count, 1)
            verify(checkbox.checked)
        }

        function test_radioArrowNavigation() {
            const firstOption = findChild(radios, "_radioOption0")
            verify(firstOption !== null)
            firstOption.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Right)
            compare(radios.value, "sport")
            compare(radioSpy.count, 1)
        }

        function test_selectKeyboardOpenSelectAndEscape() {
            const selectButton = findChild(select, "_selectButton")
            verify(selectButton !== null)
            selectButton.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Down)
            tryVerify(() => select.isOpen)
            keyClick(Qt.Key_Down)
            keyClick(Qt.Key_Return)
            compare(select.value, "911")
            compare(selectSpy.count, 1)
            keyClick(Qt.Key_Space)
            tryVerify(() => select.isOpen)
            keyClick(Qt.Key_Escape)
            tryVerify(() => !select.isOpen)
        }

        function test_tabsKeyboardNavigation() {
            const firstTab = findChild(tabs, "_tab_0")
            verify(firstTab !== null)
            firstTab.forceActiveFocus(Qt.TabFocusReason)
            keyClick(Qt.Key_Right)
            compare(tabs.activeTabIndex, 1)
            compare(tabsSpy.count, 1)
            keyClick(Qt.Key_End)
            compare(tabs.activeTabIndex, 2)
            keyClick(Qt.Key_Home)
            compare(tabs.activeTabIndex, 0)
        }

        function test_modalControlledDismissAndFocusRestore() {
            first.forceActiveFocus(Qt.TabFocusReason)
            verify(first.activeFocus)
            modal.open = true
            tryVerify(() => modal.opened)
            modal.requestDismiss()
            compare(modalDismissSpy.count, 1)
            tryVerify(() => !modal.opened)
            tryVerify(() => first.activeFocus)
        }
    }
}
