#include <QColor>
#include <QCoreApplication>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QImage>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QPoint>
#include <QQueue>
#include <QRect>
#include <QString>
#include <QTextStream>

#include <algorithm>
#include <array>
#include <cmath>
#include <ranges>

namespace {

struct ImageMetrics final {
    QString state;
    double pixelSimilarity{};
    double structuralSimilarity{};
    double meanColorDelta{};
};

auto isForeground(const QRgb pixel, const QRgb background) -> bool
{
    return std::max({
        std::abs(qRed(pixel) - qRed(background)),
        std::abs(qGreen(pixel) - qGreen(background)),
        std::abs(qBlue(pixel) - qBlue(background)),
    }) > 8;
}

auto maskFor(const QImage& source) -> QImage
{
    const auto image = source.convertToFormat(QImage::Format_RGB32);
    QImage mask{image.size(), QImage::Format_Grayscale8};
    const auto background = image.pixel(0, 0);
    for (auto y = 0; y < image.height(); ++y) {
        auto* line = mask.scanLine(y);
        for (auto x = 0; x < image.width(); ++x) {
            line[x] = isForeground(image.pixel(x, y), background) ? 255 : 0;
        }
    }
    return mask;
}

auto components(const QImage& mask) -> QList<QRect>
{
    const auto width = mask.width();
    const auto height = mask.height();
    QByteArray visited(width * height, '\0');
    QList<QRect> result;
    constexpr std::array<QPoint, 4> neighbours{
        QPoint{-1, 0}, QPoint{1, 0}, QPoint{0, -1}, QPoint{0, 1}
    };

    for (auto y = 0; y < height; ++y) {
        for (auto x = 0; x < width; ++x) {
            const auto index = y * width + x;
            if (visited[index] || mask.constScanLine(y)[x] == 0) {
                continue;
            }

            QQueue<QPoint> queue;
            queue.enqueue({x, y});
            visited[index] = '\1';
            auto left = x;
            auto right = x;
            auto top = y;
            auto bottom = y;
            auto area = 0;

            while (!queue.isEmpty()) {
                const auto point = queue.dequeue();
                ++area;
                left = std::min(left, point.x());
                right = std::max(right, point.x());
                top = std::min(top, point.y());
                bottom = std::max(bottom, point.y());
                for (const auto delta : neighbours) {
                    const auto next = point + delta;
                    if (next.x() < 0 || next.x() >= width
                        || next.y() < 0 || next.y() >= height) {
                        continue;
                    }
                    const auto nextIndex = next.y() * width + next.x();
                    if (!visited[nextIndex]
                        && mask.constScanLine(next.y())[next.x()] != 0) {
                        visited[nextIndex] = '\1';
                        queue.enqueue(next);
                    }
                }
            }

            if (area > 100) {
                result.append(QRect{QPoint{left, top}, QPoint{right, bottom}});
            }
        }
    }

    std::ranges::sort(result, [](const QRect& left, const QRect& right) {
        if (std::abs(left.y() - right.y()) > 2) {
            return left.y() < right.y();
        }
        return left.x() < right.x();
    });
    return result;
}

auto compareImages(
    const QString& state,
    const QImage& referenceSource,
    const QImage& actualSource,
    const QString& diffPath,
    const QString& overlayPath
) -> ImageMetrics
{
    const auto reference = referenceSource.convertToFormat(QImage::Format_RGB32);
    const auto actual = actualSource.convertToFormat(QImage::Format_RGB32);
    const auto referenceMask = maskFor(reference);
    const auto actualMask = maskFor(actual);

    QImage diff{reference.size(), QImage::Format_RGB32};
    QImage overlay{reference.size(), QImage::Format_RGB32};
    double totalDelta = 0;
    qsizetype intersection = 0;
    qsizetype maskUnion = 0;

    for (auto y = 0; y < reference.height(); ++y) {
        for (auto x = 0; x < reference.width(); ++x) {
            const QColor referenceColor{reference.pixel(x, y)};
            const QColor actualColor{actual.pixel(x, y)};
            const auto red = std::abs(referenceColor.red() - actualColor.red());
            const auto green = std::abs(referenceColor.green() - actualColor.green());
            const auto blue = std::abs(referenceColor.blue() - actualColor.blue());
            totalDelta += red + green + blue;
            diff.setPixelColor(
                x,
                y,
                QColor{
                    std::min(255, red * 4),
                    std::min(255, green * 4),
                    std::min(255, blue * 4),
                }
            );
            overlay.setPixelColor(
                x,
                y,
                QColor{
                    (referenceColor.red() + actualColor.red()) / 2,
                    (referenceColor.green() + actualColor.green()) / 2,
                    (referenceColor.blue() + actualColor.blue()) / 2,
                }
            );

            const auto referenceForeground = referenceMask.constScanLine(y)[x] != 0;
            const auto actualForeground = actualMask.constScanLine(y)[x] != 0;
            intersection += referenceForeground && actualForeground;
            maskUnion += referenceForeground || actualForeground;
        }
    }

    diff.save(diffPath);
    overlay.save(overlayPath);
    const auto channelCount = double(reference.width()) * reference.height() * 3.0;
    return {
        state,
        1.0 - totalDelta / (channelCount * 255.0),
        maskUnion == 0 ? 1.0 : double(intersection) / double(maskUnion),
        totalDelta / channelCount,
    };
}

auto rectToJson(const QRect& rect) -> QJsonObject
{
    return {
        {"x", rect.x()},
        {"y", rect.y()},
        {"width", rect.width()},
        {"height", rect.height()},
    };
}

auto argumentValue(const QStringList& arguments, const QString& name) -> QString
{
    const auto index = arguments.indexOf(name);
    return index >= 0 && index + 1 < arguments.size() ? arguments[index + 1] : QString{};
}

auto officialReferenceRects(const QString& metricsPath) -> QList<QRect>
{
    QFile file{metricsPath};
    if (!file.open(QIODevice::ReadOnly)) {
        return {};
    }
    const auto document = QJsonDocument::fromJson(file.readAll());
    QList<QRect> result;
    for (const auto value : document.object().value("buttons").toArray()) {
        const auto object = value.toObject();
        const auto x = object.value("x").toDouble();
        const auto y = object.value("y").toDouble();
        const auto width = object.value("width").toDouble();
        const auto height = object.value("height").toDouble();
        const auto left = int(std::ceil(x - 0.5));
        const auto top = int(std::ceil(y - 0.5));
        const auto right = int(std::floor(x + width - 0.5));
        const auto bottom = int(std::floor(y + height - 0.5));
        result.append(QRect{
            QPoint{left, top},
            QPoint{right, bottom},
        });
    }
    return result;
}

auto rectangleSimilarity(const QList<QRect>& reference, const QList<QRect>& actual)
    -> double
{
    if (reference.size() != actual.size() || reference.isEmpty()) {
        return 0;
    }
    auto total = 0.0;
    for (auto index = 0; index < reference.size(); ++index) {
        const auto intersection = reference[index].intersected(actual[index]);
        const auto intersectionArea = intersection.width() * intersection.height();
        const auto unionArea = reference[index].width() * reference[index].height()
            + actual[index].width() * actual[index].height() - intersectionArea;
        total += unionArea == 0 ? 1.0 : double(intersectionArea) / unionArea;
    }
    return total / reference.size();
}

}

