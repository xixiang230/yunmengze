---
title: mesos源码阅读-mesos/3rdparty/stout-CMakeLists.txt
date: 2017-09-14 10:36:38
tags: [mesos]
---

{% vimhl c++ true %}
/*
如果编译软件使用了外部库，事先又不知道它的头文件和链接库的位置，在编译命令中需要加上包含它们的查找路径，CMake使用find_package命令来解决这个问题。

find_package可以根据cmake内置的.cmake脚本去找相应库的模块，当然，也内建了很多库的模块变量，调用了find_package之后，会有相应的变量生效。

比如调用了find_package(Qt5Widgets)，find_package(Qt4 COMPONENTS QTCORE QTGUI QTOPENGL QTSVG)返回之后就会有变量Qt5Widgets_FOUND，Qt5Widgets_INCLUDE_DIRS相应的变量生效。

然后就可以在CMakeLists.txt里面使用上述的变量了。类似如下：

INCLUDE_DIRECTORIES(${QT_INCLUDES})
INCLUDE_DIRECTORIES(${Qt5Widgets_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(${Qt5Svg_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(${Qt5OpenGL_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(${Qt5Concurrent_INCLUDE_DIRS})

1. 使用外部库
为了能支持各种常见的库和包，CMake自带了很多模块。可以通过命令 cmake --help-module-list 得到CMake支持的模块的列表。

让我们以threads库为例。CMake中有个FindThreads.cmake模块。只要使用find_package(Threads)调用这个模块，cmake会自动给一些变量赋值，然后就可以在CMake脚本中使用它们了。变量的列表可以查看cmake模块文件，或者使用命令 cmake --help-module FindThreads。


2. 使用CMake没有自带查找模块的外部库
假设你想要使用LibXML++库。在写本文时，CMake还没有一个libXML++的查找模块。但是可以在网上搜索到一个（ FindLibXML++.cmake ）。在 CMakeLists.txt 中写，
find_package(LibXML++ REQUIRED)
include_directories(${LibXML++_INCLUDE_DIRS})
set(LIBS ${LIBS} ${LibXML++_LIBRARIES})

如果包是可选的，可以忽略 REQUIRED 关键字，通过 LibXML++_FOUND布尔变量来判断是否找到。检测完所有的库后，对于链接目标有，
target_link_libraries(exampleProgram ${LIBS})
为了能正常的工作，需要把 FindLibXML++.cmake文件放到CMake的模块路径。因为CMake还不包含它，需要在项目中指定。在项目根目录下创建一个
cmake/Modules/ 文件夹，并且在主 CMakeLists.txt 中包含下面的代码：
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
"${CMAKE_SOURCE_DIR}/cmake/Modules/")

可能你已经猜到了，把刚才的需要用到的CMake模块放到这个文件夹下 一般来说就是这样。有些库可能还需要些其他的什么，所以要再看一下 FindSomething.cmake 文件的文档。

2.1 包含组件的包
有些库不是一个整体，还包含一些依赖的库或者组件。一个典型的例子是Qt库，它其中包含QtOpenGL和QtXml组件。使用下面的find_package 命令来使用这些组件：
find_package(Qt COMPONENTS QtOpenGL QtXml REQUIRED)

如果包是可选的，这里同样可以忽略 REQUIRED 关键字。这时可以使用 <PACKAGE>_<COMPONENT>_FOUND 变量（如 Qt_QtXml_FOUND ）来检查组件是否被找到。下面的 find_package 命令是等价的：

find_package(Qt COMPONENTS QtOpenGL QtXml REQUIRED)
find_package(Qt REQUIRED COMPONENTS QtOpenGL QtXml)
find_package(Qt REQUIRED QtOpenGL QtXml)

如果包中的组件有些是必需的，有些不是，可以调用 find_package 两次：

find_package(Qt COMPONENTS QtXml REQUIRED)
find_package(Qt COMPONENTS QtOpenGL)

或者也可以不加 REQUIRED 关键字用 find_package 同时查找全部组件，然后再显式地检查必需的组件：
find_package(Qt COMPONENTS QtOpenGL QtXml)
if ( NOT Qt_FOUND OR NOT QtXml_FOUND )
  message(FATAL_ERROR "Package Qt and component QtXml required, but not
  found!")
endif( NOT Qt_FOUND OR NOT QtXml_FOUND )

3 包查找是如何工作的
      find_package() 命令会在模块路径中寻找 Find<name>.cmake
      ，这是查找库的一个典型方式。首先CMake查看 ${CMAKE_MODULE_PATH}
      中的所有目录，然后再查看它自己的模块目录
      <CMAKE_ROOT>/share/cmake-x.y/Modules/ 。

      如果没找到这样的文件，会寻找 <Name>Config.cmake 或者
      <lower-case-name>-config.cmake
      ，它们是假定库会安装的文件（但是目前还没有多少库会安装它们）。不做检查，直接包含安装的库的固定值。

      前面的称为模块模式，后面的称为配置模式。配置模式的文件的编写见 这里的文档
      。可能还会用到 importing and exporting targets 这篇文档。

      模块系统好像还没有文档，所以本文主要讨论这方面的内容。

      不管使用哪一种模式，只要找到包，就会定义下面这些变量：

      <NAME>_FOUND
      <NAME>_INCLUDE_DIRS or <NAME>_INCLUDES
      <NAME>_LIBRARIES or <NAME>_LIBRARIES or <NAME>_LIBS
      <NAME>_DEFINITIONS
      这些都在 Find<name>.cmake 文件中。

      现在，在你的代码（要使用库 <name> 的代码）的顶层目录中的 CMakeLists.txt
      文件中，我们检查变量 <NAME>_FOUND
      来确定包是否被找到。大部分包的这些变量中的包名是全大写的，如 LIBFOO_FOUND
      ，有些包则使用包的实际大小写，如 LibFoo_FOUND 。如果找到这个包，我们用
      <NAME>_INCLUDE_DIRS 调用 include_directories() 命令，用 <NAME>_LIBRARIES
      调用 target_link_libraries() 命令。

      这些约定的文档在CMake模块目录中的 readme.txt 文件中。

      REQUIRED 和其他可选的 find_package 的参数被 find_package
      传给模块，模块由此确定操作。

      5 编写查找模块
      首先，注意传给 find_package
      的名字或者前缀，是用于全部变量的部分文件名和前缀。这很重要，名字必须完全匹配。不幸的是很多情况下，即使是CMake自带的模块，也有不匹配的名字，导致各种问题。

      模块的基本操作应该大体按下面的顺序：

      使用 find_package 检测库依赖的其他的库
      需要转发 QUIETLY 和 REQUIRED 参数（比如，如果当前的包是 REQUIRED
      的，它的依赖也应该是）
      可选地使用pkg-config来检测 include/library
      的路径（如果pkg-config可用的话）
      分别使用 find_path 和 find_library 寻找头文件和库文件
      pkg-config提供的路径只用来作为查找位置的提示
      CMake也有很多其他查找路径是写死的
      结果应该保存在 <name>_INCLUDE_DIR 和 <name>_LIBRARY
      变量中（注意不是复数形式）
      设置 <name>_INCLUDE_DIRS 到 <name>_INCLUDE_DIR <dependency1>_INCLUDE_DIRS
      ...
      设置 <name>_LIBRARIES 到 <name>_LIBRARY <dependency1>_LIBRARIES ...
      依赖使用复数形式，包自身使用 find_path 和 find_library 定义的单数形式
      调用 find_package_handle_standard_args() 宏来设置 <name>_FOUND
      变量，并打印一条成功或者失败的消息
      5.1 查找文件

      然后是实际的检测。给 find_path 和 find_library
      提供一个变量名作为第一个参数。如果你需要多个 include
      路径，用不同的变量名多次调用 find_path ， find_library 类似。

      NAMES 指定目标的一个或多个名字，只要匹配上一个，就会选中它。在 find_path
      中应该使用主头文件或者C/C++代码导入的文件。也有可能会包含目录，比如
      alsa/asound.h，它会使用 asound.h 所在文件夹的父目录作为结果。

      PATHS
      用来给CMake提供额外的查找路径，他不应该用于定义pkg-config以外的东西（CMake有自己的内置默认值，如果需要可以通过各种配置变量添加更多）。如果你不使用它，忽略这部分内容。

      PATH_SUFFIXES 对于某些系统上的库很有用，这类库把它们的文件放在类似
      /usr/include/ExampleLibrary-1.23/ExampleLibrary/main.h
      这样的路径。这种情况你可以使用 NAMES ExampleLibrary/main.h PATH_SUFFIXES
      ExampleLibrary-1.23
      。可以指定多个后缀，CMake会在所有包含的目录和主目录逐一尝试，也包括没有后缀的情况。

      库名不包括UNIX系统上使用的前缀，也不包括任何文件扩展名或编译器标准之类的，CMake会不依赖平台地检测它们。如果库文件名中有库的版本号，那么它仍然需要。
      7 查找模块的常见问题
      文件名和变量名中的大小写问题或者名字不匹配问题
      模块不检查 <name>_FIND_REQUIRED 或 <name>_FIND_QUIETLY ，因此 find_package
      的参数 QUIET 和 REQUIRED 没有效果
      没有设置 <name>_INCLUDE_DIRS 和 <name>_LIBRARIES ，只有单数形式的可用
find_package被用来在系统中自动查找配置构建工程所需要的程序库，CMake自带的模块文件里有大半是对各种常见开源库的find_package支持。
FIND_PACKAGE( <name> [version] [EXACT] [QUIET] [NO_MODULE] [ [ REQUIRED | COMPONENTS ] [ componets... ] ] )
用来调用预定义在CMAKE_MODULE_PATH下的Find<name>.cmake模块，也可以自己定义
Find<name>模块，将其放入工程的某个目录中，通过 SET(CMAKE_MODULE_PATH
dir)设置查找路径，供工程FIND_PACKAGE使用。这条命令执行后，CMake会到变量CMAKE_MODULE_PATH指示的目录中查找文件Findname.cmake并执行。
version参数
需要一个版本号，它是正在查找的包应该兼容的版本号（格式是major[.minor[.patch[.tweak]]]）。
EXACT选项
要求版本号必须精确匹配。如果在find-module内部对该命令的递归调用没有给定[version]参数，那么[version]和EXACT选项会自动地从外部调用前向继承。对版本的支持目前只存在于包和包之间（详见下文）。
QUIET 参数：
会禁掉包没有被发现时的警告信息。对应于Find<name>.cmake模块中的
NAME_FIND_QUIETLY。
REQUIRED 参数
其含义是指是否是工程必须的，表示如果报没有找到的话，cmake的过程会终止，并输出警告信息。对应于Find<name>.cmake模块中的
NAME_FIND_REQUIRED 变量。
COMPONENTS参数
在REQUIRED选项之后，或者如果没有指定REQUIRED选项但是指定了COMPONENTS选项，在它们的后面可以列出一些与包相关（依赖）的部件清单（components
list）
示例：
FIND_PACKAGE( libdb_cxx REQUIRED)
这条命令执行后，CMake 会到变量 CMAKE_MODULE_PATH 指示的目录中查找文件
Findlibdb_cxx.cmake 并执行。包查找是如何工作的
find_package() 命令会在模块路径中寻找 Find<name>.cmake
，这是查找库的一个典型方式。首先CMake查看${CMAKE_MODULE_PATH}
中的所有目录，然后再查看它自己的模块目录 <CMAKE_ROOT>/share/cmake-x.y/Modules/
。

如果没找到这样的文件，会寻找 <Name>Config.cmake 或者
<lower-case-name>-config.cmake
，它们是假定库会安装的文件（但是目前还没有多少库会安装它们）。不做检查，直接包含安装的库的固定值。

前面的称为模块模式，后面的称为配置模式。配置模式的文件的编写见 这里的文档
。可能还会用到 importing and exporting targets 这篇文档。

模块系统好像还没有文档，所以本文主要讨论这方面的内容。

不管使用哪一种模式，只要找到包，就会定义下面这些变量：不管使用哪一种模式，只要找到包，就会定义下面这些变量：

<NAME>_FOUND
<NAME>_INCLUDE_DIRS or <NAME>_INCLUDES
<NAME>_LIBRARIES or <NAME>_LIBRARIES or <NAME>_LIBS
<NAME>_DEFINITIONS
这些都在 Find<name>.cmake 文件中。

现在，在你的代码（要使用库 <name> 的代码）的顶层目录中的 CMakeLists.txt
文件中，我们检查变量<NAME>_FOUND
来确定包是否被找到。大部分包的这些变量中的包名是全大写的，如 LIBFOO_FOUND
，有些包则使用包的实际大小写，如 LibFoo_FOUND 。如果找到这个包，我们用
<NAME>_INCLUDE_DIRS 调用 include_directories() 命令，用 <NAME>_LIBRARIES 调用
target_link_libraries() 命令。

这些约定的文档在CMake模块目录中的 readme.txt 文件中。

REQUIRED 和其他可选的 find_package 的参数被 find_package
传给模块，模块由此确定操作。

用户代码总体上应该使用上述的简单调用格式查询需要的包。本命令文档的剩余部分则详述了find_package的完整命令格式以及具体的查询过程。期望通过该命令查找并提供包的项目维护人员，我们鼓励你能继续读下去。

该命令在搜索包时有两种模式：“模块”模式和“配置”模式。当该命令是通过上述的精简格式调用的时候，用的就是模块模式。在该模式下，CMake搜索所有名为Find<package>.cmake的文件，这些文件的路径由安装CMake时指定的CMAKE_MODULE_PATH变量指定。如果查找到了该文件，它会被CMake读取并被处理。该模式对查找包，检查版本以及生成任何别的必须信息负责。许多查找模块（find-module）仅仅提供了有限的，甚至根本就没有对版本化的支持；具体信息查看该模块的文档。如果没有找到任何模块，该命令会进入配置模式继续执行。
*/

