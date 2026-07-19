file(REMOVE_RECURSE "${OUTPUT}")
execute_process(
    COMMAND "${GENERATOR}" --schema "${SCHEMA}" --input "${SOURCE}" --output "${OUTPUT}"
    RESULT_VARIABLE first_result
)
if(NOT first_result EQUAL 0)
    message(FATAL_ERROR "Initial token generation failed with ${first_result}")
endif()
file(SHA256 "${OUTPUT}/Tokens.qml" qml_first)
file(SHA256 "${OUTPUT}/tokens.cppm" cpp_first)
file(SHA256 "${OUTPUT}/tokens-reference.md" docs_first)
execute_process(
    COMMAND "${GENERATOR}" --schema "${SCHEMA}" --input "${SOURCE}" --output "${OUTPUT}"
    RESULT_VARIABLE second_result
)
if(NOT second_result EQUAL 0)
    message(FATAL_ERROR "Second token generation failed with ${second_result}")
endif()
file(SHA256 "${OUTPUT}/Tokens.qml" qml_second)
file(SHA256 "${OUTPUT}/tokens.cppm" cpp_second)
file(SHA256 "${OUTPUT}/tokens-reference.md" docs_second)
if(NOT qml_first STREQUAL qml_second
   OR NOT cpp_first STREQUAL cpp_second
   OR NOT docs_first STREQUAL docs_second)
    message(FATAL_ERROR "Token generation is not deterministic")
endif()

