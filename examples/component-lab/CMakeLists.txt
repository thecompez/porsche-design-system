qt_add_executable(PdsComponentLab main.cpp)
qt_add_qml_module(PdsComponentLab
    URI Pds.ComponentLab
    VERSION 1.0
    QML_FILES Main.qml
    RESOURCE_PREFIX /qt/qml
    IMPORT_PATH "${CMAKE_BINARY_DIR}/qml"
)
target_link_libraries(PdsComponentLab PRIVATE
    PdsNativeControls
    Qt6::Quick
    Qt6::QuickControls2
)
set_target_properties(PdsComponentLab PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

install(TARGETS PdsComponentLab
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    BUNDLE DESTINATION "."
)
