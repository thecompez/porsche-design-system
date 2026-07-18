cmake_minimum_required(VERSION 3.30)

option(PDS_ENABLE_IMPORT_STD "Enable C++26 import std support" ON)

if(PDS_ENABLE_IMPORT_STD)
    if(CMAKE_VERSION VERSION_GREATER_EQUAL "4.3.0" AND CMAKE_VERSION VERSION_LESS "4.4.0")
        set(CMAKE_EXPERIMENTAL_CXX_IMPORT_STD
            "451f2fe2-a8a2-47c3-bc32-94786d8fc91b"
        )
    endif()
    set(CMAKE_CXX_MODULE_STD ON)
    set(CMAKE_CXX_SCAN_FOR_MODULES ON)
    if(NOT CMAKE_CXX_STDLIB_MODULES_JSON)
        file(GLOB _pds_libcxx_module_metadata
            "/opt/homebrew/Cellar/llvm/*/lib/c++/libc++.modules.json"
            "/usr/local/Cellar/llvm/*/lib/c++/libc++.modules.json"
        )
        list(SORT _pds_libcxx_module_metadata ORDER DESCENDING)
        list(GET _pds_libcxx_module_metadata 0 CMAKE_CXX_STDLIB_MODULES_JSON)
    endif()
endif()

project(
    PdsNative
    VERSION 0.1.0
    DESCRIPTION "Native Qt Quick port of Porsche Design System v4"
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_SCAN_FOR_MODULES ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH ON)

include(CTest)
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

find_package(Qt6 6.8 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Test QuickTest)
qt_standard_project_setup(REQUIRES 6.8)

option(PDS_BUILD_GALLERY "Build the component lab and Porsche reference gallery" ON)
option(PDS_BUILD_TESTS "Build tests" ${BUILD_TESTING})

add_subdirectory(tools/token-generator)

