cmake_minimum_required(VERSION 2.9)
project(protobuf)

include_directories("src")

# TODO: This is hard coded to support gcc 4.9.2 or newer, we could add more advanced checks as found in: https://github.com/jesperes/protobuf-cmake/blob/master/CMakeLists.txt
set(CMAKE_REQUIRED_FLAGS "-std=c++11")
set(CMAKE_CXX_FLAGS "-std=c++11")

set(HASH_MAP_H "<unordered_map>")
set(HASH_MAP_CLASS "unordered_map")
set(HASH_NAMESPACE "std")
set(HAVE_HASH_MAP 1)

set(HASH_SET_H "<unordered_set>")
set(HASH_SET_CLASS "unordered_set")
set(HAVE_HASH_SET 1)

set(HAVE_PTHREAD 1)

option(INSTALL_PYTHON "Install python files" ON)
option(BUILD_STATIC "Build as a static library instead of shared library" OFF)

# Generate the config.h and pbconfig.h files from templates. These are needed to compile protobuf.
configure_file("src/config.h.in" "src/config.h")
configure_file("src/google/protobuf/stubs/pbconfig.h.in" "src/google/protobuf/stubs/pbconfig.h")
include_directories("${PROJECT_BINARY_DIR}/src")


set(PB_LIBPROTOBUF_LITE_SOURCES
	src/google/protobuf/stubs/atomicops_internals_x86_gcc.cc
	src/google/protobuf/stubs/atomicops_internals_x86_msvc.cc
	src/google/protobuf/stubs/common.cc
	src/google/protobuf/stubs/once.cc
	src/google/protobuf/stubs/stringprintf.cc
	src/google/protobuf/arena.cc
	src/google/protobuf/arenastring.cc
	src/google/protobuf/extension_set.cc
	src/google/protobuf/generated_message_util.cc
	src/google/protobuf/message_lite.cc
	src/google/protobuf/repeated_field.cc
	src/google/protobuf/wire_format_lite.cc
	src/google/protobuf/io/coded_stream.cc
	src/google/protobuf/io/zero_copy_stream.cc
	src/google/protobuf/io/zero_copy_stream_impl_lite.cc
)

set(PB_LIBPROTOBUF_SOURCES
	${PB_LIBPROTOBUF_LITE_SOURCES}
	src/google/protobuf/stubs/strutil.cc
	src/google/protobuf/stubs/substitute.cc
	src/google/protobuf/stubs/structurally_valid.cc
	src/google/protobuf/descriptor.cc
	src/google/protobuf/descriptor_database.cc
	src/google/protobuf/descriptor.pb.cc
	src/google/protobuf/dynamic_message.cc
	src/google/protobuf/extension_set_heavy.cc
	src/google/protobuf/generated_message_reflection.cc
	src/google/protobuf/map_field.cc
	src/google/protobuf/message.cc
	src/google/protobuf/reflection_ops.cc
	src/google/protobuf/service.cc
	src/google/protobuf/text_format.cc
	src/google/protobuf/unknown_field_set.cc
	src/google/protobuf/wire_format.cc
	src/google/protobuf/io/gzip_stream.cc
	src/google/protobuf/io/printer.cc
	src/google/protobuf/io/strtod.cc
	src/google/protobuf/io/tokenizer.cc
	src/google/protobuf/io/zero_copy_stream_impl.cc
	src/google/protobuf/compiler/importer.cc
	src/google/protobuf/compiler/parser.cc
)

