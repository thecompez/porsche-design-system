set(prefix "${BUILD_DIR}/consumer-install")
set(consumer_build "${BUILD_DIR}/consumer-build")
file(REMOVE_RECURSE "${prefix}" "${consumer_build}")
execute_process(
    COMMAND "${CMAKE_COMMAND}" --install "${BUILD_DIR}" --prefix "${prefix}"
    RESULT_VARIABLE install_result
)
if(NOT install_result EQUAL 0)
    message(FATAL_ERROR "Install failed with ${install_result}")
endif()
execute_process(
    COMMAND "${CMAKE_COMMAND}"
        -S "${SOURCE_DIR}"
        -B "${consumer_build}"
        -G Ninja
        "-DCMAKE_PREFIX_PATH=${prefix};${QT_PREFIX}"
        -DCMAKE_CXX_COMPILER=/opt/homebrew/opt/llvm/bin/clang++
    RESULT_VARIABLE configure_result
)
if(NOT configure_result EQUAL 0)
    message(FATAL_ERROR "Consumer configure failed with ${configure_result}")
endif()
execute_process(
    COMMAND "${CMAKE_COMMAND}" --build "${consumer_build}"
    RESULT_VARIABLE build_result
)
if(NOT build_result EQUAL 0)
    message(FATAL_ERROR "Consumer build failed with ${build_result}")
endif()
execute_process(
    COMMAND "${CMAKE_COMMAND}" -E env
        "QT_QPA_PLATFORM=offscreen"
        "QML_IMPORT_PATH=${prefix}/lib/qml"
        "${consumer_build}/consumer"
    RESULT_VARIABLE run_result
)
if(NOT run_result EQUAL 0)
    message(FATAL_ERROR "Consumer run failed with ${run_result}")
endif()
