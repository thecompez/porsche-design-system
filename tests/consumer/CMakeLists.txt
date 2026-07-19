cmake_minimum_required(VERSION 3.30)

if(CMAKE_VERSION VERSION_GREATER_EQUAL "4.3.0" AND CMAKE_VERSION VERSION_LESS "4.4.0")
    set(CMAKE_EXPERIMENTAL_CXX_IMPORT_STD
        "451f2fe2-a8a2-47c3-bc32-94786d8fc91b"
    )
endif()
set(CMAKE_CXX_MODULE_STD ON)
set(CMAKE_CXX_SCAN_FOR_MODULES ON)
file(GLOB _libcxx_module_metadata
    "/opt/homebrew/Cellar/llvm/*/lib/c++/libc++.modules.json"
    "/usr/local/Cellar/llvm/*/lib/c++/libc++.modules.json"
)
list(SORT _libcxx_module_metadata ORDER DESCENDING)
list(GET _libcxx_module_metadata 0 CMAKE_CXX_STDLIB_MODULES_JSON)

project(PdsNativeConsumer LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_SCAN_FOR_MODULES ON)

find_package(PdsNative CONFIG REQUIRED)
add_executable(consumer main.cpp)
target_link_libraries(consumer PRIVATE PdsNative::Core PdsNative::Controls)
