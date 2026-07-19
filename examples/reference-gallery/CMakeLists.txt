qt_add_executable(PdsPorscheReferenceGallery main.cpp)
qt_add_qml_module(PdsPorscheReferenceGallery
    URI Pds.PorscheReferenceGallery
    VERSION 1.0
    QML_FILES Main.qml
    RESOURCE_PREFIX /qt/qml
    IMPORT_PATH "${CMAKE_BINARY_DIR}/qml"
)
target_link_libraries(PdsPorscheReferenceGallery PRIVATE
    PdsNativeControls
    Qt6::Quick
    Qt6::QuickControls2
)
set_target_properties(PdsPorscheReferenceGallery PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

install(TARGETS PdsPorscheReferenceGallery
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    BUNDLE DESTINATION "."
)
