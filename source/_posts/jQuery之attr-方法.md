---
title: jQuery之attr()方法
date: 2016-05-27 23:38:26
tags: [jQuery]
categories: [技术, 前端]
---
# 用法
attr()方法用于设置或返回被选元素的属性值  
## 返回属性值  
```
$(selector).attr(attribute);
$("img").attr("width");
```  

## 设置属性值  
```
$(selector).attr(attribute, value)```
$("img").attr("width", "180");
```  
## 设置多个属性/值  
```
$(selector).attr({attribute1:value1, arrtibute2:value2, ...});
//用大括号包围多对属性/值对，逗号分隔  
$("img").attr({width:"50", height:"80"});
```


