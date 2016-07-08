---
title: jQuery之添加HTML元素
date: 2016-06-10 11:21:41
tags: [jQuery]
---
# jQuery添加HTML元素方法汇总  
Adding content at the end of an element (or elements)
* append()  //在指定的元素内的尾部添加一个新内容。  
<!-- more -->
```
//Append a DOM element object 
var newPara = document.createElement('p');
var newParaText = doucument.createTextNode("hello word");
newPara.appendChild(nexParText);
$('#myDiv').append(newPara);

//Append a string of HTML  
$('#myDiv').append("<p>hello world</p>");  

//Append a jQuery object  
$('#myDiv').append($("<p>hello world</p>"));  

//Append the output from a callback function  
$('#myDiv').append(sayHello);

function sayHello() {
    return "<p>hello world</p>";
}

//appendTo()  
$("<p>hello world</p>").appendTo('#myDiv');  
```
* appendTo()  

Adding content at the start of an element (or elements). 换句话说，该方法把新增元素作为被选元素的第一个孩子。  
* prepend() //在指定的元素内的前部添加一个新内容。其参数可以是:  
1. 由JavaScript DOM 函数比如doucument.getElementById()或者document.createElement()等获取或创建的元素对象。  
```
var newPara = document.createElement('p');
var newParaText = document.createTextNode('hello world');
newPara.appendChild(newParaText);
$('#myDiv').prepend(newPara);  
```
2. 需要添加内容的HTML字符串。  
```
$('#myDiv').prepend("<p>hello world</p>");  //效果同1
```
3. jQuery对象。
```
var newPara = $("<p>hello world</p>");  //可以非常便捷地通过传递一个HTML字符串给jQuery函数$来创建一个HTML元素。  
$('#myDiv').prepend(newPara);
```
4. prepend()回调函数function(index, html)。  
prepend的回调函数必须返回一个欲新增元素内容的HTML字符串，用于追加到匹配元素里。该回调需要接受2个参数：
a) 当前元素的元素集合中的索引位置。  
b) 当前元素过去的HTML内容。  
```
function addHeadingNumber(index, oldMarkup) {
    return ((index) + '.');
}
function init() {
    return ('.myDiv>h1').prepend(addHeadingNumber);
}
```
5. 多元素上调用prepend()  
此时，jQuery在每一个指定元素里最开始处插入新的内容。
* prependTo()  
6. prepend() 和prependTo()  
prepend()和prependTo()完成的工作一样，只是语法表达上的差异。prepend()可理解为在jQuery对象上调用插入指定内容。prependTo()则可理解为将插入内容绑定到指定jQuert对象上。  
```
$('#myDiv').prepend("<p>hello world</p>");      //等效于如下: 
$("<p>hello world</p>").prependTo('#myDiv');  
```
prependTo()的参数可以是: 
a) 选择器  
b) jQuery对象  
```
var existingContent = $("<div><p>Existing text</p></div>"); //创建了一个新的jQuery对象
var newContent = $("<p>hello world</p>");   //创建另一个新的jQuery对象  
newContent.prependTo(existingContent); //在newContent对象上调用prependTo()，将自己绑定到existingContent内容的最开始处。   
existingContent.prependTo('#myDiv');  //在existingContent对象上调用prependTo()，将自己绑定到选择器选中的#myDiv内容的最开始处。  
```
输出如下:  
<div id="myDiv">
    <div>
        <p>hello world</p>
        <p>Existing text</p>
    </div>
