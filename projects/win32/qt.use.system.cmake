# include the common qt.use.system.cmake file.
include("${SuperBuild_PROJECTS_DIR}/qt.use.system.cmake")

option(PACKAGE_SYSTEM_QT
  "When enabled and USE_SYSTEM_qt is ON, packages needed Qt files" ON)
if (NOT PACKAGE_SYSTEM_QT)
  return()
endif()
set(tomvizQt5Libs
  Core
  Gui
  Help
  Network
  Widgets
  Sql
  Test
  UiTools
  Xml)
find_package(Qt5 COMPONENTS ${tomvizQt5Libs})
set(qt5_libs_file_string "set(qt5_libdirs)\n")
foreach (lib IN LISTS tomvizQt5Libs)
  set(qt5_libs_file_string
    "${qt5_libs_file_string}list(APPEND qt5_libdirs $<TARGET_FILE_DIR:Qt5::${lib}>)\n")
endforeach()
file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/cpack/qt5_bundle.cmake"
  CONTENT "${qt5_libs_file_string}")
install(CODE "
set(CMAKE_MODULE_PATH \"${CMAKE_CURRENT_BINARY_DIR}/cpack\" \${CMAKE_MODULE_PATH})
include(qt5_bundle)
list(REMOVE_DUPLICATES qt5_libdirs)
foreach(dir IN LISTS qt5_libdirs)
  file(GLOB qt_libs \"\${dir}/*.dll\")
  foreach (lib IN LISTS qt_libs)
    if(NOT lib MATCHES \"d.dll\$\")
      file(INSTALL \${lib}
        DESTINATION \"\$ENV{DESTDIR}\${CMAKE_INSTALL_PREFIX}/bin\"
        USE_SOURCE_PERMISSIONS)
    endif()
  endforeach()
endforeach()
" COMPONENT "tomviz")


function(install_qt5_plugin plugin destination)
  get_target_property(plugin_location ${plugin} LOCATION)
  install(FILES ${plugin_location}
          DESTINATION ${destination}
          COMPONENT "tomviz")
endfunction()

install_qt5_plugin(Qt5::QWindowsIntegrationPlugin "bin/platforms")
install_qt5_plugin(Qt5::QWindowsVistaStylePlugin "bin/styles")
install_qt5_plugin(Qt5::QSvgIconPlugin "bin/iconengines")
install_qt5_plugin(Qt5::QSvgPlugin "bin/imageformats")
install_qt5_plugin(Qt5::QSQLiteDriverPlugin "bin/sqldrivers")
