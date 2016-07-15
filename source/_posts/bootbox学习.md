---
title: bootbox学习
date: 2016-07-14 22:15:02
tags: [前端]
categories: [技术]
---
# 使用方法
## bootbox.alert
```
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
```
## bootbox.prompt
```
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

```

## bootbox.confirm
bootbox.confirm(message, callback)
bootbox .confirm("Are you sure?", function (result) {});
bootbox.confirm({
    size: 'small',
    message: 'Your message here...',
    callback: function(result) {/*your callback code*/}
})
bootbox.dialog(options)
```
# 选项  
以下选项以Javascript对象的方式传递，且某些选项只针对特定的bootbox框类型有效。
|Name|Type|Description|
|----|----|-----------|
|message(必选)|string或html element|对话框中显示的文本或html标记|
|title|string或html element|对话框标题，将置于`<h4>`元素中|
|locale|string|该选项用于button上的标记(OK，CONFIRM，CANCEL，Default等)的表示语言，默认取值en，当前支持zh_CN zh_TW en等|
|callback|Function|除alert外其他形式的对话框必选，且alert的callback不支持传递参数，confirm和prompt的calllback则必须支持一个参数，用于接收对话框上的result，对于confirm是一个true或false值，对于prompt则是用户输入的值。
|buttons(有默认值)|Object|形如: buttonName: {label: 'Label Text', callback:
function () {}
}。alert默认值为"ok"，confirm和prompt默认值是："cancel"和"confirm"|
|size|string|可取的值有'large'和'small'，默认为null|
|className|string|对话框的class|
|animate|boolean|对话框进入和退出动态，默认值为true|
|closeButton|boolean|是否需要close button，默认值为true|

