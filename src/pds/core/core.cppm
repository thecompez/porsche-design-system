module;
#include <QString>

export module pds.native.core;

export namespace pds::native::core {

/** Color schemes supported by Porsche Design System v4.4.0. */
enum class ColorScheme { Light, Dark, System };

/** Input required to resolve the inherited Porsche color scheme. */
struct ThemeState final {
    ColorScheme scheme{ColorScheme::System};
    bool systemDark{false};

    [[nodiscard]] auto operator==(const ThemeState&) const noexcept -> bool = default;
};

/** Side-effect-free color-scheme resolution shared with the QML singleton. */
class ThemeResolver final {
public:
    [[nodiscard]] static auto isDark(const ThemeState& state) noexcept -> bool;
};

/** Variants exposed by the official p-button component in v4.4.0. */
enum class ButtonVariant { Primary, Secondary };

/** Exact geometry extracted from the official v4.4.0 Button styles. */
struct ButtonGeometry final {
    int paddingBlock;
    int paddingInline;
    int gap;
    int radius;
    int fontSize;
    int lineHeight;
};

/** Source-locked Button measurements and motion values. */
class ButtonSpec final {
public:
    [[nodiscard]] static constexpr auto geometry(const bool compact) noexcept
        -> ButtonGeometry
    {
        return compact
            ? ButtonGeometry{6, 16, 4, 8, 16, 24}
            : ButtonGeometry{16, 28, 8, 12, 16, 24};
    }

    [[nodiscard]] static constexpr auto focusWidth() noexcept -> int { return 2; }
    [[nodiscard]] static constexpr auto focusOffset() noexcept -> int { return 2; }
    [[nodiscard]] static constexpr auto transitionDuration() noexcept -> int { return 250; }
    [[nodiscard]] static constexpr auto disabledOpacity() noexcept -> double { return 0.4; }
};

/** Font-family injection boundary for the restricted Porsche Next typeface. */
class TypographyResolver final {
public:
    explicit TypographyResolver(QString suppliedFamily = {});
    [[nodiscard]] auto family() const -> const QString&;

private:
    QString m_family;
};

}
