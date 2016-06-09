---
title: 'jQuery([selector, [context]])'
date: 2016-06-07 16:26:19
tags:
---
```
jQuery([selector, [context]])
```
# 说明
jQuery函数接收一个包含CSS选择器的字符串表达式，然后根据改字符串表达式来查找匹配HTML元素。默认情况下，$()在当前HTML document中查找DOM元素。如果指定了context参数，比如DOM元素集，或者jQuery对象，则才在这个context中查找。  
* selector
用来查找的字符串  
* context  
作为待查找的DOM元素集，文档或jQuery对象。
# 语法
```
$(selector).action()
```
* $ 表明这是一个jQuery语句
* (selector)用来选择某个HTML元素。
* action()定义操作该HTML元素的方法。
# 例子 
* 查找所有p元素，且这些元素为div元素的子元素  
```
$("div > p");
```
* 设置页面背景色  
$(document.body).css("background", "black");
* 隐藏一个表单中的所有元素  
```
$(myForm.elements).hide()
```
* 在文档的第一个表单中，查找所有的单选按钮(type值为radio的input元素)  
```
$("input:radio", document.forms[0]);
```
* 在一个由AJAX返回的XML文档中，查找所以的div元素  
```
$("div", xml.responseXML);
```
