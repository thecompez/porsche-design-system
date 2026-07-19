import QtQuick
import QtTest
import Pds.Native

Rectangle {
    id: root
    width: 720
    height: 520
    color: Tokens.colorCanvas

    Grid {
        id: scene
        anchors.centerIn: parent
        columns: 2
        spacing: Tokens.spacingStaticMd

        Button { id: primary; text: "Primary" }
        Button { text: "Secondary"; variant: Button.Secondary }
        Button { text: "Compact"; compact: true }
        Button { text: "Compact"; compact: true; variant: Button.Secondary }
        Button { text: "Disabled"; disabled: true }
        Button { text: "Disabled"; disabled: true; variant: Button.Secondary }
        Button { text: "Loading"; loading: true }
        Button { text: "Loading"; loading: true; variant: Button.Secondary }
    }

    TestCase {
        name: "ButtonVisualInfrastructure"
        when: windowShown

        function captureScenario(name) {
            waitForRendering(root)
            wait(Motion.durationSm + 50)
            const image = grabImage(root)
            verify(image.width > 0)
            verify(image.height > 0)
            image.save("button-" + name + ".png")
        }

        function test_lightDarkAndFocusCaptures() {
            Theme.mode = Theme.Light
            captureScenario("light")

            const interaction = findChild(primary, "_buttonInteractionArea")
            verify(interaction !== null)
            interaction.visualHovered = true
            captureScenario("hover")
            // Upstream v4.4.0 defines no separate :active selector.
            captureScenario("active")
            interaction.visualHovered = false

            Theme.mode = Theme.Dark
            captureScenario("dark")

            Theme.mode = Theme.Light
            primary.forceActiveFocus(Qt.TabFocusReason)
            tryVerify(() => primary.activeFocus)
            captureScenario("focus")

            root.LayoutMirroring.enabled = true
            root.LayoutMirroring.childrenInherit = true
            captureScenario("rtl")
            root.LayoutMirroring.enabled = false
            Theme.mode = Theme.System
        }
    }
}