set(PB_LIBPROTOC_SOURCES
	src/google/protobuf/compiler/code_generator.cc
	src/google/protobuf/compiler/command_line_interface.cc
	src/google/protobuf/compiler/plugin.cc
	src/google/protobuf/compiler/plugin.pb.cc
	src/google/protobuf/compiler/subprocess.cc
	src/google/protobuf/compiler/zip_writer.cc
	src/google/protobuf/compiler/cpp/cpp_enum.cc
	src/google/protobuf/compiler/cpp/cpp_enum_field.cc
	src/google/protobuf/compiler/cpp/cpp_extension.cc
	src/google/protobuf/compiler/cpp/cpp_field.cc
	src/google/protobuf/compiler/cpp/cpp_file.cc
	src/google/protobuf/compiler/cpp/cpp_generator.cc
	src/google/protobuf/compiler/cpp/cpp_helpers.cc
	src/google/protobuf/compiler/cpp/cpp_map_field.cc
	src/google/protobuf/compiler/cpp/cpp_message.cc
	src/google/protobuf/compiler/cpp/cpp_message_field.cc
	src/google/protobuf/compiler/cpp/cpp_primitive_field.cc
	src/google/protobuf/compiler/cpp/cpp_service.cc
	src/google/protobuf/compiler/cpp/cpp_string_field.cc
	src/google/protobuf/compiler/java/java_context.cc
	src/google/protobuf/compiler/java/java_enum.cc
	src/google/protobuf/compiler/java/java_enum_field.cc
	src/google/protobuf/compiler/java/java_extension.cc
	src/google/protobuf/compiler/java/java_field.cc
	src/google/protobuf/compiler/java/java_file.cc
	src/google/protobuf/compiler/java/java_generator.cc
	src/google/protobuf/compiler/java/java_generator_factory.cc
	src/google/protobuf/compiler/java/java_helpers.cc
	src/google/protobuf/compiler/java/java_lazy_message_field.cc
	src/google/protobuf/compiler/java/java_map_field.cc
	src/google/protobuf/compiler/java/java_message.cc
	src/google/protobuf/compiler/java/java_message_field.cc
	src/google/protobuf/compiler/java/java_name_resolver.cc
	src/google/protobuf/compiler/java/java_primitive_field.cc
	src/google/protobuf/compiler/java/java_shared_code_generator.cc
	src/google/protobuf/compiler/java/java_service.cc
	src/google/protobuf/compiler/java/java_string_field.cc
	src/google/protobuf/compiler/java/java_doc_comment.cc
	src/google/protobuf/compiler/javanano/javanano_enum.cc
	src/google/protobuf/compiler/javanano/javanano_enum_field.cc
	src/google/protobuf/compiler/javanano/javanano_extension.cc
	src/google/protobuf/compiler/javanano/javanano_field.cc
	src/google/protobuf/compiler/javanano/javanano_file.cc
	src/google/protobuf/compiler/javanano/javanano_generator.cc
	src/google/protobuf/compiler/javanano/javanano_helpers.cc
	src/google/protobuf/compiler/javanano/javanano_map_field.cc
	src/google/protobuf/compiler/javanano/javanano_message.cc
	src/google/protobuf/compiler/javanano/javanano_message_field.cc
	src/google/protobuf/compiler/javanano/javanano_primitive_field.cc
	src/google/protobuf/compiler/python/python_generator.cc
	src/google/protobuf/compiler/ruby/ruby_generator.cc
)

set(PB_HEADER_FILES
	src/google/protobuf/stubs/atomic_sequence_num.h
	src/google/protobuf/stubs/atomicops.h
	src/google/protobuf/stubs/atomicops_internals_aix.h
	src/google/protobuf/stubs/atomicops_internals_arm64_gcc.h
	src/google/protobuf/stubs/atomicops_internals_arm_gcc.h
	src/google/protobuf/stubs/atomicops_internals_arm_qnx.h
	src/google/protobuf/stubs/atomicops_internals_atomicword_compat.h
	src/google/protobuf/stubs/atomicops_internals_generic_gcc.h
	src/google/protobuf/stubs/atomicops_internals_macosx.h
	src/google/protobuf/stubs/atomicops_internals_mips_gcc.h
	src/google/protobuf/stubs/atomicops_internals_pnacl.h
	src/google/protobuf/stubs/atomicops_internals_solaris.h
	src/google/protobuf/stubs/atomicops_internals_tsan.h
	src/google/protobuf/stubs/atomicops_internals_x86_gcc.h
	src/google/protobuf/stubs/atomicops_internals_x86_msvc.h
	src/google/protobuf/stubs/casts.h
	src/google/protobuf/stubs/common.h
	src/google/protobuf/stubs/fastmem.h
	src/google/protobuf/stubs/hash.h
	src/google/protobuf/stubs/once.h
	src/google/protobuf/stubs/platform_macros.h
	src/google/protobuf/stubs/shared_ptr.h
	src/google/protobuf/stubs/singleton.h
	src/google/protobuf/stubs/stl_util.h
	src/google/protobuf/stubs/template_util.h
	src/google/protobuf/stubs/type_traits.h
	src/google/protobuf/arena.h
	src/google/protobuf/arenastring.h
	src/google/protobuf/descriptor_database.h
	src/google/protobuf/descriptor.h
	src/google/protobuf/descriptor.pb.h
	src/google/protobuf/dynamic_message.h
	src/google/protobuf/extension_set.h
	src/google/protobuf/generated_enum_reflection.h
	src/google/protobuf/generated_enum_util.h
	src/google/protobuf/generated_message_reflection.h
	src/google/protobuf/generated_message_util.h
	src/google/protobuf/map_entry.h
	src/google/protobuf/map_entry_lite.h
	src/google/protobuf/map_field.h
	src/google/protobuf/map_field_lite.h
	src/google/protobuf/map_field_inl.h
	src/google/protobuf/map.h
	src/google/protobuf/map_type_handler.h
	src/google/protobuf/message.h
	src/google/protobuf/message_lite.h
	src/google/protobuf/metadata.h
	src/google/protobuf/reflection.h
	src/google/protobuf/reflection_ops.h
	src/google/protobuf/repeated_field.h
	src/google/protobuf/repeated_field_reflection.h
	src/google/protobuf/service.h
	src/google/protobuf/text_format.h
	src/google/protobuf/unknown_field_set.h
	src/google/protobuf/wire_format.h
	src/google/protobuf/wire_format_lite.h
	src/google/protobuf/wire_format_lite_inl.h
	src/google/protobuf/io/coded_stream.h
	src/google/protobuf/io/printer.h
	src/google/protobuf/io/strtod.h
	src/google/protobuf/io/tokenizer.h
	src/google/protobuf/io/zero_copy_stream.h
	src/google/protobuf/io/zero_copy_stream_impl.h
	src/google/protobuf/io/zero_copy_stream_impl_lite.h
	src/google/protobuf/compiler/code_generator.h
	src/google/protobuf/compiler/command_line_interface.h
	src/google/protobuf/compiler/importer.h
	src/google/protobuf/compiler/parser.h
	src/google/protobuf/compiler/plugin.h
	src/google/protobuf/compiler/plugin.pb.h
	src/google/protobuf/compiler/cpp/cpp_generator.h
	src/google/protobuf/compiler/java/java_generator.h
	src/google/protobuf/compiler/java/java_names.h
	src/google/protobuf/compiler/javanano/javanano_generator.h
	src/google/protobuf/compiler/python/python_generator.h
	src/google/protobuf/compiler/ruby/ruby_generator.h
)