</div>
```
如果传递给prependTo()的参数有多个元素，则每个元素的开头都将插入新的内容。  
$("p").append(txt1, txt2, txt3);
```
Adding content after an element (or elements).
* after()   //在指定元素的前面添加新内容。
* insertAfter()  
```
// Insert a DOM element object
  var newPara = document.createElement( 'p' );
  var newParaText = document.createTextNode( "Here's a DOM element" );
  newPara.appendChild( newParaText );
  $('#myDiv').after( newPara );

  // Insert a string of HTML
  $('#myDiv').after( "<p>Here's a string of HTML</p>" );

  // Insert a jQuery object
  $('#myDiv').after( $("<p>Here's a jQuery object</p>") );

  // Insert the output from a callback function
  $('#myDiv').after( sayHello );

  function sayHello() {
    return "<p>Hello! This is the output from a callback function</p>";
  }

  // Append some content using insertAfter()
  $("<p>Here's some content inserted using insertAfter()</p>").insertAfter('#myDiv');
}

```
Adding content before an element (or elements), directly before an element.
* before()  //在指定元素的后面添加新内容。  
* insertBefore()  
与append和prepend不同的是，before回调不接受元素索引或HTML。  
```
//Insert a DOM element object  
var newPara = document.createElement('p');  
var newParaText = document.createTextNode("Here's a DOM element");  
newPara.appendChild(newParaText);  
$('#myDiv').before(newPara);  

//Insert a string of HTML  
$('#myDiv').before('<p>Here's a string of HTML</p>");  

//Insert a jQuery object  
$('#myDiv').before($("<p>Here's a jQuery object</p>"));  

//Insert the output from a callback function  
$('#myDiv').before(sayHello);  
function sayHello() {
    retrun "<p>Hello! This is the output from a callback function</p>";
}
```
输出: 
```
...
<p> hello world</p>
<p>Here's a string of HTML</p>
<p>Here's a jQuery object</p>
<p>Hello! This is the output from a callback function</p>
<div id="myDiv">
...
```
insertBefore()对应于before类似于prependTo()对应于prepend()。   
```
var existingContent = $("<div><p>Existing text</p></div>");
var newContent = $("<p>Here's some new text</p>");
newContent.insertBefore( existingContent );
existingContent.insertBefore( '#myDiv' );
```

