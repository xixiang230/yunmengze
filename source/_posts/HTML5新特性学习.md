---
title: HTML5新特性学习
date: 2016-06-18 08:47:08
tags: [HTML]
categories: [技术]
---
HTML5的涉及准则之一就是化繁为简，极大地简化代码编写，一下这些新特性很多也是围绕这个目标实现。  
# 文档类型声明    
在HTML5中文档类型的声明方式是  
```
<!DOCTYPE html>
```
在HTML4中的DOCTYPE代码就长了，长的懒得展现了。而在HTML5中干净利索的解决了这个问题。    
# 字符集声明
同样在HTML4中字符集的声明也是一大坨，现在只要这样:  
```
<meta charset="utf-8">
```
# 链接和脚本
在HTML5中，无需再指定类型属性(no more types for scripts and links)  
```
<link ref="stylesheet" href="path/tp/stylesheet.css">
<script src="path/to/script.js"></script>
```
在HTML4和XHTML中链接和脚本都是要指名type属性的(分别是type="text/css"和type="text/javascript")。  
# 语义Header和Footer  
在HTML5中，可用`<header>`和`<footer>`元素实现使得代码更加简洁。  
```
<header>
...
</header>
<footer>
...
</footer>
```
而在HTML4和XHTML中，是借助`<div id="header">`和`<div id="footer">`来实现的。
# hgroup
hgroup为HTML5新引入元素之一，假设网站下面紧跟着一个子标题，一般可用`<h1>`和`<h2>`标签来定义，缺点是这并没有
说明二者之间的联系，且h2标签可能还会带来问题，比如在该页面上还有其他标题时。在HTML5中可用hgroup元素将他们分组。
```
<header>
<hgroup>
    <h1>First Header</h1>
    <h2>Second Header</h2>
</hgroup>
</header>
```
# 标记元素  
标记元素`<makr>`可视之为高亮标签，该标签修饰的字符串应该和用户当前行为相关，用`<mark>`元素包围的字符串会
高亮显示。搜索关键词时，就可用用到该技术，将匹配到的字符用`<mark>`元素修饰。  
```
<p>Hello <mark>"Baidu"</mark>"</p>
```

# 图形元素  
HTML5中引入了`<figure>`元素，并可与`<figcaption>`元素结合，语义化地将注释和相应的图片联系。  
```
<figure>
<img src="path/to/image" alt="About image" />
<figcaption>
    <p>This is an image </p>
</figcaption>
</figure>
```
# `<small>`重定义  
在HTML5中，`<small>`可用来定义小字体，比如应用于网站底部的版权状态。  

# 占位符placeholder属性  
占位符可用于提前设置一些信息，当用户开始输入时，文本框文字就会消失。在HTML5中引入了placeholder属性很好的解决了这个问题。    
```
<input id="search" type="text" placeholder="预案名" name="searchterm">
```
# "必要"属性  
HTML5中引入了说明"必要"性的属性required，用于指名某一输入是否必须。  
```
<input type="text" required>
<input type="text" required="required">
```
当文本框被指定了必要属性后，如果空白的话表格就不能提交。例:  
```
<form method="post" action="">
<lablel for="some-input">You Name: </label>
<input type="text" placeholder="Jim" required>
<button type="submit">OK</button>
</form>
```
如果输入内容为空，在提交表格时，输入框将被高亮显示。  
# autofocus属性
如果一定特定的输入应该是"选择"或聚焦，默认情况下，可以利用自动聚焦属性。  
```
<input type="text" placeholder="jim" required autofocus>
```
# Audio支持
在HTML5中，引入了`<audio>`元素
```
<audio autoplay="autoplay" constols="controls">
    <source src="file.ogg" />
    <source src="file.mp3" />
    <a href="file.mp3">Download this file</a>
</audio>
```
# Video支持
HTML5支持`<audio>`，和`<audio>`类似，HTML5也没有指定视频解码器，留给浏览器来决定。  
```
<vido controls preload>
<source src="cohagenPhoneCall.ogv" type="video/ogg; codecs='vorbis, theora'" />
<source src="cohagenPhoneCall.mp4" type="video/mp4; 'codecs='avc1.42E01E, mp4a.40.2'" />
<p> Your browser is old. <a href="cohagenPhoneCall.mp4">Download this video instead.</a> </p>
</video>
```
# 视频预载(preload attribute in video element)  
当用户访问页面时，preload属性使得视频可以预载  
```
<video preload>
<video preload="preload">
```  
# 显示控制条(Display controls)  
为了渲染出播放控制条，必须在video元素内知道controls属性  
```
<video preload controls>
```
# 正则表达式  
在HTML4或XHTML中，需要用一些正则表达式来验证特定的文本，HTML5中引入了新的pattern属性，可在标签处直接插入一个正则表达式。  
```
<form action="" method="post">
<label for="username">Create a Username</label>
<input type="text", placeholder="4 <> 10" pattern="[A-Za-z]{4,10}" autofocus required>
<button type="submit">OK</button>
</form>
```
# 新的片段类元素
|元素名|说明|
|------|----|
|header|标记头部区域的内容，用于整个页面或页面中的一块区域|
|footer|标记脚部取悦的内容，用于整个页面或 页面中的一块区域|
|section|web页面中的一块区域|
|article|独立的文章内容|
|aside|相关内容或者引文|
|nav|导航类辅助内容|
