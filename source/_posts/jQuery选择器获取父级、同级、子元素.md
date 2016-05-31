---
title: jQuery选择器获取父级、同级、子元素
date: 2016-05-29 20:09:59
tags: [jQuery]
categories: [技术, 前端]
---
1. 获取父级元素
parent([expr])
```
$("a").parent().addClass("xxx");
```
2. 获取同级元素的下一个同级元素(下一个同级元素)
next([expr])
```
$("li.third-item").next().css("background-color", "red");
```
3. 获取指定元素后边的所有同级元素 
nextAll([expr])
```
var p_next = $("p").nextAll();
p_next.addClass("p_next_all");
```
4. 获取指定元素后边的所有同级元素，之后加上指定的元素  
andSelf()
```
var p_nex = $("p").nextAll().andSelf(); //选择p标签后面的所有同级标签，以及自己
p_nex.addClass("p_next_all");
```
5. 获取指定元素的上一个同级元素
prev()
6. 获取指定元素的前边所有的同级元素  
preAll()  

# 获取子元素  
1.  >  
` var aNodes = $("ul > a");  #查找ul下的所有a标签`  
2. children()  
3. find()  
children() 和 find()的异同  
children方法获得的仅仅是元素第一下级的子元素，即immediate children  
find方法可用于获得所有的下级元素，即descendants of these elements in the DOM tree  
childeren方法的参数selector是可选的，用来过滤子元素  
