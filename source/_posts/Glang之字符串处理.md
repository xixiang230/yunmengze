---
title: Golang之字符串处理
date: 2016-06-06 22:37:44
tags: [Golang]  
categories: [技术, 后端]
---
# 初始化
```
var strName string  //声明一个字符串，只是声明了
strName = "baidu"   //赋值  
ch := strName[0]    //获取第一个字符  
intLen := len(strName) //获取字符串长度
```
这里len是一个内置函数，无需引入额外的包，len内置函数的声明式如下:  
```
func len(v type) int
```  
* len(string)    #返回字符串的<font color="red">字节数</font>。
* len(Array)     #返回数组的元素个数  
* len(*Array)    #返回数组的指针中的元素个数，如果为nil返回0
* len(Slice)     #返回数组切片中元素个数，如果为nil返回0  
* len(map)       #返回字典中的元素个数，如果为nil返回0  
* len(Channel)   #返回Channel buffer队列中的元素个数  
# 字符串操作  
* 获取Golang字符串中的中文字符，首先，纯粹通过str[index]形式获取的字符实质上只是一个byte。为了完整获取一耳光中文字符，需要将
string形式的字符串转换成rune数组，在rune数组中就可以通过数组下标获取一个汉字所对应的Unicode码了。例:  
```
strName := "百度" 
for i := 0; i < len(strName); i++ {
    fmt.Println(strName[i])
}
runeName := []rune(strName) 
for i := 0; i < len(runeName); i++ {
    fmt.Println(runeName[i])
}
```
* 子字符串包含问题
子字符串包含问题可用strings包中的Contains函数判断，其声明和实现如下: 
```
func Contains(s, substr string) bool {
    retrun Index(s, substr) != -1
}
#ignoreCase表示是否忽略大小写，为true表示忽略
func Contains(s string, substr string, ignoreCase bool) bool {
    return Index(s, substr, ignoreCase) != -1
}
```
需要注意的是，Contains基于Index(s, sub string) int 实现，如果Index返回值不为-1，则表明包含子字符串，而空字符""在任何字符串中均存在。在使用Contains函数时，需引入包名import "strings"。
在不区分大小的场景中，还可以如下处理：
```
strings.Contains(string.ToLower(s), strings.ToLower(substr))
```  
下面看下Index的实现:
```
func Index(s string, sep string, ignoreCase bool) int {
    n := len(sep)
    if n == 0 {
        return 0    //所以当子字符串长度为0，返回值为0，不等于-1，表示包含
    }
    if ignoreCase == true {
        s = strings.ToLower(s)
        sep = strings.ToLower(sep)   //当标记ignoreCase为true时，表示不忽略大小写
    }
    c := sep[0]
    if n == 1 {        //子字符串长度为1，特殊处理，加速返回
        for i :=0; i < len(s); i++ {
            if s[i] = c {
                return i
            }
        }
        return -1
    }
    for i := 0; i + n <= len(s); i++ {    
        if s[i] ==c && s[i:i+n] == sep {   //描点然后再切片比较
            return i
        }
    }
    return -1
}
```
* 获取子字符串出现的次数
```
Count(s, sep string)
```
注意: 如果子字符串sep=""为一个空字符串，此时，则无论s是何字符串都会返回len(s) + 1

* 使用空格分割字符串，返回分割后的数组  
```
Fields(s string)
```
```
fmt.Println(strings.Fields("baidu tecent alibaba"))  //[baidu tecent alibaba]  
fmt.Println(strings.Fields("  baidu  "))             //[baidu]
fmt.Println(strings.Fields(""))                      //[]
fmt.Println(strings.Fields(" \n baidu"))             //[baidu]
```
* 检查字符串是否以某字符串开头
```
HasPrefix(s, prefix string) bool
```
