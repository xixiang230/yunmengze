---
title: markdown基本语法
date: 2016-05-15 16:10:40
tags: [markdown]
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

1.通过在文字下方添加"=" ，表示一级标题。  
2.通过在文字下方添加"-" ，表示二级标题。  
3.通过在文字开头加上"#" ，"#"的个数表示几级标题。  
一共有1~6级标题，1级标题字体最大。  

# 字体  
---  
1.斜体  
将需要设置为斜体的文字两端使用一个 "*" 或者一个 "_" 夹起来。  
2.粗体  
将需要设置为粗体的文字两段使用两个 "\*" 或者两个 "\_"加起来。  

# 列表  
---  
1. 无序列表  
在文字的开头添加（+，-，*）实现无序列表。注意（+，-，\*）和文字间需要添加空格，并建议一个文档中只使用一种无序列表表示方法。  

2. 有序列表  
使用数字后面跟上英文点号和空格    

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