// 查找threads库，REQUIRED表如果没有找到，cmake会停止处理，并报告一个错误
find_package(Threads REQUIRED) 

/*
add_library 使用指定的源文件向工程中添加一个库。
add_library(<name> [STATIC | SHARED | MODULE] [EXCLUDE_FROM_ALL] source1 source2 … sourceN) 
添加一个名为<name>的库文件，该库文件将会根据调用的命令里列出的源文件来创建。<name>对应于逻辑目标名称，而且在一个工程的全局域内必须是唯一的。待构建的库文件的实际文件名根据对应平台的命名约定来构造（比如lib< name >.a或者< name >.lib）。指定STATIC，SHARED，或者MODULE参数用来指定要创建的库的类型。STATIC库是目标文件的归档文件，在链接其它目标的时候使用。SHARED库会被动态链接，在运行时被加载。MODULE库是不会被链接到其它目标中的插件，但是可能会在运行时使用dlopen-系列的函数动态链接。

如果没有类型被显式指定，这个选项将会根据变量BUILD_SHARED_LIBS的当前值是否为真决定是STATIC还是SHARED。

add_library  用于生成一个库文件。
add_library(libhello ${LIB_SRC})        //生成libhello.lib文件
add_library(libhello SHARED ${LIB_SRC}) //生成动态库文件
*/

add_library(stout INTERFACE)
target_include_directories(stout INTERFACE include)

target_link_libraries(
  stout INTERFACE
  apr
  boost
  curl
  elfio
  glog
  picojson
  protobuf
  Threads::Threads
  zlib
  $<$<PLATFORM_ID:Linux>:rt dl svn>
  $<$<PLATFORM_ID:Darwin>:svn>
  $<$<PLATFORM_ID:Windows>:Ws2_32 IPHlpAPI Mswsock Secur32 Userenv>)

add_subdirectory(tests)
