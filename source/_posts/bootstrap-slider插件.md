---
title: bootstrap-slider插件
date: 2016-06-12 22:39:23
tags: [botstrap-slider]  
categories: [技术, 前端]  
---
# 说明  
最近的预案平台项目中总是用到这个插件，遇到问题就查文档已经让我没法集中精力coding了，先总结一番相关用法。  
# slider使用
* 创建一个slider  
```
var mySlider = $("input.slider").slider();
```
* 获取slider值  
```
var value = mySlider.slider('getValue');  
```
* 设置slider值   
```
mySlider.slider('setValue', 5).slider('setValue', 7);  
```
```