set(PROTOBUF_VERSION 10.0.0)
set(PROTOBUF_SOVERSION 10)

if(BUILD_STATIC)
    add_library(protobuf-lite ${PB_LIBPROTOBUF_LITE_SOURCES})
    add_library(protobuf ${PB_LIBPROTOBUF_SOURCES})
    add_library(libprotoc ${PB_LIBPROTOC_SOURCES})
    set_target_properties(libprotoc PROPERTIES
        VERSION ${PROTOBUF_VERSION}
        LIBRARY_OUTPUT_NAME protoc
    )
else()
    add_library(protobuf-lite SHARED ${PB_LIBPROTOBUF_LITE_SOURCES})
    set_target_properties(protobuf-lite PROPERTIES
        VERSION ${PROTOBUF_VERSION}
        SOVERSION ${PROTOBUF_SOVERSION}
    )
	
    add_library(protobuf SHARED ${PB_LIBPROTOBUF_SOURCES})
    set_target_properties(protobuf PROPERTIES
        VERSION ${PROTOBUF_VERSION}
        SOVERSION ${PROTOBUF_SOVERSION}
    )
	
    add_library(libprotoc SHARED ${PB_LIBPROTOC_SOURCES})
    set_target_properties(libprotoc PROPERTIES
        VERSION ${PROTOBUF_VERSION}
        SOVERSION ${PROTOBUF_SOVERSION}
        LIBRARY_OUTPUT_NAME protoc
    )
endif()	

add_executable(protoc src/google/protobuf/compiler/main.cc)
target_link_libraries(protoc libprotoc protobuf)

install(TARGETS protoc DESTINATION bin COMPONENT protobuf_lib)
install(TARGETS libprotoc DESTINATION lib COMPONENT protobuf_lib)
install(TARGETS protobuf DESTINATION lib COMPONENT protobuf_lib)
install(TARGETS protobuf-lite DESTINATION lib COMPONENT protobuf_lib)

if(INSTALL_PYTHON)
    add_custom_command(OUTPUT python/google
        COMMAND PROTOC=${CMAKE_CURRENT_BINARY_DIR}/protoc cd ${CMAKE_CURRENT_SOURCE_DIR}/python && python3 setup.py build
	COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/python/
        COMMAND cp -a ${CMAKE_CURRENT_SOURCE_DIR}/python/build/lib/google ${CMAKE_CURRENT_BINARY_DIR}/python/
	DEPENDS protoc
    )
    add_custom_target(python_protobuf ALL DEPENDS python/google)
    if(APPLE OR WIN32)
        install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/python/google
            DESTINATION lib/python3.4/site-packages
            COMPONENT protobuf_lib
        )
    else()
        install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/python/google
            DESTINATION lib/python3.4/dist-packages
            COMPONENT protobuf_lib
        )
    endif()
endif()

foreach(file ${PB_HEADER_FILES})
	file(RELATIVE_PATH relative_file "${PROJECT_SOURCE_DIR}/src" "${PROJECT_SOURCE_DIR}/${file}")
	get_filename_component(relative_header_dir ${relative_file} PATH)
	install(FILES ${file} DESTINATION include/${relative_header_dir})
endforeach()

include(CPackConfig.cmake)
