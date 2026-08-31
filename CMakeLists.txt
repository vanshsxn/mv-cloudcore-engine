cmake_minimum_required(VERSION 3.16)

project(mv_cloudcore_engine LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(Threads REQUIRED)

add_executable(mv-cloudcore-engine
    main.cpp
    Engine.cpp
    HttpServer.cpp
    Job.cpp
    JobQueue.cpp
    Json.cpp
    Logger.cpp
    MLFQScheduler.cpp
    AdaptiveScheduler.cpp
    MemoryManager.cpp
    ResourceManager.cpp
    ThreadPool.cpp
)

target_link_libraries(mv-cloudcore-engine
    PRIVATE
    Threads::Threads
)

if(UNIX)
    target_compile_options(mv-cloudcore-engine PRIVATE
        -Wall
        -Wextra
        -Wpedantic
    )
endif()
