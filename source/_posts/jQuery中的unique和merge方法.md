---
title: jQuery中的unique和merge方法
date: 2016-07-15 20:44:27
tags: [jQuery]
categories: [技术]
---
# $.unique用法  
jQuery.unique(array)函数将通过搜索数组对象，排序数组，并移除任何重复的元素。
{% codeblock lang:js %}
$.unique([1,2,5,7,5,4,9]); //[9,4,7,5,2,1]   
{% endcodeblock %}
# $.merge用法  
jQuery.merge(firstArray, secondArray)函数用于修改第一个数组的内容，并将第二个数组的内容添加到第一个数组中。  
{% codeblock lang:js %}
$.merge([0,1,2], [2,3,4]); //[0,1,2,2,3,4]  
{% endcodeblock %}
