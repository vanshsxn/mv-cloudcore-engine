cmake_minimum_required(VERSION 3.16)
project(mv_cloudcore_engine LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(Threads REQUIRED)

file(GLOB ENGINE_SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
)

add_executable(mv-cloudcore-engine ${ENGINE_SOURCES})

target_include_directories(mv-cloudcore-engine PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
)

target_link_libraries(mv-cloudcore-engine PRIVATE Threads::Threads)

if(UNIX)
    target_compile_options(mv-cloudcore-engine PRIVATE -Wall -Wextra -Wpedantic)
endif()
