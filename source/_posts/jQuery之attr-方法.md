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
$("a").attr("href");
```  

## 设置属性值  
```
$(selector).attr(attribute, value);
$("img").attr("width", "180");
```  
## 设置多个属性/值  
```
$(selector).attr({attribute1:value1, arrtibute2:value2, ...});
//用大括号包围多对属性/值对，逗号分隔  
$("img").attr({width:"50", height:"80"});
```
# 其他使用jQuery获得内容和属性的方法  
* text() 设置或返回所选元素的文本内容，注意只是文本内容  
* html() 设置或返回所选元素的内容(包括HTML标记)  
* val() 设置或返回表单字段值  
# 总结 
|函数名|说明|例子|
|------|----|----|
|attr(name)|取得第一个匹配元素的属性值|$("input").attr("value")|
|attr(property)|将所有匹配元素以一个"名/值"形式的对象设置其属性|$("input").attr({value: "txt", title: "text"});|  
|attr(key, value)|为所有匹配的元素设置一个属性值|$("input").attr("value", "txt");|  
|attr(key, fn)|未所有匹配的元素设置一个计算属性值|$("input").attr("title", function() {return this.value});|  
|removeAttr(name)|从所有匹配的元素中删除一个属性|$("input").removeAttr("value");|  

# jQuery访问value，innerHTML  
|---|---|---|
|函数名|说明|例子|
|val()|获取第一个匹配元素的value值|$("#txt1").val()|
|val(val)|为匹配的元素shezvalue值|$("#txt1").val("txt1")|
|html()|获取第一个匹配元素的html内容|$("#dv1").html()|
|html(val)|设置每一个匹配元素的html内容|$("#dv1").html("this is a div")|
|text()|取得所有匹配文本节点的内容，冰将其连接起来|$("div").text()|
|text(val)|将所有匹配元素的值设置为val|$("div").text("divs")|  

# 使用jQuery操作CSS  
|函数名|说明|例子|
|addClass(classes)|为每个匹配的元素添加指定的类名|$("input").addClass("colorRed borderBlack");|  
|hasClass(class)|判断匹配元素集合中是否至少有一个包含了指定的css类，如果有返回true|alert($("input").hasClass("borderBlack"));  
|removeClass([classes])|从匹配元素中移除所有或指定的css类|$("input").removeClass("colorRed borderBlack");  
|toggleClass(classes)|如果存在则删除指定类，如果不存在则添加指定类|($("input").toogleClass("colorRed borderBlack");|  
|toogleClass(classes, switch)|当switch为true时，添加类，switch为false时，删除类|$("input").toggleClass("colorRed borderBlack", true);|  

addClass、removeClass、toggleClass均可添加多个类，多个类之间用空格隔开。  
removeClass方法的参数可选，如果有参数则删除指定class，如果无参数则删除匹配元素的所有class。  

# 修改CSS样式  
|---|---|
|函数名|说明|例子|
|css(name)|访问第一个匹配元素的样式属性|$("input").css("color")|
|css(properties)|把一个"名/值"对设置给所有匹配元素的样式属性|$("input").css({border:"solid 3px silver", color: "red"})|  
|css(name, value)|为匹配的元素守则同一个样式属性，如果是数字，将自动转换未像素值|$("input").css("border-width", "5");|  

对于一些常用属性，比如width，height之类，使用attr("width")和css("width")无法正常获取其值，需要如下方式获取:  
1. 高、宽相关  
|--|--|--|
|函数名|说明|例子|
|width()|获取第一个匹配元素的宽度，默认为px|$("#txt1").width()|  
|width(val)|为匹配的元素设置宽度值，默认为px|$("#txt1").width(200)|  
|height()|获取第一个匹配元素的高度，默认为px|$("#txt1").height()|  
|height(val)|为匹配的元素设置宽度值，默认为px|$("#txt1").height(20)|  
|innerWidth()|获取第一个匹配元素内部区域宽度(包括padding，不包括border)|$("#txt1").innerWidth()|    
|innerHeight()|获取第一个匹配元素内部区域高度(包括padding，不包括border)|$("#txt1").innerHeight()|  
|outerWidth([margin])|获取第一个匹配元素外部区域宽度(包括padding，border)，margin为true则包括margin，否则不包括|$("#txt1").outerWidth()|  
|outerHeight([margin])|获取第一个匹配元素外部区域高度(包括padding，border)，margin为true则包括margin，否则不包括|$("#txt1").outerHegiht(true)|
