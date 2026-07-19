add_executable(token_generator_tests unit/token_generator_tests.cpp)
target_link_libraries(token_generator_tests PRIVATE
    PdsTokenGeneratorLib
    Qt6::Core
    Qt6::Test
)
target_compile_features(token_generator_tests PRIVATE cxx_std_26)
if(PDS_ENABLE_IMPORT_STD)
    set_property(TARGET token_generator_tests PROPERTY CXX_MODULE_STD ON)
endif()
add_test(NAME unit.token_generator COMMAND token_generator_tests)

add_executable(core_tests unit/core_tests.cpp)
target_link_libraries(core_tests PRIVATE
    PdsNativeCore
    Qt6::Gui
    Qt6::Test
)
target_compile_features(core_tests PRIVATE cxx_std_26)
if(PDS_ENABLE_IMPORT_STD)
    set_property(TARGET core_tests PROPERTY CXX_MODULE_STD ON)
endif()
add_test(NAME unit.core COMMAND core_tests)

add_executable(qml_test_runner qml/quick_test_main.cpp)
target_link_libraries(qml_test_runner PRIVATE
    PdsNativeControls
    Qt6::Quick
    Qt6::QuickTest
)

function(pds_add_qml_test test_name directory)
    add_test(
        NAME "${test_name}"
        COMMAND qml_test_runner
            -input "${CMAKE_CURRENT_SOURCE_DIR}/${directory}"
            -import "${CMAKE_BINARY_DIR}/qml"
    )
    set_tests_properties("${test_name}" PROPERTIES
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen;QML_DISABLE_DISK_CACHE=1"
        WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    )
endfunction()

pds_add_qml_test(qml.components qml/cases)
pds_add_qml_test(qml.interaction interaction)
pds_add_qml_test(qml.accessibility accessibility)
pds_add_qml_test(qml.visual visual)

add_executable(button_visual_compare visual/visual_compare.cpp)
target_link_libraries(button_visual_compare PRIVATE Qt6::Core Qt6::Gui)
target_compile_features(button_visual_compare PRIVATE cxx_std_26)
add_test(
    NAME visual.button_fidelity_gate
    COMMAND button_visual_compare
        --reference-dir "${CMAKE_CURRENT_SOURCE_DIR}/visual/reference-web"
        --actual-input-dir "${CMAKE_CURRENT_BINARY_DIR}"
        --actual-output-dir "${CMAKE_CURRENT_SOURCE_DIR}/visual/actual-qt"
        --diff-dir "${CMAKE_CURRENT_SOURCE_DIR}/visual/diff"
        --report "${CMAKE_CURRENT_SOURCE_DIR}/visual/reports/button-fidelity.html"
)
set_tests_properties(visual.button_fidelity_gate PROPERTIES
    DEPENDS qml.visual
)

if(TARGET PdsComponentLab)
    add_test(
        NAME runtime.component_lab_smoke
        COMMAND $<TARGET_FILE:PdsComponentLab> --smoke-test
    )
    set_tests_properties(runtime.component_lab_smoke PROPERTIES
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen;QML_DISABLE_DISK_CACHE=1"
    )
endif()

if(TARGET PdsPorscheReferenceGallery)
    add_test(
        NAME runtime.reference_gallery_smoke
        COMMAND $<TARGET_FILE:PdsPorscheReferenceGallery> --smoke-test
    )
    set_tests_properties(runtime.reference_gallery_smoke PROPERTIES
        ENVIRONMENT "QT_QPA_PLATFORM=offscreen;QML_DISABLE_DISK_CACHE=1"
    )
    add_test(
        NAME runtime.reference_gallery_all_pages
        COMMAND "${CMAKE_COMMAND}"
            "-DGALLERY=$<TARGET_FILE:PdsPorscheReferenceGallery>"
            -P "${CMAKE_CURRENT_SOURCE_DIR}/reference_gallery_pages.cmake"
    )
endif()

add_test(
    NAME validation.token_determinism
    COMMAND "${CMAKE_COMMAND}"
        "-DGENERATOR=$<TARGET_FILE:PdsTokenGenerator>"
        "-DSCHEMA=${PDS_TOKEN_SCHEMA}"
        "-DSOURCE=${PDS_TOKEN_SOURCE}"
        "-DOUTPUT=${CMAKE_CURRENT_BINARY_DIR}/deterministic-tokens"
        -P "${CMAKE_CURRENT_SOURCE_DIR}/token_determinism.cmake"
)

add_test(
    NAME validation.installed_consumer
    COMMAND "${CMAKE_COMMAND}"
        "-DBUILD_DIR=${CMAKE_BINARY_DIR}"
        "-DSOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}/consumer"
        "-DQT_PREFIX=${Qt6_DIR}/../../.."
        -P "${CMAKE_CURRENT_SOURCE_DIR}/consumer_test.cmake"
)
