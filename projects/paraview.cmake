set(VTK_SMP_IMPLEMENTATION_TYPE "Sequential")
if (tbb_ENABLED)
  set(VTK_SMP_IMPLEMENTATION_TYPE "TBB")
endif ()

set(paraview_extra_cmake_args)
if (QT_HELP_GENERATOR)
  list(APPEND paraview_extra_cmake_args
    -DQT_HELP_GENERATOR:FILEPATH=${QT_HELP_GENERATOR})
else()
  list(APPEND paraview_extra_cmake_args
    -DPARAVIEW_ENABLE_EMBEDDED_DOCUMENTATION:BOOL=OFF)
endif()
if (QT_XMLPATTERNS_EXECUTABLE)
  list(APPEND paraview_extra_cmake_args
    -DQT_XMLPATTERNS_EXECUTABLE:FILEPATH=${QT_XMLPATTERNS_EXECUTABLE})
endif()

add_external_project(paraview
  DEPENDS qt python ffmpeg
  DEPENDS_OPTIONAL tbb png

  CMAKE_ARGS
    -DPARAVIEW_BUILD_QT_GUI:BOOL=ON
    -DPARAVIEW_ENABLE_QT_SUPPORT:BOOL=ON
    -DPARAVIEW_BUILD_SHARED_LIBS:BOOL=ON
    -DPARAVIEW_BUILD_TESTING:BOOL=OFF
    -DPARAVIEW_CUSTOM_LIBRARY_SUFFIX:STRING=
    -DVTK_PYTHON_FULL_THREADSAFE:BOOL=ON
    -DVTK_NO_PYTHON_THREADS:BOOL=OFF
    -DVTK_PYTHON_VERSION:STRING=3
    -DPARAVIEW_ENABLE_PYTHON:BOOL=ON
    -DPARAVIEW_ENABLE_CATALYST:BOOL=OFF
    -DPARAVIEW_ENABLE_COMMANDLINE_TOOLS:BOOL=OFF
    -DPARAVIEW_ENABLE_WEB:BOOL=ON
    -DPARAVIEW_USE_QTHELP:BOOL=OFF
    # Disable for now as kits requires CMake 3.12
    #    -DPARAVIEW_ENABLE_KITS:BOOL=ON
    -DPARAVIEW_PLUGIN_ENABLE_AcceleratedAlgorithms:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_AnalyzeNIfTIReaderWriter:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_ArrowGlyph:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_BagPlotViewsAndFilters:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_CDIReader:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_DigitalRockPhysics:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_EmbossingRepresentations:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_ExplicitStructuredGrid:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_EyeDomeLighting:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_GMVReader:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_GeodesicMeasurement:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_GmshReader:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_InSituExodus:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_Moments:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_MooseXfemClip:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_NetCDFTimeAnnotationPlugin:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_NonOrthogonalSource:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_PanoramicProjectionView:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_SLACTools:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_StreamLinesRepresentation:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_StreamingParticles:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_SurfaceLIC:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_ThickenLayeredCells:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_VDFReaderPlugin:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_VTKmFilters:BOOL=FALSE
    -DPARAVIEW_PLUGIN_ENABLE_pvNVIDIAIndeX:BOOL=FALSE
    -DPARAVIEW_ENABLE_FFMPEG:BOOL=ON
    -DCMAKE_CXX_STANDARD:STRING=11
    -DCMAKE_CXX_STANDARD_REQUIRED:BOOL=ON
    -DVTK_SMP_IMPLEMENTATION_TYPE:STRING=${VTK_SMP_IMPLEMENTATION_TYPE}

    ${paraview_extra_cmake_args}

    # Specify the apple app install prefix. No harm in specifying it for all
    # platforms but will only affect macOS, same with install name dir.
    -DMACOSX_APP_INSTALL_PREFIX:PATH=<INSTALL_DIR>/Applications
    -DCMAKE_INSTALL_NAME_DIR=<INSTALL_DIR>/lib

  LIST_SEPARATOR +
)
