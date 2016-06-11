---
title: 'C++ Effective STL系列阅读笔记之ptr_fun, mem_fun, mem_fun_ref'
date: 2016-06-10 09:03:45
tags: [C++]
categories: [技术]  
---
# 前言  
* mem_fun     (C++98)  #把成员函数转换为函数对象，使用对象指针进行绑定，即使用于容器元素为对象指针的场景。  
* mem_fun_ref (C++98)  #把成员函数转换为函数对象，使用对象(引用)进行绑定，即使用与容器元素为对象或对象引用的场景。  
* mem_fn      (C++11)  #把成员函数转换为函数对象，不区分上述两种场景，使用对象指针或对象(引用)均可，推荐使用。   
<!-- more -->
# C++对象调用函数三种方式  
假设需要在对象x上调用函数f，C++语法提供如下三种模式:  
{% vimhl C++ true %}
 f(x);            //f为非成员函数
 x.f();           //f为成员函数，x为对象或对象的引用
 ptrX->f();       //f为成员函数，ptrX为指向对象x的指针
{% endvimhl %}
现假设有一个X类型对象的容器vecX，f函数为非成员函数，为了遍历所有容易元素并执行调用函数f可以这样:
{% vimhl C++ true %}
 for_each(vecX.begin(), vec.end(), f);  
 for_each(vecX.begin(), vec.end(), ptr_fun(f));  //ptr_fun可有可无，也无运行时的性能损失。
{% endvimhl %}
上述代码可编译成功，是因为for_each的实现是这样的:  
{% vimhl C++ true %}
 template<typename InputIterator, typename Function>
 Function for_each(InputIterator begin, InputIterator end, Function f) {
     while (begin != end) {
        f(*begin++);
 }
{% endvimhl %}
也就是说for_each算法的实现基于f(x)这种调用方式，即以非成员函数的语法实现。

# 调用成员函数  
假设f为对象成员函数，对应存放类型X的容器vecX和存放对象X的指针容器vecPtrX，立刻可联想到如下调用方式:  
{% vimhl C++ true %}
 for_each(vecX.begin(), vecX.end(), &X::f);  
 for_each(vecPtrX.begin(), vecPtrX.end(), &X::f);  
{% endvimhl %}
但由于for_each的实现，这样实质上这样遍历容器中的所有元素: X::f(x); X::f(ptrX); 这显然是有问题的，编译也不会通过。为了使成员函数调用也表现得如同非成员函数，需要将成员函数转换为函数对象。
这时就需要借助men_系列函数了，然而当容器元素为X类型对象或引用和容器元素为X类型指针时，我们知道其调用方式其实是不一样的，这时men_fun_ref和men_fun就出来了，它们都是函数模板，声明类似如下:  
{% vimhl C++ true %}
 template<typename R, typename C>  
 men_fun_t<R,C> mem_fun(R (C::*pmf));  //非const成员函数，C是类，R是所指向的成员函数的返回类型，合起来R (C::*pmf)为函数的类型。  
{% endvimhl %}
即mem_fun的参数为一个指向某个成员函数的指针pmf，返回一个mem_fun_t类型的对象。mem_fun_t为一个仿函数，拥有成员函数的指针，并提供operator()操作函数，operator()操作函数就是通过调用传进来的成员函数来实现对对象成员的成员函数调用的。
{% vimhl C++ true %}
 for_each(vecPtrX.begin(), vecPtrX.end(), mem_fun(&X::f));
 for_each(vecX.begin(), vecX.end(), mem_fun_ref(&X::f));
{% endvimhl %}
总的来说，mem_fun和mem_fun_ref就是将成员函数变换成仿函数，实现成员函数的调用方式变化成非成员函数的调用方式，从而兼容for_each算法的实现。而像men_fun_t这样的类成为函数对象配接器对象。
当然，随着C++11中men_fn的引入，我们再也无需区分容器元素到底是对象还是指针而纠结用men_fun还是men_fun_ref了。
