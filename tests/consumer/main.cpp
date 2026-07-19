// Qt's GUI/QML entry point is a documented textual-include boundary.
#include <QGuiApplication>
#include <QDebug>
#include <QEventLoop>
#include <QQmlComponent>
#include <QQmlEngine>
#include <QUrl>

import pds.native.core;
import std;

auto main(int argc, char* argv[]) -> int
{
    using pds::native::core::ButtonSpec;
    const auto regular = ButtonSpec::geometry(false);
    if (regular.paddingInline != 28 || regular.radius != 12) {
        return 1;
    }

    QGuiApplication application{argc, argv};
    QQmlEngine engine;
    QQmlComponent component{&engine};
    component.setData(R"(
        import QtQml
        import Pds.Native

        Button {
            text: "Installed consumer"
            property list<QtObject> publicTypes: [
                ButtonPure {},
                Spinner {},
                Icon {},
                Text {},
                Heading {},
                InputText {},
                InputPassword {},
                Switch {},
                Checkbox {},
                RadioGroup {},
                Select {},
                Banner {},
                InlineNotification {},
                Tag {},
                Divider {},
                Link {},
                LinkPure {},
                Modal {},
                Tabs {}
            ]
        }
    )", QUrl{QStringLiteral("consumer:/AllPublicTypes.qml")});

    if (component.isLoading()) {
        QEventLoop loop;
        QObject::connect(&component,
                         &QQmlComponent::statusChanged,
                         &loop,
                         [&loop](QQmlComponent::Status status) {
                             if (status != QQmlComponent::Loading) {
                                 loop.quit();
                             }
                         });
        loop.exec();
    }

    auto instance = std::unique_ptr<QObject>{component.create()};
    if (!instance) {
        qCritical().noquote() << component.errorString();
    }
    return instance ? 0 : 2;
}
