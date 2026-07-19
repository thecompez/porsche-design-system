// Qt GUI startup is an interoperability boundary and cannot be a module unit.
#include <QGuiApplication>
#include <QFont>
#include <QImage>
#include <QPointer>
#include <QQmlApplicationEngine>
#include <QQuickGraphicsConfiguration>
#include <QQuickWindow>
#include <QSGRendererInterface>
#include <QTimer>

namespace {

auto hasArgument(int argc, char* argv[], const char* argument) -> bool
{
    for (auto index = 1; index < argc; ++index) {
        if (qstrcmp(argv[index], argument) == 0) {
            return true;
        }
    }
    return false;
}

auto configureRendering(int argc, char* argv[]) -> void
{
    const auto platform = qEnvironmentVariable("QT_QPA_PLATFORM");
    if (hasArgument(argc, argv, "--screenshot")
        && platform == QStringLiteral("offscreen")
        && qEnvironmentVariableIsEmpty("QT_SCALE_FACTOR")) {
        // CI/offscreen has no physical Retina screen. Render user-facing
        // captures at DPR 2 instead of silently producing a low-resolution
        // DPR 1 image.
        qputenv("QT_SCALE_FACTOR", "2");
        qputenv("QT_SCALE_FACTOR_ROUNDING_POLICY", "PassThrough");
    }
#if defined(Q_OS_MACOS)
    if (platform != QStringLiteral("offscreen")
        && qEnvironmentVariableIsEmpty("QSG_RHI_BACKEND")) {
        QQuickWindow::setGraphicsApi(QSGRendererInterface::Metal);
    }
#endif
}

}

auto main(int argc, char* argv[]) -> int
{
    configureRendering(argc, argv);
    QGuiApplication application(argc, argv);
    application.setFont(QFont{QStringLiteral("Arial")});
    QGuiApplication::setApplicationName("Porsche Design System v4 Reference Gallery");

    QQmlApplicationEngine engine;
    engine.loadFromModule("Pds.PorscheReferenceGallery", "Main");
    if (engine.rootObjects().isEmpty()) {
        return 1;
    }
    const auto arguments = application.arguments();
    const auto rootObject = engine.rootObjects().constFirst();
    const auto quickWindow = qobject_cast<QQuickWindow*>(rootObject);
    if (!quickWindow) {
        return 1;
    }
    QQuickGraphicsConfiguration graphicsConfiguration;
    graphicsConfiguration.setDepthBufferFor2D(false);
    graphicsConfiguration.setAutomaticPipelineCache(true);
    quickWindow->setGraphicsConfiguration(graphicsConfiguration);

    const auto pageArgument = arguments.indexOf(QStringLiteral("--page"));
    if (pageArgument >= 0 && pageArgument + 1 < arguments.size()) {
        bool validPage = false;
        const auto pageIndex = arguments.at(pageArgument + 1).toInt(&validPage);
        const auto pageCount = rootObject->property("pageCount").toInt();
        if (!validPage || pageIndex < 0 || pageIndex >= pageCount
            || !rootObject->setProperty("currentPageIndex", pageIndex)) {
            return 3;
        }
    }
    const auto screenshotArgument = arguments.indexOf(QStringLiteral("--screenshot"));
    if (screenshotArgument >= 0 && screenshotArgument + 1 < arguments.size()) {
        const auto screenshotPath = arguments.at(screenshotArgument + 1);
        const auto window = QPointer{quickWindow};
        QTimer::singleShot(1000, &application,
                           [window, screenshotPath, &application] {
            const auto saved = window && window->grabWindow().save(screenshotPath);
            application.exit(saved ? 0 : 2);
        });
        return application.exec();
    }
    if (application.arguments().contains("--smoke-test")) {
        auto* fixturePoll = new QTimer{&application};
        fixturePoll->setInterval(20);
        QObject::connect(
            fixturePoll,
            &QTimer::timeout,
            &application,
            [rootObject, fixturePoll, &application] {
                const auto status =
                    rootObject->property("currentFixtureStatus").toInt();
                if (status == 1) {
                    fixturePoll->stop();
                    application.exit(0);
                } else if (status == 3) {
                    fixturePoll->stop();
                    application.exit(4);
                }
            });
        fixturePoll->start();
        QTimer::singleShot(3000, &application, [fixturePoll, &application] {
            if (fixturePoll->isActive()) {
                fixturePoll->stop();
                application.exit(5);
            }
        });
    }
    return application.exec();
}
