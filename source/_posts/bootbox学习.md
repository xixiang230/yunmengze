---
title: bootbox学习
date: 2016-07-14 22:15:02
tags: [bootbox]
categories: [技术]
---
# 一、bootbox对话框介绍  
## bootbox.alert的使用
{% codeblock lang:js %}
bootbox.alert("Hello world !")
bootbox.alert(message, callback)
bootbox.alert("Your message here...", function () {/*your callback code */})  
bootbox.alert({
    size: 'small',
    message: 'Your message here..",
    callback: function() {/*your callback code */ }
})
bootbox.alert({
    message: "I'm alert!",
    callback: function () {}
})
{% endcodeblock %}
<!-- more -->

## bootbox.alert的Usage表  
|调用方式|显示方式|
|---------|---------|
|bootbox.alert(str message)|默认是'OK' button|
|bootbox.alert(str message, fn callback)|默认文本的button，在dismissal上调用callback|
|bootbox.alert(str message, str label)|可自定义button的文本|
|bootbox.alert(str message, str label, fn callback)|自定义button文本，且在dismissal上调用callback|


## bootbox.prompt的使用
prompt对话框提供一个用户输入元素input，键入escape对话框将会消失，点击cancel button回调函数将会被调用，如果用户点击cancels或dismissed对话框，且有回调函数，则将传给回调函数一个null值，否则将input元素中的文本传给回调函数。  
{% codeblock lang:js %}
bootbox.prompt(message, callback)
bootbox.prompt("Your message here...", function () {/*your callback code */})
bootbox.prompt({
    size: 'small'
    message: 'Your message here...',
    callback: function(result) {/*your callback code*/}
})
bootbox.prompt("What is your name?", function(result) {
    if (result === null) {  //默认值为null
        //prompt dismissed
    } else {
        //do something
    }
});
{% endcodeblock %}

## bootbox.prompt的Usage表  
|调用方式|显示方式|
|---------|---------|
|bootbox.prompt(str message)|具有默认的Cancel和OK button|
|bootbox.prompt(str message, fn callback)|callback invoked on dismissal|
|bootbox.prompt(str message, str cancel)|自定义cancel button的文本|
|bootbox.prompt(str message, str cancel, fn callback)|callback invoked on dismissal|
|bootbox.prompt(str message, str cancel, str confirm)|自定义cancel和confirm button的文本|
|bootbox.prompt(str message, str cancel, str confirm, fn callback)|加上回调|
|bootbox.prompt(str message, str cancel, str confrim, fn callback, str defaultValue|加上默认的prompt value|

## bootbox.confirm的使用
confirm对话框具有cancel和confirm button，键入escape关闭对话框，点击cancel
button将调用回调函数，如果有回调，当用户单击cancel或confirm
button时会相应地传递给回调false和true值。 
{% codeblock lang:js %}
bootbox.confirm(message, callback)
bootbox .confirm("Are you sure?", function (result) {});
bootbox.confirm({
    size: 'small',
    message: 'Your message here...',
    callback: function(result) {/*your callback code*/}
})
bootbox.dialog(options)
{% endcodeblock %}

## bootbox.confirm的Usage表  
|调用方式|显示方式|
|----------|-----------|
|bootbox.confirm(str message)|默认带'Cancel'和'OK'两个button|
|bootbox.confirm(str message, fn callback)|默认两个button，在dismissal上调用callback|
|bootbox.confirm(str message, str cancel|自定义cancel button的文本，confirm button 文本默认|
|bootbox.confirm(str message, str cancel, fn callback)|在dismissal上调用callback|
|bootbox.confirm(str message, str cancel, str confirm)|自定义cancel和confirm button的文本|
|bootbox.confirm(str message, str cancel, str confrim, fn callback)|在dismissal上调用callback|

## dialog Usage表
dialog是一个如你所愿可完全自定义对话框的方法。  

|调用方式|显示方式|  
|----------|----------|
|bootbox.dialog(str message)|一个没有任何button的简单对话框|  
|bootbox.dialog(str message, object handler)|Needs docs|  
|bootbox.dialog(str message, arrar handlers)|Needs docs|  
|bootbox.dialog(str message, arrar handlers, object options)|Needs docs|  

# 二、选项  
以下选项以Javascript对象的方式传递，且某些选项只针对特定的bootbox框类型有效。  

|Name|Type|Description|   
|----------|----------|
|message(必选)|string或html element|对话框中显示的文本或html标记|  
|title|string或html element|对话框标题，将置于`<h4>`元素中|  
|message(必选)|string或html element|对话框中显示的文本或html标记|  
|locale|string|该选项用于button上的标记(OK，CONFIRM，CANCEL，Default等)的表示语言，默认取值en，当前支持zh_CN zh_TW en等|  
|callback|Function|除alert外其他形式的对话框必选，且alert的callback不支持传递参数，confirm和prompt的calllback则必须支持一个参数，用于接收对话框上的result，对于confirm是一个true或false值，对于prompt则是用户输入的值。
|buttons(有默认值)|Object|形如: buttonName: {label: 'Label Text', callback: function () {} }。alert默认值为"ok"，confirm和prompt默认值是："cancel"和"confirm"|  
|size|string|可取的值有'large'和'small'，默认为null|   
|className|string|对话框的class|  
|animate|boolean|对话框进入和退出动态，默认值为true|   
|closeButton|boolean|是否需要close button，默认值为true|  

# 三、方法
|调用方式|作用|
|----------|---------|
|bootbox.hideAll()|隐藏所有当有处于active的bootbox对话框|
|bootbox.animate(boolean)|Indicate whether idalogs should animate in and out|
|bootbox.backdrop(string)|Set the dailog backdrop value|
|bootbox.classes(string)|给对话框加上自定义的类|
|bootbox.setIcons(object)|给OK Cancel Confirm等按钮增加icons|
|bootbox.setLocale(string)|给OK Cancel Confirm等按钮设置文本显示语言，可以是:en zh-CN等|
|bootbox.addLocale(object|自定义lacale|

详情参考[bootbox官网](http://bootboxjs.com/v3.x/documentation.html)