auto main(int argc, char* argv[]) -> int
{
    const QCoreApplication application{argc, argv};
    const auto arguments = QCoreApplication::arguments();
    const auto referenceDirectory = argumentValue(arguments, "--reference-dir");
    const auto actualInputDirectory = argumentValue(arguments, "--actual-input-dir");
    const auto actualOutputDirectory = argumentValue(arguments, "--actual-output-dir");
    const auto diffDirectory = argumentValue(arguments, "--diff-dir");
    const auto reportPath = argumentValue(arguments, "--report");

    if (referenceDirectory.isEmpty() || actualInputDirectory.isEmpty()
        || actualOutputDirectory.isEmpty() || diffDirectory.isEmpty()
        || reportPath.isEmpty()) {
        qCritical("Missing visual comparison directory argument.");
        return 2;
    }

    QDir{}.mkpath(actualOutputDirectory);
    QDir{}.mkpath(diffDirectory);
    QDir{}.mkpath(QFileInfo{reportPath}.absolutePath());

    const QStringList states{"light", "hover", "active", "dark", "focus", "rtl"};
    QList<ImageMetrics> metrics;
    QList<QRect> referenceComponents;
    QList<QRect> actualComponents;

    for (const auto& state : states) {
        const auto referencePath = referenceDirectory + "/button-" + state + ".png";
        const auto actualInputPath = actualInputDirectory + "/button-" + state + ".png";
        const QImage reference{referencePath};
        const QImage actual{actualInputPath};
        if (reference.isNull() || actual.isNull() || reference.size() != actual.size()) {
            qCritical("Missing or mismatched visual input for state %s.", qPrintable(state));
            return 2;
        }

        actual.save(actualOutputDirectory + "/button-" + state + ".png");
        metrics.append(compareImages(
            state,
            reference,
            actual,
            diffDirectory + "/button-" + state + "-diff.png",
            diffDirectory + "/button-" + state + "-overlay.png"
        ));
        if (state == "light") {
            referenceComponents = officialReferenceRects(
                referenceDirectory + "/button-metrics.json"
            );
            actualComponents = components(maskFor(actual));
        }
    }

    auto maximumBoundsDeviation = 999;
    auto maximumWidthDeviation = 999;
    auto maximumHeightDeviation = 999;
    if (referenceComponents.size() == 8 && actualComponents.size() == 8) {
        maximumBoundsDeviation = 0;
        maximumWidthDeviation = 0;
        maximumHeightDeviation = 0;
        for (auto index = 0; index < 8; ++index) {
            const auto& reference = referenceComponents[index];
            const auto& actual = actualComponents[index];
            maximumWidthDeviation = std::max(
                maximumWidthDeviation,
                std::abs(reference.width() - actual.width())
            );
            maximumHeightDeviation = std::max(
                maximumHeightDeviation,
                std::abs(reference.height() - actual.height())
            );
            maximumBoundsDeviation = std::max({
                maximumBoundsDeviation,
                std::abs(reference.x() - actual.x()),
                std::abs(reference.y() - actual.y()),
                std::abs(reference.width() - actual.width()),
                std::abs(reference.height() - actual.height()),
            });
        }
    }

    auto pixelMaskScore = 0.0;
    auto pixelScore = 0.0;
    auto meanColorDelta = 0.0;
    for (const auto& metric : metrics) {
        pixelMaskScore += metric.structuralSimilarity;
        pixelScore += metric.pixelSimilarity;
        meanColorDelta += metric.meanColorDelta;
    }
    pixelMaskScore /= metrics.size();
    pixelScore /= metrics.size();
    meanColorDelta /= metrics.size();
    const auto structuralScore = rectangleSimilarity(
        referenceComponents,
        actualComponents
    );

    const auto geometryPass = maximumBoundsDeviation <= 1;
    const auto structurePass = structuralScore >= 0.98;
    const auto colorPass = meanColorDelta <= 3.0;
    const auto passed = geometryPass && structurePass && colorPass;

    QJsonArray stateMetrics;
    for (const auto& metric : metrics) {
        stateMetrics.append(QJsonObject{
            {"state", metric.state},
            {"pixelSimilarity", metric.pixelSimilarity},
            {"structuralSimilarity", metric.structuralSimilarity},
            {"meanColorDelta", metric.meanColorDelta},
        });
    }
    QJsonArray referenceRects;
    QJsonArray actualRects;
    for (const auto& rect : referenceComponents) {
        referenceRects.append(rectToJson(rect));
    }
    for (const auto& rect : actualComponents) {
        actualRects.append(rectToJson(rect));
    }
    const QJsonObject json{
        {"lockedRelease", "4.4.0"},
        {"passed", passed},
        {"geometry", QJsonObject{
            {"maximumBoundsDeviation", maximumBoundsDeviation},
            {"maximumWidthDeviation", maximumWidthDeviation},
            {"maximumHeightDeviation", maximumHeightDeviation},
            {"referenceComponents", referenceRects},
            {"actualComponents", actualRects},
        }},
        {"pixelSimilarity", pixelScore},
        {"structuralSimilarity", structuralScore},
        {"pixelMaskSimilarity", pixelMaskScore},
        {"meanColorDelta", meanColorDelta},
        {"states", stateMetrics},
        {"thresholds", QJsonObject{
            {"maximumBoundsDeviation", 1},
            {"minimumStructuralSimilarity", 0.98},
            {"maximumMeanColorDelta", 3.0},
        }},
    };
    QFile jsonFile{QFileInfo{reportPath}.absolutePath() + "/button-fidelity.json"};
    if (jsonFile.open(QIODevice::WriteOnly)) {
        jsonFile.write(QJsonDocument{json}.toJson(QJsonDocument::Indented));
    }

    QFile report{reportPath};
    if (!report.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qCritical("Cannot write visual report.");
        return 2;
    }
    QTextStream html{&report};
    html.setEncoding(QStringConverter::Utf8);
    html << R"(<!doctype html><html lang="en"><head><meta charset="utf-8">)"
         << R"(<meta name="viewport" content="width=device-width,initial-scale=1">)"
         << R"(<title>PDS v4.4.0 Button fidelity</title><style>)"
         << R"(body{font:16px Arial,sans-serif;margin:32px;background:#f1f1f4;color:#010205})"
         << R"(.metrics,.row{display:grid;gap:16px}.metrics{grid-template-columns:repeat(4,1fr)})"
         << R"(.metric,.panel{background:#fff;border-radius:12px;padding:16px})"
         << R"(.row{grid-template-columns:repeat(4,1fr);margin:16px 0}.panel img{width:100%;height:auto})"
         << R"(.pass{color:#197e10}.fail{color:#c50000}code{font-size:14px})"
         << R"(</style></head><body><h1>Button fidelity · Porsche Design System 4.4.0</h1>)"
         << "<p class=\"" << (passed ? "pass" : "fail") << "\"><strong>"
         << (passed ? "PASS" : "FAIL") << "</strong> · strict calibration gate</p>"
         << R"(<div class="metrics">)"
         << "<div class=\"metric\"><strong>Bounds deviation</strong><br>"
         << maximumBoundsDeviation << " px <small>(≤ 1)</small></div>"
         << "<div class=\"metric\"><strong>Structural geometry</strong><br>"
         << QString::number(structuralScore, 'f', 5) << " <small>(≥ 0.98)</small></div>"
         << "<div class=\"metric\"><strong>Pixel similarity</strong><br>"
         << QString::number(pixelScore, 'f', 5) << "</div>"
         << "<div class=\"metric\"><strong>Mean RGB delta</strong><br>"
         << QString::number(meanColorDelta, 'f', 3) << " <small>(≤ 3)</small></div></div>"
         << R"(<p>Geometry uses foreground component bounds. Typography uses the documented metric-calibrated Arial Narrow fallback; glyph rasterization remains platform-adapted. Browser screenshots are generated by the exact 4.4.0 package at DPR 1.</p>)";

    for (const auto& metric : metrics) {
        html << "<h2>" << metric.state.toHtmlEscaped() << "</h2><div class=\"row\">"
             << "<div class=\"panel\"><strong>Official web</strong><img src=\"../reference-web/button-"
             << metric.state << ".png\"></div>"
             << "<div class=\"panel\"><strong>Native Qt</strong><img src=\"../actual-qt/button-"
             << metric.state << ".png\"></div>"
             << "<div class=\"panel\"><strong>Overlay</strong><img src=\"../diff/button-"
             << metric.state << "-overlay.png\"></div>"
             << "<div class=\"panel\"><strong>Amplified diff</strong><img src=\"../diff/button-"
             << metric.state << "-diff.png\"></div></div>"
             << "<p><code>pixelMask=" << QString::number(metric.structuralSimilarity, 'f', 5)
             << " pixel=" << QString::number(metric.pixelSimilarity, 'f', 5)
             << " meanDelta=" << QString::number(metric.meanColorDelta, 'f', 3)
             << "</code></p>";
    }
    html << R"(</body></html>)";

    qInfo().noquote()
        << QString{"Button fidelity: %1; bounds=%2px structural=%3 pixel=%4 meanDelta=%5"}
               .arg(passed ? "PASS" : "FAIL")
               .arg(maximumBoundsDeviation)
               .arg(structuralScore, 0, 'f', 5)
               .arg(pixelScore, 0, 'f', 5)
               .arg(meanColorDelta, 0, 'f', 3);
    return passed ? 0 : 1;
}
