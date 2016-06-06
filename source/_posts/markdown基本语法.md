---
title: markdown基本语法
date: 2016-05-15 16:10:40
tags: [markdown]
categories: [技术, 工具]
---
# 基本符号  
---  
* 3个Markdown符号：*，-，+  
* 空白行表示另起一个段落  
* `表示inline代码，对应html的code标签  
* tab用来标记代码段，对应html的pre标签
<!--more -->  
# 换行  
---  
* 单一段落用一个空白行表示，相当于（\<p>） 
* 连续两个空格相当于\<br>  
* 连续3个符号（*，+，-）表示\<hr>横线  

# 标题设置  
---  
## 方法一: 类Setext形式  
* 通过在文字下方添加一个或多个"=" ，表示一级标题。  
* 通过在文字下方添加一个或多个"-" ，表示二级标题。  

```
This is an H1  
============
This is an H2
------------
```

## 方法二: 类Atx形式
* 通过在文字开头加上"#" ，"#"的个数表示几级标题。一共有1~6级标题，1级标题字体最大。  

```
# H1
## H2
### H3
......
```
其中，我们还可以选择性地选择对类Atx形式的标题进行闭合，即在行尾加上任意个数#。这里数量上不做要求。
```
# H1 #
## H2 ##
### H3 ###
```

# 字体  
---  
1.斜体  
将需要设置为斜体的文字两端使用一个 "*" 或者一个 "_" 夹起来。  
2.粗体  
将需要设置为粗体的文字两段使用两个 "\*" 或者两个 "\_"加起来。  

# 列表  
---  
1. 无序列表(加、减、乘符号)  
在文字的开头添加（+，-，*）实现无序列表。注意（+，-，\*）和文字间需要添加空格，并建议一个文档中只使用一种无序列表表示方法。  
```
* Baidu  
* Tecent  
* Alibaba  
```

2. 有序列表  
使用数字后面跟上英文点号和空格，这里的数字与实际输出的标记并不关联，只是一个书写形式上的记号。      
```
1. Baidu  
2. Tecent  
3. Alibaba
```
上述代码等效与产生如下HTML标记：
```
<ol>  
<li>Baidu</li>  
<li>Tecent</li>
<li>Alibaba</li>
</ol>
```
如果列表项目间有用空行分开，则在输出HTML时，会将项目内容用<p>标签包起来，例:  
```
* Baidu  

* Tecent
```
将转换为:
```
<ul>
<li><p>Baidu</p></li>  
<li><p>Tecent</p></li>
</ul>
```
# 代码块  
HTML中用`<pre>`和`<code>`标签来包围代码块。在Markdown中，简单缩进4个空格或1个制表符即可。例:
```
普通段落:
    代码区块。
```

以上代码Markdown会转换成:  
```
<p>普通段落:</p>
<pre><code>代码区块</code></pre>
```
在此转换过程中，每行一阶的缩进都会被移除。
  
# 链接  
--- 
1.内联方式  
This is an [baidu link]\(http://baidu.com)， 表现如下：  
This is an [baidu link](http://baidu.com)  

2. 引用方式  
I get 10 times more traffic from [Google]\[1] than from [Yahoo]\[2]  
I get 10 times more traffic from [Google][1] than from [Yahoo][2] or [Baidu][3]  
[1]: http://google.com/ "Google"  
[2]: http://search.yahoo.com/ "Yahoo"  
[3]: http://www.baidu.com/ "Baidu"
    \[1]: http://google.com/ "Google"  
    \[2]: http://search.yahoo.com/ "Yahoo"   
    \[3]: http://www.baidu.com/ "Baidu"  

# 图片  
---  
图片的处理方式和链接非常类似  
1. 内联方式  
\![alt text]\(/path/to/img.jpg "Title")  
![alt text](/path/to/img.jpg "Title")  
2.引用方式  
\![alt text]\[id]  
\[id]: /path/to/img.jpg "Title"  
![alt text][id]  
[id]: /path/to/img.jpg "Title"  

# 代码  
---  
1. 简单文字出现一个代码框  
使用  \`\<blockquote>\`  效果如下：  
`<Hello World>`  
2. 大片段实现代码框  
使用Tab或四个空格，效果如下：  
    abc  
    def  
    ghi  
    jhi  
    
# 脚注  
---  
实现方式如下:  
    hello[^hello]  
    [^hello]: hi  
效果如下:  
hello[^hello]  
[^hello]: hi  

# 横线    
在空白行下方添加三条 "-" 横线  

# 段落和换行  
一个Markdown段落由<font color="red">一个或多个连续的文本行</font>组成，段落前后都要有一个以上的空行。
# 区块引用  
在每行/或整个段落的第一行最前面加上">"符号
```
> Baidu  
> Tecent  
```
区块引用还可以嵌套，即引用内的引用，根据层次加上不同数量的">"，而且引用的区域内也可以使用其他Markdown语法，比如标题，列表，代码区块等:  
``` 
>  ##标题  
>    
> 1. 第一行列表  
> 2. 第二行列表  
>  
```
>  ##标题  
>    
> 1. 第一行列表  
> 2. 第二行列表  
>  
