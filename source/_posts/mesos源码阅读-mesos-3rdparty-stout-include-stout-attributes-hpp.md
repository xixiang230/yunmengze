---
title: mesos源码阅读-mesos-3rdparty-stout-include-stout-attributes.hpp
date: 2017-09-15 12:55:45
tags: [mesos]
---


#ifndef __STOUT_ATTRIBUTES_HPP__
#define __STOUT_ATTRIBUTES_HPP__

__attribute__是GNU C特色之一,__attribute__ 可以设置函数属性（Function Attribute ）、变量属性（Variable Attribute ）和类型属性（Type Attribute ）。

 一些库函数，本身没有返回值，例如abort（）和exit（），在编译的时候，GCC自动按照这个规则编译。而对于自己定义的函数，如果你不想让它有返回值，那么可以使用__attribute__
  ((noreturn))

定义有返回值的函数时，而实际情况有可能没有返回值，此时编译器会报错。加上attribute((noreturn))则可以很好的处理类似这种问题。
用法：
__attribute__((noreturn))
C++11预定义的通用属性包括[[noreturn]] 和 [[carries_dependency]] 两种。
[[noreturn]]
是用于标识不会返回的函数的。这里必须注意，不会返回和没有返回值的（void）函数的区别。

没有返回值的void函数在调用完成后，调用者会接着执行函数后的代码；而不会返回的函数在被调用完成后，后续代码不会再被执行。

[[noreturn]]
主要用于标识那些不会将控制流返回给原调用函数的函数，典型的例子有：有终止应用程序语句的函数、有无限循环语句的函数、有异常抛出的函数等。通过这个属性，开发人员可以告知编译器某些函数不会将控制流返回给调用函数，这能帮助编译器产生更好的警告信息，同时编译器也可以做更多的诸如死代码消除、免除为函数调用者保存一些特定寄存器等代码优化工作。

下面代码：

void DoSomething1();
void DoSomething2();

[[noreturn]] void ThrowAway(){
    throw "expection"; //控制流跳转到异常处理
}

void Func(){
    DoSomething1();
    ThrowAway();
    DoSomething2(); // 该函数不可到达
}

由于ThrowAway 抛出了异常，DoSomething2永远不会被执行。这个时候将ThrowAway标记为noreturn的话，编译器会不再为ThrowAway之后生成调用DoSomething2的代码。当然，编译器也可以选择为Func函数中的DoSomething2做出一些警告以提示程序员这里有不可到达的代码。

不返回的函数除了是有异常抛出的函数外，还有可能是有终止应用程序语句的函数，或是有无限循环语句的函数等。事实上，在C++11的标准库中，我们都能看到形如：
[[noreturn]] void abort(void) noexcept;
这样的函数声明。最常见的是abort函数。abort总是会导致程序运行的停止，甚至连自动变量的析构函数以及本该在atexit() 时调用的函数全都不调用就直接退出了。因此声明为[[noreturn]] 是有利于编译器优化的。

尽量不要对可能会有返回值的函数使用[[noreturn]]
If a function f is called where f was previously declared with the noreturn attribute and f eventually returns, the behavior is undefined.

#ifdef __WINDOWS__
#define NORETURN __declspec(noreturn)
#else
#define NORETURN __attribute__((noreturn))
#endif // __WINDOWS__


#endif // __STOUT_ATTRIBUTES_HPP__