set(PDS_GENERATED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/tokens/generated")
set(PDS_TOKEN_SOURCE "${CMAKE_CURRENT_SOURCE_DIR}/tokens/source/tokens.json")
set(PDS_TOKEN_SCHEMA "${CMAKE_CURRENT_SOURCE_DIR}/tokens/schema/token.schema.json")
set(PDS_GENERATED_OUTPUTS
    "${PDS_GENERATED_DIR}/Tokens.qml"
    "${PDS_GENERATED_DIR}/tokens.cppm"
    "${PDS_GENERATED_DIR}/tokens-reference.md"
)

add_custom_command(
    OUTPUT ${PDS_GENERATED_OUTPUTS}
    COMMAND PdsTokenGenerator
        --schema "${PDS_TOKEN_SCHEMA}"
        --input "${PDS_TOKEN_SOURCE}"
        --output "${PDS_GENERATED_DIR}"
    DEPENDS PdsTokenGenerator "${PDS_TOKEN_SOURCE}" "${PDS_TOKEN_SCHEMA}"
    COMMENT "Validating and generating PDS token APIs"
    VERBATIM
)
add_custom_target(pds_generate_tokens DEPENDS ${PDS_GENERATED_OUTPUTS})

add_library(PdsNativeCore)
add_library(PdsNative::Core ALIAS PdsNativeCore)
target_sources(PdsNativeCore
    PUBLIC
        FILE_SET CXX_MODULES
        BASE_DIRS
            "${CMAKE_CURRENT_SOURCE_DIR}/src/pds/core"
            "${PDS_GENERATED_DIR}"
        FILES
            src/pds/core/core.cppm
            "${PDS_GENERATED_DIR}/tokens.cppm"
    PRIVATE
        src/pds/core/core.cpp
)
add_dependencies(PdsNativeCore pds_generate_tokens)
target_link_libraries(PdsNativeCore PUBLIC Qt6::Core Qt6::Gui)
target_compile_features(PdsNativeCore PUBLIC cxx_std_26)
if(PDS_ENABLE_IMPORT_STD)
    set_property(TARGET PdsNativeCore PROPERTY CXX_MODULE_STD ON)
endif()
set_target_properties(PdsNativeCore PROPERTIES
    EXPORT_NAME Core
    OUTPUT_NAME PdsNativeCore
)

set(PDS_QML_FILES
    tokens/generated/Tokens.qml
    src/pds/qml/Theme.qml
    src/pds/qml/Typography.qml
    src/pds/qml/IconProvider.qml
    src/pds/qml/Motion.qml
    src/pds/qml/primitives/FocusRing.qml
    src/pds/qml/primitives/InteractiveArea.qml
    src/pds/qml/controls/Button.qml
    src/pds/qml/controls/Spinner.qml
    src/pds/qml/controls/Icon.qml
    src/pds/qml/controls/Text.qml
    src/pds/qml/controls/Heading.qml
    src/pds/qml/controls/Divider.qml
    src/pds/qml/controls/Link.qml
    src/pds/qml/controls/LinkPure.qml
    src/pds/qml/controls/ButtonPure.qml
    src/pds/qml/controls/InputText.qml
    src/pds/qml/controls/InputPassword.qml
    src/pds/qml/controls/Switch.qml
    src/pds/qml/controls/Checkbox.qml
    src/pds/qml/controls/RadioGroup.qml
    src/pds/qml/controls/Select.qml
    src/pds/qml/controls/Banner.qml
    src/pds/qml/controls/InlineNotification.qml
    src/pds/qml/controls/Tag.qml
)

set_source_files_properties(
    tokens/generated/Tokens.qml
    src/pds/qml/Theme.qml
    src/pds/qml/Typography.qml
    src/pds/qml/IconProvider.qml
    src/pds/qml/Motion.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(PdsNativeControls
    URI Pds.Native
    VERSION 1.0
    QML_FILES ${PDS_QML_FILES}
    RESOURCE_PREFIX /qt/qml
    OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/qml/Pds/Native"
)
add_library(PdsNative::Controls ALIAS PdsNativeControls)
add_dependencies(PdsNativeControls pds_generate_tokens)
target_link_libraries(PdsNativeControls PUBLIC PdsNativeCore Qt6::Quick Qt6::QuickControls2)
target_compile_features(PdsNativeControls PUBLIC cxx_std_26)
set_target_properties(PdsNativeControls PROPERTIES EXPORT_NAME Controls)

if(PDS_BUILD_GALLERY)
    add_subdirectory(examples/component-lab)
    add_subdirectory(examples/porsche-reference-gallery)
endif()

if(PDS_BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

install(TARGETS PdsNativeCore PdsNativeControls PdsNativeControlsplugin
    EXPORT PdsNativeTargets
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    FILE_SET CXX_MODULES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/PdsNative/modules"
)
install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/qml/Pds"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/qml"
    PATTERN "*.dSYM" EXCLUDE
)
install(EXPORT PdsNativeTargets
    FILE PdsNativeTargets.cmake
    NAMESPACE PdsNative::
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/PdsNative"
)
configure_package_config_file(
    cmake/PdsNativeConfig.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/PdsNativeConfig.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/PdsNative"
)
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/PdsNativeConfigVersion.cmake"
    VERSION "${PROJECT_VERSION}"
    COMPATIBILITY SameMajorVersion
)
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/PdsNativeConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/PdsNativeConfigVersion.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/PdsNative"
)
install(FILES LICENSE NOTICE.md DESTINATION "${CMAKE_INSTALL_DATADIR}/PdsNative")

message(STATUS "CMAKE_VERSION=${CMAKE_VERSION}")
message(STATUS "CMAKE_GENERATOR=${CMAKE_GENERATOR}")
message(STATUS "CMAKE_CXX_COMPILER_ID=${CMAKE_CXX_COMPILER_ID}")
message(STATUS "CMAKE_CXX_COMPILER_VERSION=${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "PDS_ENABLE_IMPORT_STD=${PDS_ENABLE_IMPORT_STD}")
message(STATUS "CMAKE_CXX_COMPILER_IMPORT_STD=${CMAKE_CXX_COMPILER_IMPORT_STD}")
