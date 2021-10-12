macro(build_documentation DOCUMENTATION_NAME R G B)
    # Make sure that Sphinx is available and that it is at least version 1.4

    if(NOT PYTHON_EXECUTABLE)
        find_package(PythonInterp REQUIRED QUIET)
    endif()

    if(NOT SPHINX_EXECUTABLE)
        find_program(SPHINX_EXECUTABLE NAMES ${PREFERRED_SPHINX_NAMES} sphinx-build sphinx-build2)
    endif()

    execute_process(COMMAND ${SPHINX_EXECUTABLE} --version
                    OUTPUT_VARIABLE SPHINX_OUTPUT
                    OUTPUT_STRIP_TRAILING_WHITESPACE)

    string(REGEX REPLACE "^.* " ""
           SPHINX_VERSION "${SPHINX_OUTPUT}")

    set(MINIMUM_SPHINX_VERSION 1.4)

    if(SPHINX_VERSION VERSION_LESS ${MINIMUM_SPHINX_VERSION})
        message(FATAL_ERROR "Sphinx ${MINIMUM_SPHINX_VERSION} or later is required...")
    endif()

    # Build the documentation for OpenCOR

    string(TIMESTAMP SPHINX_YEAR "%Y")

    execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/src/conf.py
                                                     ${CMAKE_CURRENT_BINARY_DIR}/conf.py)

    file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/conf.py
        \n
        copyright\ =\ u'2011-${SPHINX_YEAR},\ University\ of\ Auckland'\n
        html_theme\ =\ 'theme'\n
        html_show_sphinx\ =\ False\n
        html_show_copyright\ =\ False\n
    )

    add_custom_target(Sphinx ALL
                      COMMAND ${SPHINX_EXECUTABLE} -q -c ${CMAKE_CURRENT_BINARY_DIR}
                                                   ${CMAKE_CURRENT_SOURCE_DIR}/src
                                                   ${CMAKE_CURRENT_BINARY_DIR}/html
                      COMMAND ${PYTHON_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/theme/cmake/stringreplace.py
                                                   ${CMAKE_CURRENT_BINARY_DIR}/html/_static/theme.css
                                                   "103, 103, 103"
                                                   "${R}, ${G}, ${B}"
                      COMMENT "Building the ${DOCUMENTATION_NAME} documentation for OpenCOR")
endmacro()
