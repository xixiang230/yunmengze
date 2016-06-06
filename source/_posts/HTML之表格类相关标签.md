---
title: HTML之表格类相关标签
date: 2016-06-05 21:29:58
tags: [HTML]
categories: [技术, 前端]
---
# 定义HTML表格  
简单的HTML表格由`<table>`元素以及一个或多个tr、th、td元素组成。  
* `<table>`元素定义表格  
* `<tr>`元素定义表格行(row)  
* `<td>`元素定义表格单元  
* `<th>`元素定义表头

# th与td的区别  
`<td>` 表示内容单元格  
`<th>` 表示标题，一般用在首行的每一列，内容会被自动加粗  
<!-- more -->  

例子：
```
<table border="5">
    <tr>
        <td>name</td>
        <td>age</td>
    </tr>
    <tr>
        <td>baidu</td>
        <td>27</td>
    </tr>
    <tr>
        <td>tecent</td>
        <td>26</td>
    </tr>
</table>
```
* 其中border为表格边框的宽度，单位%pixels。  
* width属性可设定表格的宽度，单位%pixels。
* bgcolor属性可设定表格的背景颜色，值可为rgb(x,x,x)，#xxxxxx，colorname三种形式。推荐使用样式代替。 

<table>
    <tr>
        <td>baidu</td>
        <td>age</td>
    </tr>
    <tr>
        <td>tecnet</td>
        <td>27</td>
    </tr>
</table>

# 属性相关  
* 横跨两列的单元格  

```
<table border="1">
    <tr>
        <th>name</th>
        <th colspan="2">phone</th>
    </tr>
    <tr>
        <td>Baidu</td>
        <td>3666159</td>
    </td>
</table>
```

<table border="1">
    <tr>
        <th>name</th>
        <th colspan="2">phone</th>
    </tr>
    <tr>
        <td>Baidu</td>
        <td>3666158</td>
        <td>3666159</td>
    </td>
</table>

* 横跨两行的单元格  

```
<table border="1">  
    <tr>
        <th bgcolor="red">name</th>
        <td>Baidu</td>
    </tr>
    <tr>
        <th rowspan="2">phone</th>
        <td>366159</td>
    </tr>
    <tr>
        <td>366158</td>
    </tr>
<table>
```

<table border="1">  
    <tr>
        <th bgcolor="red">name</th>
        <td>Baidu</td>
    </tr>
    <tr>
        <th rowspan="2">phone</th>
        <td>366159</td>
    </tr>
    <tr>
        <td>366158</td>
    </tr>
<table>

