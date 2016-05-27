---
title: jQuery选择器模糊匹配
date: 2016-05-27 23:51:42
tags: [jQuery]  
categories: [技术, 前端]  
---
1. name属性值前缀为liu的所有div的jQuery对象  
```
$("div[name^='liu']");
```  
2. name属性值后缀未kun的所有div的jQuery对象  
```
$("div[name$='kun']");  
```  
3. name属性值中包含ze的所有div的jQuery对象  
```
$("div[name*='ze']");  
```  

