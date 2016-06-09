---
title: 'C++11之std::men_fn用法'
date: 2016-06-09 10:34:38
tags: [C++, STL]
categories: [技术]  
---
# mem_fn系列函数介绍    
mem_fn系列函数包括: mem_fun, mem_fun_ref, mem_fn。 
* mem_fun_ref : 把成员函数转为函数对象，使用对象(引用)进行绑定。转为函数为对成员函数引用的实现，主要为兼容泛型算法使用成员函数对容器元素进行操作的场景。  
<!-- more -->
```
std::for_each(vec.begin(), vec.end(), std::mem_fun_ref(&Users::display));
```
* mem_fun : 把成员函数转为函数对象，使用对象指针进行绑定。假设for_each的第三个参数接受的是指针类型则需要换成mem_func。   
在使用成员函数作为for_each函数的参数时，需要根据具体的函数要求是指针类型还是引用类型，来区分是使用men_fun还是men_fun_ref，即使用要充分考虑使用场合，不同的情况使用不同的配接器，特别是要区分for_each的容器是Container<T>还是Container<T*>。
* mem_fn  : 把成员函数转为函数对象，使用对象指针或对象引用进行绑定  
```
总结:
Container<T>           std::mem_fun_ref  
Container<T*>          std::mem_fun  
```
* mem_fn : mem_fn是mem_fun 和mem_fun_ref的泛化，使用它无需关注容器中是T还是T*，甚至为智能指针share_ptr<T>。  
```
struct X {
    void f();
};
void g(std::vector<X> &v) {
    std::for_each(v.begin(), v.end(), std::mem_fn(&X:f));
};
void h(std::vector<X*> const &v) {
    std::for_each(v.begin(), v.end(), std::mem_fn(&X::f));
};
void k(std::vector<std::shared_ptr<X>> const & v) {
    std::for_each(v.begin(), v.end(), std::mem_fn(&X::f));
}
```
# 用法  
men_fn是一个函数适配器，其中mem即指类的成员member，fn即指类的成员function，用于适配类的成员函数，将类的成员函数转换为函数对象，使用对象指针或对象引用进行绑定。
* 将一个成员函数作用在容器上(最常用)  
```
std::for_each(v.begin(), v.end(), std::mem_fn(&Shape::draw));
```
mem_fn持有一个参数，指向成员的指针，并返回一个适用于标准或用户定义算法的函数对象。返回的函数对象和输入的函数持有同样的参数。  
可以让容器vector中的每一个元素都执行一遍Shape类的draw方法，即使容器存储的是智能指针。  
有如下代码: 
```
class Employee {
    public:
        int DoSomething() {}
};
std::vector<Employee> emps;
```
假设想要在emps上调用Employee类的DoSomething()方法，首先我们可以这样  
```
for (auto it = emps.begin(), it != emps.end(); it++) {
    (*it).DoSomething();
}
```
当在emps上像使用for_each算法时，首先需要定义一个接受一个该成员类型的函数或仿函数再调用。  
```
int GivenDoSomething(Employee& e) {
    return e.DoSomething();
}
std::for_each(emps.begin(), emps.end(), &GiveDoSOmething);
```
这样比较麻烦的是需要单独在类的外部定义一个全局函数或仿函数GiveDoSomething，若想直接调用Employee中对应的成员函数，需要借助mem_fn，例:  
```
std::for_each(emps.begin(), emps.end(), std::mem_fn(&Employee::DoSomething));  


* 帮助把一个函数指针模拟得像一个函数实体(function object)。  
