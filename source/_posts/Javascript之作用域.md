---
title: Javascript之作用域
date: 2016-10-18 19:12:11
tags: [Javascript]
categories: [技术]
---
# 问题的引出
```javascript
var name = 'baidu';
function print() {
    alert(name);
    var name = 'tecent';
    alert(name);
    alert(age);
}
print()
```
<!-- more -->
运行结果为：
```
undefined
tecent
[脚本出错]
```
# JavaScript的作用域链

<blockquote><p>JavaScript中的函数运行在它们被定义的作用域里，而不是它们被执行(调用)的作用域里</p></blockquote>
<blockquote><p>JavaScript中一切皆对象，包括函数也是对象</p></blockquote>
JavaScript的语法风格和C/C++类似, 但作用域的实现却和C/C++不同，并非用“堆栈”方式，而是使用"列表"的方式：
1. 任何执行(函数调用)上下文时刻的作用域, 都是由作用域链(scope chain)来实现。
2. 在一个函数被定义的时候, 会将它定义时刻的scope chain链接到这个函数对象的[[scope]]属性。
3. 在一个函数对象被调用的时候，会创建一个活动对象, 对于每一个函数的形参，都命名为该活动对象的命名属性, 然后将这个活动对象做为此时的作用域链(scope chain)最前端, 并将这个函数对象的[[scope]]属性加入到scope chain中。举个栗子：
```javascript
var func = function(name, age) {
    var name = 'baidu';
    ......
}
func();
```
当在执行func的定义语句时，会创建关于这个函数对象的[[scope]]属性，该属性属于内部属性，只有JavaScript引擎才可以访问，并将[[scope]]属性链接到定义它的作用域链上。又因为func是定义在全局环境中，所以此时[[scope]]属性window active object。

当在调用func时，JavaScript引擎在预编译阶段为之创建一个活动对象和函数arguments属性(其值为数组形式，用于保存实参值)，假设该活动对象为funcObj，给funcObj对象添加两个命名属性funcObj.name，funcObj.age，对于每一个在这个函数中申明的局部变量和函数定义，都会作为活动对象的同名命名属性，然后将调用参数分别赋值给形参，对于缺失的调用参数赋值为undefined。最后该活动对象作为scope chain的最前端，并将func的[[scope]]属性加入到scope chain中。

有了这个作用域链，在执行标志符解析时，就会逆向查询当前scope chain列表的每一个活动对象的属性，如果找到同名就返回，找不到即意味着该标志符没有被定义。注意：因为函数对象的[[scope]]属性是在定义一个函数的时候决定的。而非在调用执行时候决定。所以就会出现第一节中，调用print()函数时，打印undefined。
```javascript
function factory() {
    var name = 'baidu';
    var intro = function() {
        alert(name);
    }
    retrun intro;
}

function app(para) {
    var name = para;
    var func = factory();
    func();
}

app('tecent');
```
当调用app('tecent')时，scope chain由：{window全局活动对象}->{app活动对象} 组成。再刚进入app函数体时，app活动对象有一个arguments属性，两个值为undefined的属性:name和func，和一个值为'tecent'的属性para。此时scope chain为：
```javascript
[[scope chain]] = [
{
    para: 'tecent',
    name: undefined,
    func: undefined,
    arguments: []
},
{
 window call object
}
]
```
当调用进入factory的函数体时，factory的scope chain为：
```javascript
[[scope chain]] = [
{
    name: undefined,
    intor: undefined
},
{
    window call object
}
]
```
此时的作用域并不包含app的活动对象。在定义intro函数的时候，intor函数的[[scope]]为：
```javascript
[[scope chain]] = [
{
    name: 'baidu',
    intor: undefined
},
{
    window call object
}
]
```
从factory函数返回以后，在app体内调用intor的时候，发生了标志符解析，此时的scope chain为:
```javascript
[[scope chain]] = [
{
    intro call object
},
{
    name: 'baidu'
    intor: undefined
},
{
    window call object
}
]
```
因为scope
chain中，并不包含factory活动对象，所以name标志符解析的结果应该factory活动对象中的name属性，也就是'baidu'。

# JavaScript预编译  
JavaScript是一种脚本语言，一边执行一遍翻译。
```javascript
alert(typeof eve); //打印function
function eve() {
    alert('badiu');
}
```
alert之所以会打印function，是因为在JavaScript中，存在预编译过程，JavaScript在执行每一段代码前，都会预先处理var关键字和function定义式(函数定义式和函数表达式)
