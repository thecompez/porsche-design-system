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
    QGuiApplication::setApplicationName("PDS v4 Component Lab");

    QQmlApplicationEngine engine;
    engine.loadFromModule("Pds.ComponentLab", "Main");
    if (engine.rootObjects().isEmpty()) {
        return 1;
    }
    const auto quickWindow =
        qobject_cast<QQuickWindow*>(engine.rootObjects().constFirst());
    if (!quickWindow) {
        return 1;
    }
    QQuickGraphicsConfiguration graphicsConfiguration;
    graphicsConfiguration.setDepthBufferFor2D(false);
    graphicsConfiguration.setAutomaticPipelineCache(true);
    quickWindow->setGraphicsConfiguration(graphicsConfiguration);

    const auto arguments = application.arguments();
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
        QTimer::singleShot(250, &application, &QCoreApplication::quit);
    }
    return application.exec();
}
