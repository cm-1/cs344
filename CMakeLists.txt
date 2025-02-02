############################################################################
# <summary> CMakeLists.txt for OpenCV and CUDA. </summary>
# <date>    2012-02-07          </date>
# <author>  Quan Tran Minh. edit by Johannes Kast, Michael Sarahan </author>
# <email>   quantm@unist.ac.kr  kast.jo@googlemail.com msarahan@gmail.com</email>
############################################################################
# Modified slightly in this fork by Christopher Mossman

cmake_minimum_required(VERSION 2.6 FATAL_ERROR)
project(cs344)

#set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake-modules)

find_package(OpenCV REQUIRED PATHS "C:/Libraries/opencv-453/x64/vc16/lib")
find_package(CUDA REQUIRED)

link_libraries(${OpenCV_LIBS} )

set (EXECUTABLE_OUTPUT_PATH "${CMAKE_SOURCE_DIR}/bin/")

if(CUDA_FOUND)
  # compared to class settings, we let NVidia's FindCUDA CMake detect 
  # whether to build x64.  We tell it to support most devices, though, 
  # to make sure more people can easily run class code without knowing 
  # about this compiler argument
  set(CUDA_NVCC_FLAGS "
  -gencode;arch=compute_30,code=sm_30;  
  -gencode;arch=compute_35,code=sm_35;
  -gencode;arch=compute_35,code=compute_35;
")

  # add -Wextra compiler flag for gcc compilations
  if (UNIX)
    set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS} "-Xcompiler -Wextra")
    set(CMAKE_CXX_FLAGS "-stdlib=libstdc++")
  endif (UNIX)

  # add debugging to CUDA NVCC flags.  For NVidia's NSight tools.
  set(CUDA_NVCC_FLAGS_DEBUG ${CUDA_NVCC_FLAGS_DEBUG} "-G")

  add_subdirectory ("Problem Sets/Problem Set 1")
  add_subdirectory ("Problem Sets/Problem Set 2")
  add_subdirectory ("Problem Sets/Problem Set 3")
  add_subdirectory ("Problem Sets/Problem Set 4")
  add_subdirectory ("Problem Sets/Problem Set 5")
  add_subdirectory ("Problem Sets/Problem Set 6")
  add_subdirectory ("Lesson Code Snippets/Lesson 2 Code Snippets")
else(CUDA_FOUND)
  message("CUDA is not installed on this system.")
endif()
