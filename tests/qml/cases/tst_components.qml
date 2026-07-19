import QtQuick
import QtTest
import Pds.Native
import Pds.Native as Pds

TestCase {
    name: "ButtonComponent"
    when: windowShown

    Component { id: buttonComponent; Button { text: "Continue" } }
    Component { id: iconComponent; Pds.Icon {} }
    Component { id: textComponent; Pds.Text { text: "Body" } }
    Component { id: headingComponent; Pds.Heading { text: "Title" } }
    Component { id: dividerComponent; Pds.Divider {} }
    Component { id: linkComponent; Pds.Link { text: "Visit" } }
    Component { id: linkPureComponent; Pds.LinkPure { text: "Learn more" } }
    Component { id: buttonPureComponent; Pds.ButtonPure { text: "Continue" } }
    Component { id: inputTextComponent; Pds.InputText { label: "Name" } }
    Component { id: inputPasswordComponent; Pds.InputPassword { label: "Password"; toggle: true } }
    Component { id: switchComponent; Pds.Switch { text: "Enabled" } }
    Component { id: checkboxComponent; Pds.Checkbox { text: "Accept" } }
    Component {
        id: radioGroupComponent
        Pds.RadioGroup {
            label: "Mode"
            value: "normal"
            options: [
                { label: "Normal", value: "normal" },
                { label: "Sport", value: "sport", disabled: true },
                { label: "Individual", value: "individual" }
            ]
        }
    }
    Component {
        id: selectComponent
        Pds.Select {
            label: "Model"
            value: "911"
            options: [
                { text: "718", value: "718" },
                { text: "911", value: "911" }
            ]
        }
    }
    Component {
        id: inlineNotificationComponent
        Pds.InlineNotification {
            heading: "Charging complete"
            description: "The vehicle is ready."
        }
    }
    Component {
        id: bannerComponent
        Pds.Banner {
            heading: "Important"
            description: "Service information"
        }
    }
    Component { id: tagComponent; Pds.Tag { text: "Electric" } }
    Component {
        id: tabsComponent
        Pds.Tabs {
            accessibleName: "Vehicle sections"
            items: [
                { label: "Overview", content: "Overview panel" },
                { label: "Charging", content: "Charging panel" }
            ]
        }
    }
    Component {
        id: modalComponent
        Pds.Modal {
            heading: "Confirm"
            description: "Continue with this action?"
        }
    }

    function cleanup() {
        Theme.mode = Theme.System
        Theme.fontFamily = ""
    }

    function test_officialDefaults() {
        const button = createTemporaryObject(buttonComponent, this)
        compare(button.variant, Button.Primary)
        compare(button.buttonType, Button.Submit)
        verify(!button.disabled)
        verify(!button.loading)
        verify(!button.compact)
        verify(!button.hideLabel)
        compare(button.implicitHeight, 56)
        compare(button.leftPadding, 28)
        compare(button.rightPadding, 28)
        compare(button.background.radius, 12)
    }

    function test_compactGeometry() {
        const button = createTemporaryObject(buttonComponent, this, { compact: true })
        compare(button.implicitHeight, 36)
        compare(button.topPadding, 6)
        compare(button.leftPadding, 16)
        compare(button.controlGap, 4)
        compare(button.background.radius, 8)
    }

    function test_hideLabelGeometry() {
        const button = createTemporaryObject(buttonComponent, this, {
            hideLabel: true,
            iconSource: "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg'/%3E"
        })
        compare(button.implicitWidth, 56)
        compare(button.background.radius, Tokens.radiusFull)
        compare(button.Accessible.name, "Continue")
    }

    function test_themeResolution() {
        const button = createTemporaryObject(buttonComponent, this)
        Theme.mode = Theme.Light
        compare(String(button.background.color), String(Tokens.colorPrimaryLight))
        Theme.mode = Theme.Dark
        tryCompare(Theme, "effectiveDark", true)
        tryCompare(Tokens, "colorPrimary", Tokens.colorPrimaryDark)
        tryCompare(button.background, "color", Tokens.colorPrimaryDark)
    }

    function test_onlyOfficialVariants() {
        compare(Button.Primary, 0)
        compare(Button.Secondary, 1)
        verify(Button.Tertiary === undefined)
        verify(Button.Ghost === undefined)
        verify(Button.Danger === undefined)
    }

    function test_phase1OfficialDefaults() {
        const icon = createTemporaryObject(iconComponent, this)
        compare(icon.name, "arrow-right")
        compare(icon.size, Pds.Icon.SizeSm)
        compare(icon.semanticColor, Pds.Icon.Primary)
        verify(icon.missing)
        compare(icon.implicitWidth, 24)

        const body = createTemporaryObject(textComponent, this)
        compare(body.size, Pds.Text.SizeSm)
        compare(body.weight, Pds.Text.Normal)
        compare(body.semanticColor, Pds.Text.Primary)
        compare(body.font.pixelSize, 16)

        const heading = createTemporaryObject(headingComponent, this)
        compare(heading.size, Pds.Heading.Size2Xl)
        compare(heading.effectiveLevel, 2)
        verify(heading.font.pixelSize >= 25.6)

        const divider = createTemporaryObject(dividerComponent, this)
        compare(divider.direction, Pds.Divider.Horizontal)
        compare(divider.implicitHeight, 1)
        compare(divider.semanticColor, Pds.Divider.ContrastLower)

        const link = createTemporaryObject(linkComponent, this)
        compare(link.variant, Pds.Link.Primary)
        compare(link.Accessible.role, Accessible.Link)
        compare(link.implicitHeight, 56)

        const pure = createTemporaryObject(linkPureComponent, this)
        compare(pure.alignLabel, Pds.LinkPure.End)
        compare(pure.iconName, "arrow-right")
        compare(pure.size, Pds.LinkPure.SizeSm)
        compare(pure.Accessible.role, Accessible.Link)
    }

    function test_phase1SemanticMappings() {
        const body = createTemporaryObject(textComponent, this, {
            size: Pds.Text.SizeXs,
            weight: Pds.Text.Bold,
            semanticColor: Pds.Text.Error
        })
        compare(body.font.pixelSize, 14)
        compare(body.font.weight, Tokens.fontWeightBold)
        compare(String(body.color), String(Tokens.colorError))

        const vertical = createTemporaryObject(dividerComponent, this, {
            direction: Pds.Divider.Vertical,
            semanticColor: Pds.Divider.ContrastHigh
        })
        compare(vertical.implicitWidth, 1)
        compare(vertical.implicitHeight, 160)
        compare(String(vertical.color), String(Tokens.colorContrastHigh))
    }

    function test_buttonPureContract() {
        const pure = createTemporaryObject(buttonPureComponent, this)
        compare(pure.buttonType, Pds.ButtonPure.Submit)
        compare(pure.size, Pds.ButtonPure.SizeSm)
        compare(pure.semanticColor, Pds.ButtonPure.Primary)
        compare(pure.iconName, "arrow-right")
        verify(pure.interactive)
        compare(pure.Accessible.role, Accessible.Button)

        pure.loading = true
        verify(!pure.interactive)
        verify(pure.accessibilityDisabled)
        compare(pure.Accessible.description, "Loading")

        pure.loading = false
        pure.disabled = true
        verify(!pure.interactive)
        compare(String(pure.foregroundColor), String(Tokens.colorContrastLow))
    }

    function test_formGeometryAndContracts() {
        const input = createTemporaryObject(inputTextComponent, this)
        compare(input.fieldHeight, 56)
        compare(input.implicitWidth, 320)
        compare(input.editorItem.maximumLength, 32767)
        input.compact = true
        compare(input.fieldHeight, 36)
        input.state = "error"
        verify(input.invalid)
        compare(String(input.stateBorder), String(Tokens.colorError))

        const password = createTemporaryObject(inputPasswordComponent, this)
        verify(!password.showPassword)
        compare(password.echoMode, TextInput.Password)
        password.togglePasswordVisibility()
        verify(password.showPassword)

        const toggle = createTemporaryObject(switchComponent, this)
        compare(toggle.trackWidth, 48)
        compare(toggle.trackHeight, 28)
        compare(toggle.thumbExtent, 20)
        toggle.compact = true
        compare(Math.round(toggle.trackHeight), 18)

        const checkbox = createTemporaryObject(checkboxComponent, this)
        compare(checkbox.indicatorExtent, 28)
        checkbox.compact = true
        compare(checkbox.indicatorExtent, 18)

        const radios = createTemporaryObject(radioGroupComponent, this)
        compare(radios.currentIndex, 0)
        compare(radios.findEnabled(0, 1), 2)

        const select = createTemporaryObject(selectComponent, this)
        compare(select.currentIndex, 1)
        compare(select.currentText, "911")
        compare(select.compact, false)
    }

    function test_feedbackAndStatusContracts() {
        const notification = createTemporaryObject(
                    inlineNotificationComponent, this)
        compare(notification.state, "info")
        compare(notification.heading, "Charging complete")
        compare(String(notification.panelColor), String(Tokens.colorInfoFrosted))
        verify(notification.dismissButton)

        const banner = createTemporaryObject(bannerComponent, this)
        verify(!banner.open)
        compare(banner.position, 0)
        compare(banner.state, "info")

        const tag = createTemporaryObject(tagComponent, this)
        compare(tag.variant, Pds.Tag.Secondary)
        compare(tag.implicitHeight, 32)
        compare(tag.Accessible.role, Accessible.StaticText)
        tag.compact = true
        compare(tag.implicitHeight, 28)
    }

    function test_tabsAndModalContracts() {
        const tabs = createTemporaryObject(tabsComponent, this)
        compare(tabs.itemCount, 2)
        compare(tabs.activeTabIndex, 0)
        compare(tabs.tabHeight, 56)
        compare(tabs.activeContent, "Overview panel")
        tabs.select(1, false)
        compare(tabs.activeTabIndex, 1)
        compare(tabs.activeContent, "Charging panel")
        tabs.compact = true
        compare(tabs.tabHeight, 36)

        const modal = createTemporaryObject(modalComponent, this)
        verify(!modal.open)
        verify(!modal.opened)
        compare(modal.backdrop, Pds.Modal.Blur)
        compare(modal.backgroundStyle, Pds.Modal.Canvas)
        verify(modal.dismissButton)
        verify(modal.panelWidth >= 276)
        verify(modal.panelWidth <= 640)
    }

}
