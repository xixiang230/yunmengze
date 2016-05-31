---
title: jQuery中each遍历对象和数组
date: 2016-05-28 07:27:29
tags: [jQuery]
categories: [技术, 前端]
---
# 通用遍历  
* 遍历对象和数组，回调函数有两个参数，第一个参数未对象的成员或数组的索引，第二个未对应成员或索引的内容，如果需要退出each循环可使回调函数返回false。
each()方法为每个匹配的元素规定了运行的函数,如果改函数返回false，可用于及早停止循环。  
语法：  
$(selector).each(function(index, element))  
index 为选择器的index位置  
element当前元素，也可用this选择器  
例有如下两个select:
```
<select id="PLANTYPE">
<option value="0">所有</option>
<option value="1">新建</option>
<option value="2">续建</option>
</select>
```
```
<select id="AUDITTYPE">
<option value="0">所有</option>
<option value="1">申报</option>
<option value="2">修改</option>
</select>
```
若想使用each方法获取option中的文本值(即里面包含的"所有，新建，续建"等信息)，可这样  
1. 只使用一个each循环，从option处开始  
```
$("option").each(function(index, data) {
    console.info($(data).text()); //遍历每一个option元素，回调函数中data对应一个option元素对象。
  //console.info($(this).text()); //$(this)指代当前遍历的这个option对象
}
```
2. 从select处开始  
```
$("select").each(function(indexSelect, dataSelect) {
  $("option", dataSelect).each(function(indexOption, dataOption) {
    console.info($(this).text()); //用$(this)指代当前遍历到的对象时，函数可无参
  }) 
})
```
在这里，$("option", dataSelect)一定要加上dataSelect，或者$("option", this),表示该对象下的option
# jQuery.each(object, [callback]) 全局方法  
与jQuery对象的$().each()方法不同，jQuery全局each()函数可遍历任何对象  
1. 实现上述功能  
```
$.each($("option").function(index, data) {
    console.info(index + " " + data);
}
```
2. jQuery全局each()函数可遍历数组  
```
$.each([0, 1, 2], function(i, value) {
    console.info("Index: " + i + ": " + n);
}
```
3. jQuery全局echa()函数遍历对象  
```  
$.each({name: "liuzekun", addr: "Beijing"}), function(key, valeu) {
    console.info(key + ": " + valeu);
});
