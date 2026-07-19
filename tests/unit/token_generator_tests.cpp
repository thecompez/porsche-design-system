// Qt Test's generated entry point is an external tooling boundary.
#include <QTemporaryDir>
#include <QtTest>

import pds.native.token.generator;

namespace {

class TokenGeneratorTests final : public QObject {
    Q_OBJECT

private slots:
    auto acceptsValidSource() -> void
    {
        const pds::native::token::Generator generator;
        const auto result = generator.validate(R"({
            "tokens": [
                {"id":"spacingBase","category":"spacing","type":"number","value":8,"description":"Base."},
                {"id":"spacingAlias","category":"spacing","type":"number","alias":"{spacingBase}","description":"Alias."}
            ]
        })");
        QVERIFY2(result.success, qPrintable(result.diagnostics.join('\n')));
    }

    auto rejectsMalformedJson() -> void
    {
        const pds::native::token::Generator generator;
        const auto result = generator.validate("{");
        QVERIFY(!result.success);
        QVERIFY(result.diagnostics.constFirst().contains("parse error"));
    }

    auto rejectsDuplicateIdentifiers() -> void
    {
        const pds::native::token::Generator generator;
        const auto result = generator.validate(R"({
            "tokens": [
                {"id":"same","category":"spacing","type":"number","value":1,"description":"First."},
                {"id":"same","category":"spacing","type":"number","value":2,"description":"Second."}
            ]
        })");
        QVERIFY(!result.success);
        QVERIFY(result.diagnostics.join('\n').contains("Duplicate"));
    }

    auto rejectsUnknownAlias() -> void
    {
        const pds::native::token::Generator generator;
        const auto result = generator.validate(R"({
            "tokens": [
                {"id":"alias","category":"spacing","type":"number","alias":"{missing}","description":"Unknown."}
            ]
        })");
        QVERIFY(!result.success);
        QVERIFY(result.diagnostics.join('\n').contains("unknown alias"));
    }

    auto rejectsCircularAlias() -> void
    {
        const pds::native::token::Generator generator;
        const auto result = generator.validate(R"({
            "tokens": [
                {"id":"first","category":"spacing","type":"number","alias":"{second}","description":"First."},
                {"id":"second","category":"spacing","type":"number","alias":"{first}","description":"Second."}
            ]
        })");
        QVERIFY(!result.success);
        QVERIFY(result.diagnostics.join('\n').contains("Circular"));
    }

    auto rejectsCategoryTypeMismatch() -> void
    {
        const pds::native::token::Generator generator;
        const auto result = generator.validate(R"({
            "tokens": [
                {"id":"wrong","category":"color","type":"number","value":12,"description":"Wrong."}
            ]
        })");
        QVERIFY(!result.success);
        QVERIFY(result.diagnostics.join('\n').contains("incompatible"));
    }

    auto rejectsInvalidLiteralType() -> void
    {
        const pds::native::token::Generator generator;
        const auto result = generator.validate(R"({
            "tokens": [
                {"id":"wrongColor","category":"color","type":"color","value":12,"description":"Wrong literal."}
            ]
        })");
        QVERIFY(!result.success);
        QVERIFY(result.diagnostics.join('\n').contains("invalid for type"));
    }

    auto emitsDeterministicallySortedArtifacts() -> void
    {
        const pds::native::token::Generator generator;
        const auto first = generator.validate(R"({
            "tokens": [
                {"id":"zeta","category":"spacing","type":"number","value":2,"description":"Z."},
                {"id":"alpha","category":"spacing","type":"number","value":1,"description":"A."}
            ]
        })");
        QVERIFY(first.success);

        QVector<pds::native::token::Token> tokens{
            {"zeta", "spacing", "number", QJsonObject{
                {"id", "zeta"}, {"category", "spacing"}, {"type", "number"},
                {"value", 2}, {"description", "Z."}}},
            {"alpha", "spacing", "number", QJsonObject{
                {"id", "alpha"}, {"category", "spacing"}, {"type", "number"},
                {"value", 1}, {"description", "A."}}},
        };
        std::ranges::sort(tokens, {}, &pds::native::token::Token::id);
        const auto qmlA = generator.qml(tokens);
        const auto qmlB = generator.qml(tokens);
        QCOMPARE(qmlA, qmlB);
        QVERIFY(qmlA.indexOf("alpha") < qmlA.indexOf("zeta"));
        QCOMPARE(generator.cpp(tokens), generator.cpp(tokens));
        QCOMPARE(generator.markdown(tokens), generator.markdown(tokens));
    }
};

}

QTEST_APPLESS_MAIN(TokenGeneratorTests)
#include "token_generator_tests.moc"
