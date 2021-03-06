cmake_minimum_required(VERSION 3.2)
set(CMAKE_FIND_LIBRARY_PREFIXES /usr/lib)
set(CMAKE_FIND_LIBRARY_SUFFIXES .so)
set(Boost_INCLUDE_DIR /usr/include)
set(Boost_LIBRARY_DIR /usr/lib)
set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "bin/")
find_package(Boost REQUIRED COMPONENTS)
find_package(RapidJSON)

if (RapidJSON_FOUND)
    include_directories(${RapidJSON_INCLUDE_DIRS})
endif ()


project(Taraxacum)
include(CheckCXXCompilerFlag)

CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
if (COMPILER_SUPPORTS_CXX11)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
elseif (COMPILER_SUPPORTS_CXX0X)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
else ()
    message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif ()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)


INSTALL(
        DIRECTORY ${CMAKE_SOURCE_DIR}/include/
        DESTINATION include/Taraxacum
        FILES_MATCHING PATTERN "*.h*")


include_directories("/usr/local/include" "/usr/include")
set(SOURCE_FILES examples/Simple_Microservice/Rest_example.cpp include/Uservice_version.h include/InfluxDB.h include/ServiceDiscovery.h)
set(SOURCE_FILES_REST examples/Rest/Rest_routing_Example.cpp include/InfluxDB.h include/ServiceDiscovery.h)
set(SOURCE_FILES_SHELL_MICROSERVICE examples/Rest/Script_Microservice.cpp include/InfluxDB.h include/ServiceDiscovery.h)
set(SOURCE_FILES_APP1 "examples/Autopilot pattern example/app1.cpp" include/InfluxDB.h include/ServiceDiscovery.h)
set(SOURCE_FILES_APP2 "examples/Autopilot pattern example/app2.cpp" include/InfluxDB.h include/ServiceDiscovery.h)


add_executable(Rest_example ${SOURCE_FILES})

target_link_libraries(Rest_example net_static pthread boost_system curl)

add_executable(Rest_routing_Example ${SOURCE_FILES_REST})

target_link_libraries(Rest_routing_Example net_static pthread boost_system curl)

add_executable(Script_Microservice ${SOURCE_FILES_SHELL_MICROSERVICE})

target_link_libraries(Script_Microservice net_static pthread boost_system curl)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "autopilot-example/app1/bin")


add_executable(app1 ${SOURCE_FILES_APP1})

target_link_libraries(app1 net_static pthread boost_system curl)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "autopilot-example/app2/bin")


add_executable(app2 ${SOURCE_FILES_APP2})

target_link_libraries(app2 net_static pthread boost_system curl)
