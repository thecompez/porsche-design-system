// Qt Test's generated entry point is an external tooling boundary.
#include <QtTest>

import pds.native.core;

namespace {

using namespace pds::native::core;

class CoreTests final : public QObject {
    Q_OBJECT

private slots:
    auto resolvesOfficialThemeSchemes() -> void
    {
        QVERIFY(!ThemeResolver::isDark({.scheme = ColorScheme::Light, .systemDark = true}));
        QVERIFY(ThemeResolver::isDark({.scheme = ColorScheme::Dark}));
        QVERIFY(ThemeResolver::isDark({.scheme = ColorScheme::System, .systemDark = true}));
    }

    auto exposesExtractedButtonGeometry() -> void
    {
        const auto regular = ButtonSpec::geometry(false);
        QCOMPARE(regular.paddingBlock, 16);
        QCOMPARE(regular.paddingInline, 28);
        QCOMPARE(regular.gap, 8);
        QCOMPARE(regular.radius, 12);
        QCOMPARE(regular.fontSize, 16);
        QCOMPARE(regular.lineHeight, 24);

        const auto compact = ButtonSpec::geometry(true);
        QCOMPARE(compact.paddingBlock, 6);
        QCOMPARE(compact.paddingInline, 16);
        QCOMPARE(compact.gap, 4);
        QCOMPARE(compact.radius, 8);
    }

    auto exposesExtractedButtonStateValues() -> void
    {
        QCOMPARE(ButtonSpec::focusWidth(), 2);
        QCOMPARE(ButtonSpec::focusOffset(), 2);
        QCOMPARE(ButtonSpec::transitionDuration(), 250);
        QCOMPARE(ButtonSpec::disabledOpacity(), 0.4);
    }

    auto supportsLicensedFontInjection() -> void
    {
        const TypographyResolver supplied{"Porsche Next"};
        QCOMPARE(supplied.family(), QString{"Porsche Next"});

        const TypographyResolver fallback;
        QVERIFY(!fallback.family().isEmpty());
    }
};

}

QTEST_MAIN(CoreTests)
#include "core_tests.moc"
