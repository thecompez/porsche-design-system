module;
#include <QByteArray>
#include <QJsonObject>
#include <QString>
#include <QStringList>
#include <QVector>

export module pds.native.token.generator;

import std;

export namespace pds::native::token {

/** A validated design-token record retained by the generation pipeline. */
struct Token final {
    QString id;
    QString category;
    QString type;
    QJsonObject source;
};

/** Result returned by validation or generation without throwing across APIs. */
struct Result final {
    bool success{false};
    QStringList diagnostics;

    [[nodiscard]] explicit operator bool() const noexcept
    {
        return success;
    }
};

/**
 * Parses, validates, resolves, and deterministically emits all token artifacts.
 *
 * This type has value semantics and owns no external resources. Files are
 * replaced only when their content changes.
 */
class Generator final {
public:
    /** @brief Validates token JSON without writing output. */
    [[nodiscard]] auto validate(const QByteArray& source) const -> Result;
    /** @brief Validates inputs and writes all three generated artifacts. */
    [[nodiscard]] auto generate(
        const QString& schemaPath,
        const QString& sourcePath,
        const QString& outputDirectory
    ) const -> Result;

    /** @brief Emits the QML singleton from sorted validated tokens. */
    [[nodiscard]] static auto qml(const QVector<Token>& tokens) -> QByteArray;
    /** @brief Emits the typed C++ module from sorted validated tokens. */
    [[nodiscard]] static auto cpp(const QVector<Token>& tokens) -> QByteArray;
    /** @brief Emits the generated Markdown reference. */
    [[nodiscard]] static auto markdown(const QVector<Token>& tokens) -> QByteArray;
};

}
