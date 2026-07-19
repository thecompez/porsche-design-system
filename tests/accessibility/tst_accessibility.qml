import QtQuick
import QtTest
import Pds.Native
import Pds.Native as Pds

TestCase {
    name: "ButtonAccessibility"
    when: windowShown

    Component { id: buttonComponent; Button { text: "Continue" } }
    Component { id: iconComponent; Icon { accessibleName: "Continue arrow" } }
    Component { id: decorativeIconComponent; Icon {} }
    Component { id: textComponent; Text { text: "Body copy" } }
    Component { id: headingComponent; Heading { text: "Page title"; level: 1 } }
    Component { id: dividerComponent; Divider {} }
    Component { id: linkComponent; Link { text: "Details" } }
    Component { id: linkPureComponent; LinkPure { text: "More" } }
    Component { id: buttonPureComponent; ButtonPure { text: "Continue" } }
    Component { id: inputComponent; Pds.InputText { label: "Name"; description: "Full name" } }
    Component { id: passwordComponent; Pds.InputPassword { label: "Password"; toggle: true } }
    Component { id: switchComponent; Pds.Switch { text: "Notifications" } }
    Component { id: checkboxComponent; Pds.Checkbox { text: "Accept terms" } }
    Component {
        id: radioComponent
        Pds.RadioGroup {
            label: "Mode"
            options: [{label: "Normal", value: "normal"}]
        }
    }
    Component {
        id: selectComponent
        Pds.Select {
            label: "Model"
            options: [{text: "911", value: "911"}]
        }
    }
    Component {
        id: notificationComponent
        Pds.InlineNotification {
            heading: "Warning"
            description: "Check charging cable"
            state: "warning"
        }
    }
    Component { id: tagComponent; Pds.Tag { text: "Hybrid" } }
    Component {
        id: tabsComponent
        Pds.Tabs {
            accessibleName: "Vehicle sections"
            accessibleDescription: "Choose a section"
            items: [{label: "Overview", content: "Overview"}]
        }
    }
    Component {
        id: modalComponent
        Pds.Modal {
            accessibleName: "Confirmation"
            description: "Confirm this action"
        }
    }

    function test_roleNameAndFocusability() {
        const button = createTemporaryObject(buttonComponent, this)
        compare(button.Accessible.role, Accessible.Button)
        compare(button.Accessible.name, "Continue")
        verify(button.Accessible.focusable)
        verify(!button.accessibilityDisabled)
    }

    function test_disabledExposure() {
        const button = createTemporaryObject(buttonComponent, this, { disabled: true })
        verify(button.accessibilityDisabled)
    }

    function test_loadingExposure() {
        const button = createTemporaryObject(buttonComponent, this, { loading: true })
        verify(button.accessibilityDisabled)
        compare(button.Accessible.description, "Loading")
        verify(button.activeFocusOnTab)
    }

    function test_hiddenLabelRetainsAccessibleName() {
        const button = createTemporaryObject(buttonComponent, this, { hideLabel: true })
        compare(button.Accessible.name, "Continue")
    }

    function test_phase1RolesAndNames() {
        const icon = createTemporaryObject(iconComponent, this)
        compare(icon.Accessible.role, Accessible.Graphic)
        compare(icon.Accessible.name, "Continue arrow")
        verify(!icon.Accessible.ignored)

        const decorative = createTemporaryObject(decorativeIconComponent, this)
        verify(decorative.Accessible.ignored)

        const body = createTemporaryObject(textComponent, this)
        compare(body.Accessible.role, Accessible.StaticText)
        compare(body.Accessible.name, "Body copy")

        const heading = createTemporaryObject(headingComponent, this)
        compare(heading.Accessible.role, Accessible.Heading)
        compare(heading.effectiveLevel, 1)

        const divider = createTemporaryObject(dividerComponent, this)
        compare(divider.Accessible.role, Accessible.Separator)

        const link = createTemporaryObject(linkComponent, this)
        compare(link.Accessible.role, Accessible.Link)
        compare(link.Accessible.name, "Details")

        const pure = createTemporaryObject(linkPureComponent, this)
        compare(pure.Accessible.role, Accessible.Link)
        compare(pure.Accessible.name, "More")
    }

    function test_buttonPureAccessibility() {
        const pure = createTemporaryObject(buttonPureComponent, this)
        compare(pure.Accessible.role, Accessible.Button)
        compare(pure.Accessible.name, "Continue")
        verify(pure.Accessible.focusable)
        verify(!pure.accessibilityDisabled)

        pure.loading = true
        verify(pure.accessibilityDisabled)
        compare(pure.Accessible.description, "Loading")
    }

    function test_formAccessibility() {
        const input = createTemporaryObject(inputComponent, this)
        compare(input.editorItem.Accessible.role, Accessible.EditableText)
        compare(input.editorItem.Accessible.name, "Name")
        verify(input.editorItem.Accessible.description.includes("Full name"))

        const password = createTemporaryObject(passwordComponent, this)
        compare(password.editorItem.Accessible.name, "Password")

        const toggle = createTemporaryObject(switchComponent, this)
        compare(toggle.Accessible.role, Accessible.Button)
        verify(toggle.Accessible.checkable)

        const checkbox = createTemporaryObject(checkboxComponent, this)
        compare(checkbox.Accessible.role, Accessible.CheckBox)
        compare(checkbox.Accessible.name, "Accept terms")

        const radios = createTemporaryObject(radioComponent, this)
        compare(radios.Accessible.role, Accessible.Grouping)
        compare(radios.Accessible.name, "Mode")

        const select = createTemporaryObject(selectComponent, this)
        const selectButton = findChild(select, "_selectButton")
        compare(selectButton.Accessible.role, Accessible.ComboBox)
        compare(selectButton.Accessible.name, "Model")
    }

    function test_feedbackTabsAndModalAccessibility() {
        const notification = createTemporaryObject(notificationComponent, this)
        compare(notification.Accessible.role, Accessible.AlertMessage)
        compare(notification.Accessible.name, "Warning")

        const tag = createTemporaryObject(tagComponent, this)
        compare(tag.Accessible.role, Accessible.StaticText)
        compare(tag.Accessible.name, "Hybrid")

        const tabs = createTemporaryObject(tabsComponent, this)
        const tabList = findChild(tabs, "_tabList")
        compare(tabList.Accessible.role, Accessible.PageTabList)
        compare(tabList.Accessible.name, "Vehicle sections")
        const tab = findChild(tabs, "_tab_0")
        compare(tab.Accessible.role, Accessible.PageTab)
        verify(tab.Accessible.selected)

        const modal = createTemporaryObject(modalComponent, this)
        const panel = findChild(modal, "_modalPanel")
        compare(panel.Accessible.role, Accessible.Dialog)
        compare(panel.Accessible.name, "Confirmation")
    }
}
