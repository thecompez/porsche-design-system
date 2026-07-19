if(NOT DEFINED GALLERY)
    message(FATAL_ERROR "GALLERY executable is required")
endif()

foreach(page RANGE 0 28)
    execute_process(
        COMMAND "${CMAKE_COMMAND}" -E env
            "QT_QPA_PLATFORM=offscreen"
            "QML_DISABLE_DISK_CACHE=1"
            "${GALLERY}" --page "${page}" --smoke-test
        RESULT_VARIABLE page_result
        OUTPUT_VARIABLE page_output
        ERROR_VARIABLE page_error
    )
    if(NOT page_result EQUAL 0)
        message(FATAL_ERROR
            "Reference gallery page ${page} failed with ${page_result}\n"
            "${page_output}${page_error}"
        )
    endif()
endforeach()
