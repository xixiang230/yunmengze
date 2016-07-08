---
title: HTML5错误用法建议
date: 2016-06-18 12:50:40
tags: [HTML]
categories: [技术]  
---
# 不要使用section作为div的替代品  
人们在标签使用中最为常见的错误用法之一就是将HTML5的`<section>`和`<div>`等价。  
`<section>`不是样式容器，它表示的是内容中用来帮助构建文档概要的语义部分，应该包含一个头部，如果想找一个作用页面容器的元素，
直接把样式写在body元素上，如果仍然需要额外的样式容器，使用div。
```
<body>
    <header>
        <h1>Fisrt Header</h1>
    </header>
    <div role="main">
    </div>
    <aside role="complementart">
    </aside>
    <footer>
    </footer>
</body>
```
# 在需要的时候使用header和hgroup  
写不需要的标签是毫无意义的，然而header和hgroup常被无意义的滥用。
1. header元素表示的是一组介绍性或者导航性质的辅助文字，经常用作section的头部。  
2. 当头部有多成结构时，比如子头部，副标题，各种标识文字等，使用hgroup将h1-h6元素组合起来作为section的头部。  
## header滥用  
由于header可以在一个文档中使用多次，很可能就滥用header写出如下代码  
```
<article>
    <header>
        <h1>First Header</h1>
    </header>
<article>
```
如果header元素只包含一个头部元素，那么就丢弃header元素。既然article元素已经保证了头部会出现的文档概要中，而header又不能
包含多个元素，那为什么要写多余的代码呢。简单写可如下：  
```
<article>
    <h1>First Header</h1>
</article>
```
## `<hgroup>`的错误使用  
hgroup也经常被滥用，在一下情况下就不应该同时使用hgroup和header  
1. 如果只有一个子头部  
```
<header>
    <hgroup>
        <h1>First Header</h1>
    </hgroup>
    <p>Baidu</p>
</header>
```
上面代码可直接拿掉hgroup，让heading裸奔如下：  
```
<header>
    <h1>First Header</h1>
    <p>Baidu</p>
</header>
```
另一个不必要的例子  
2. 如果hgroup自己就能工作得很好  
```
<header>
    <hgroup>
        <h1>First Head</h1>
        <h2>Second Head</h2>
    </hgroup>
</header>
```
这里如果header中没有其他元素，唯一子元素就是hgroup，那就拿到header
```
<hgroup>
    <h1>First Head</h1>
    <h2>Second Head</h2>
</hgroup>
```
# 不要把所有的列表式的链接放在nav里  
nav元素表示页面中链接到其他页面或者本也其他部分的区块，包含导航连接的区块。  
不是所有页面上的链接都需要放到nav元素中，该元素本意是用作<font color="red">主要的导航区块</font>。比如在footer中我们经常看到众多链接，服务条款，主页，
版权声明等。这里footer元素自身足以应付这些情况，虽然nav元素也可用到这里，但不必要。  
关键词"主要的"可从一下几个角度考虑：
* 主要的导航  
* 站内搜索  
* 二级导航  
* 页面内的导航
而一下集中情形则可以不放在`<nav>`里  
* 分页控制  
* 社交链接  
* 博客文章的标签  
* 博客文章的分类  
* 三级导航  
* 过长的footer  
如果不确定是否需要将一系列的链接放在nav里，可反问自己"这是主要的导航么"？比如如果使用section和hx也同样适合，那么不要用nav。

# figure元素
figure和figcaption的正确使用比较难以驾驭，错误使用主要表现在如下几个方面:  
* 不是所有的图片都是figure。
任何编码都坚持：不要写不必要的代码。同样的道理，现实中很多网站把所有的图片都写作figure，这是不对的，规范中对figure的描述是：
一些流动的内容，有时候会有包含于自身的标题说明，一般在文档流中会作为独立的单元引用。这正是figure的美妙之处，它可以从主
内容页移动到sidebar中，而不影响文档流。  

如果纯粹只是为了呈现的图，也不需要在其他地方引用，就无需`<figure>`出场，在考虑时，可以反问自己"这个图片是否必须和上下文
有关?"，如果不是，那可能不是`<figure>`，也许是个`<aside>`，然后继续"可以把它移动到附录中吗?"，如果这两个条件都符合，请出
`<figure>`。举例来说logo也使用于`figure`：
```
<!-- 错误使用案例一  -->
<header>
    <h1>
        <figure>
            <img src="/img/logo.png alt="company" />
        </figure>
        My company name
    </h1>
</header>
```
figure只应该被引用在文档中，或者被section元素围绕，在这里勿使用figure。  
```
<!-- 错误使用案例二 -->
<header>
    <figure>
        <img src="/img/logo.pn" alt="company" />
    </figure>
</header>
```
另外，figure不仅仅局限于图片，还可以是视频，音频，图表，一段文档，表格，一段代码，一段散文，以及任何他们或者其他组合。
# 不要使用不必要的type属性。  
最佳实践应该避免不必要的type属性。在HTML5中，script和link元素不再需要type属性，所有浏览器都认为脚本是javascript而样式是
css样式，没必要多此一举了。
```
<link rel="stylesheet" href="css/styles.css" />
<script src="js/scripts"></script>
```
# form属性的错误使用  
HTML5引入了一些form的新属性，一下是一些使用上的注意事项:  
## 布尔属性
有一些新的form属性是布尔型属性，这意味着它们只要出现在标签中，就保证了相应的行为已经设置，这些属性有如下：  
* autofocus
* autocomplete
* required
这些属性，比如浏览器的HTML解析器只要看到required属性出现在标签中，它的功能就会被应用。一下为布尔属性的三种有效使用方式。  
* required  
* required=""
* required="required"
其中后两种只在xhtml中有效，html一般采用如何形式：  
```
input type="email" name="emial" required />
```