after()和before()也支持同时插入多个元素。  
```
$("img").after(txt1, txt2, txt3);
```
* appendTo 与append区别   
append()和appendTo()完成的功能一样，都是添加一个新文本或HTML内容，其主要区别在于语法上的不同:  
1. $('selector').append('content')  
```
$('.box').append("<div class='newbox'>I'm new box by prepend</div>");
```
2. $('content').appendTo('selector');  
```
$("<div class='newbox'>I'm new box by appendTo</div>").appendTo('.box');  
```
同理，prepend()和prependTo()。
Wrapping content around an element (or elements), or aroun an element's contents.
* wrap()  
wraps an HTML structure around an existing element or elements. If wrapping around multiple elements, the structure is wrapped around each element in the set.
wrap()的语法类似before()和after()。可以传递给他DOM对象，HTML字符串，jQuery对象或者一个返回HTML结构的回调函数。
```
// Wrap a DOM element object around #myDiv
  var newDiv = document.createElement( 'div' );
  newDiv.id = "newDiv1";
  $('#myDiv').wrap( newDiv );

  // Wrap a string of HTML around #myDiv
  $('#myDiv').wrap( '<div id="newDiv2" />' );

  // Wrap a jQuery object around #myDiv
  $('#myDiv').wrap( $('<div id="newDiv3" />') );

  // Wrap the output from a callback function around #myDiv
  $('#myDiv').wrap( generateDiv );

  function generateDiv() {
    return '<div id="newDiv4" />';
  }

  // Wrap a nested HTML structure around #myDiv
  $('#myDiv').wrap( '<div id="outer"><div id="inner"></div></div>' );

}
```
输出:  
```
<div id="newDiv1">
   <div id="newDiv2">
     <div id="newDiv3">
       <div id="newDiv4">
         <div id="outer">
           <div id="inner">
             <div id="myDiv">
               <p>Existing paragraph</p>
             </div>
           </div>
         </div>
       </div> 
     </div>
   </div>
 </div>
```
每一个新的div都被增加在上次最后新增的div里边，因为每次都是在#myDiv上调用wrap()。  
* wrapAll()  
is similar to wrap(). However, if wrapping around multiple elements, the structure is wrapped around the whole set, rather than around individual elements.
与wrap()用法类似，区别主要在于如下两点:  
1. If you call wrapAll() on a set of multiple elements then the HTML structure is wrapped once around the entire set, rather than around each element.
2. You can't use a callback function with wrapAll().  
```
// Wrap a div around #myDiv1 and another div around #myDiv2
  $('.type1').wrap( '<div class="newDiv1" />' );

  // Wrap a single div around #myDiv3 and #myDiv4
  $('.type2').wrapAll( '<div class="newDiv2" />' );
```
```
<div class="newDiv1">
    <div id="myDiv1" class="type1">
      <p>Existing paragraph</p>
    </div>
  </div>
  <div class="newDiv1">
    <div id="myDiv2" class="type1">
      <p>Existing paragraph</p>
    </div>
  </div>

  <div class="newDiv2">  
    <div id="myDiv3" class="type2">
      <p>Existing paragraph</p>
    </div>
    <div id="myDiv4" class="type2">
      <p>Existing paragraph</p>
    </div>
  </div>
```
可以看到，"type1"的div(#myDiv1和#myDiv2)各自拥有新的div包围，而对于"type2"的div(#myDiv3和#myDiv4)则成为一个整体被新的div包围。  
* wrapInner()  
wraps an HTML structure around the contents of an element or elements.
wrapInner()和wrap()类似，用于在每个匹配元素的所有子节点(包括文本节点，注释节点等任意节点类型)外部包裹指定的HTML结构，
区别：wrap()新增的内容包围在给定元素外面(around)，而wrapInner()则将新增的内容包围住被选元素自己的内容。  
wrapInner()的参数可以是string，element，jQuery，Function类型，用来包裹匹配元素的节点。如果参数为字符串，则视为jQuery选择器
或html字符串，具体jQuery会自行判断。参数为函数时，wrapInner()会根据匹配的所有元素上遍历执行该函数，函数中的this指向
对应当前遍历到的DOM元素，另外wrapInner还会为函数传入一个当前遍历元素在匹配元素中的索引，函数的返回值应该是用于包裹节点
的内容，可以是html字符串，选择器，DOM元素或jQuery对象等。

注:
1. 如果选择器参数匹配多个元素，则只将第一个元素作为包裹元素。  
2. 如果参数是多层嵌套的元素(比如：`"<p><i></i></p>"`)，则wrapInner()将从外往内检查每层嵌套的第一个节点。如果该节点没有
子节点或者第一个子节点不是Element节点(比如文本节点，注释节点等)，就停止向内查找，直接在当前节点内部的末尾追加(append())当前匹配元素。
3. 即使参数是当前页面中的元素，wrpaInner()使用的是该元素的副本来包裹目标元素。  
返回值:  
wrapInner()的返回值为jQuery类型，返回当前jQuery对象本身（以便进行链式风格的编程）
```
// Wrap a div around #myDiv1
  $('#myDiv1').wrap( '<div id="newDiv1" />' );

  // Wrap a div around the contents of #myDiv2
  $('#myDiv2').wrapInner( '<div id="newDiv2" />' );
```
输出:  
```
<div id="newDiv1">
    <div id="myDiv1">
      <p>Existing paragraph</p>
    </div>
</div>

<div id="myDiv2">
  <div id="newDiv2">
    <p>Existing paragraph</p>
  </div>
</div>
```
在比如： 
```
<p> para 1 <span></span></p>
<p> para 2 <span></span></p>
<script>
$("p").wrapInner('<em></em>');
</script>
<!-- 执行后html内容 -->
<p><em> para 1 <span></span></em></p>
<p><em> para 2 <span></span></em></p>
```
```
<p>
    <span>foo</span>
</p>
<p>
    <label>baidu</label>
    <span>tecent</span>
</p>
<script>
    $("p").wrapInner('<strong></strong>');
</script>
```
这里p元素的所有子节点外部都hi包裹stong元素。wrapperInner()将在每个p元素的开始标记之后，结束标记之前
分别插入包裹元素的开始标记和结束标记，甚至都不添加额外的空白字符。输入如下内容:
```
<p><strong>
    <span>foo</span>
</strong></p>
<p><strong>
    <label>baidu</label>
    <span>bar</span>
</strong></p>
```
可见，调用wrap()是将内容around the outside of #myDiv1，而当调用#wrapInner()则是将新增内容around the inside contents of #myDiv2。
* html()  
* text()  

# 总结  
prepend() and prependTo() to add content as the first child of an element (or elements)  
append() and appendTo() to add content as the last child of an element (or elements)  
before() and insertBefore() to add content before an element (or elements)  
after() and insertAfter() to add content after an element (or elements)  
wrap(), wrapAll() and wrapInner() to wrap content around an element (or elements), or around an element's contents  
