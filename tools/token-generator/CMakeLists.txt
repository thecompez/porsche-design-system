add_library(PdsTokenGeneratorLib)
target_sources(PdsTokenGeneratorLib
    PUBLIC
        FILE_SET CXX_MODULES FILES token_generator.cppm
    PRIVATE
        token_generator.cpp
)
target_link_libraries(PdsTokenGeneratorLib PUBLIC Qt6::Core)
target_compile_features(PdsTokenGeneratorLib PUBLIC cxx_std_26)
if(PDS_ENABLE_IMPORT_STD)
    set_property(TARGET PdsTokenGeneratorLib PROPERTY CXX_MODULE_STD ON)
endif()

add_executable(PdsTokenGenerator main.cpp)
target_link_libraries(PdsTokenGenerator PRIVATE PdsTokenGeneratorLib Qt6::Core)
target_compile_features(PdsTokenGenerator PRIVATE cxx_std_26)
if(PDS_ENABLE_IMPORT_STD)
    set_property(TARGET PdsTokenGenerator PROPERTY CXX_MODULE_STD ON)
endif()
