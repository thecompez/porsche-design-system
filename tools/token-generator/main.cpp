// Qt's executable entry-point boundary is a conventional translation unit.
#include <QCommandLineParser>
#include <QCoreApplication>
#include <QTextStream>

import pds.native.token.generator;

auto main(int argc, char* argv[]) -> int
{
    QCoreApplication application(argc, argv);
    QCoreApplication::setApplicationName("PdsTokenGenerator");
    QCommandLineParser parser;
    parser.setApplicationDescription("Validate and generate PDS native design tokens.");
    parser.addHelpOption();
    parser.addOptions({
        {{"s", "schema"}, "Token schema path.", "file"},
        {{"i", "input"}, "Token source path.", "file"},
        {{"o", "output"}, "Generated output directory.", "directory"},
    });
    parser.process(application);
    if (!parser.isSet("schema") || !parser.isSet("input") || !parser.isSet("output")) {
        QTextStream(stderr) << "error: --schema, --input, and --output are required\n";
        parser.showHelp(2);
    }
    const pds::native::token::Generator generator;
    const auto result = generator.generate(
        parser.value("schema"), parser.value("input"), parser.value("output"));
    for (const auto& diagnostic : result.diagnostics) {
        QTextStream(stderr) << (result.success ? "note: " : "error: ") << diagnostic << '\n';
    }
    return result.success ? 0 : 1;
}
