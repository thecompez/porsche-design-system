module;

#include <QFontDatabase>
#include <QStringList>

module pds.native.core;

#include <utility>

namespace pds::native::core {

auto ThemeResolver::isDark(const ThemeState& state) noexcept -> bool
{
    return state.scheme == ColorScheme::Dark
        || (state.scheme == ColorScheme::System && state.systemDark);
}

TypographyResolver::TypographyResolver(QString suppliedFamily)
    : m_family(std::move(suppliedFamily))
{
    if (m_family.isEmpty()) {
        // Porsche Next is a restricted asset and is intentionally not bundled.
        // General fallback typography must not be artificially stretched.
        m_family = QStringLiteral("Arial");
        if (!QFontDatabase::families().contains(m_family)) {
            m_family = QFontDatabase::systemFont(QFontDatabase::GeneralFont).family();
        }
    }
}

auto TypographyResolver::family() const -> const QString&
{
    return m_family;
}

}
