---
title: Golang中的map
date: 2016-06-07 10:28:58
tags: [Golang]
categories: [技术]
---
```
计算机科学中最有用的数据结构之一就是hash表。不同的hash表实现提供了很多多特的特效。但基本都包含对元素的增删改查。
```
Go语言中的hash表就是map。在创建一个map时，需要指名map键值的具体类型，其中键的类型KeyType必须是可比较的，比如可以是字符串，整形，甚至指针等，而值类型ValueType则可以是任意类型，也可以还是一个map。
One of the most useful data structures in computer science is the hash table. Many hash table implementations exist with varying properties, but in general they offer fast lookups, adds, and deletes. Go provides a built-in map type that implements a hash table.
var mp map[string]int
```
map是一个引用类型，类似指针或切片，如果只声明了一个map，此时它还是nil，并没有真正指向一个或者说绑定一个map。当写一个还没引用任何真实map实体时，会出panic。为了初始化一个map，可用make函数。
对于map而言，在使用过程中，初次赋值时某个key可以不存在，map会自动创建这个key然后赋值，在取值时如果某个key不存在则返回零值(对于不同类型，其零值各不相同)。
```
```
mp := make(map[KeyType]ValueType)  
mp := make(map[string]string)  
```
```
mp["name"] = "baidu"  //新创建一个键值对(create)
name := mp["name"]    //获取已存在的键值对(read)
mp["name"] = "tecent" //更新已存在的键值对(update)
delete(mp, "name")    //删除已存在的键值对(delete)
fmt.Printf(mp["name"]) //获取不存在的键值对，打印为空字符串  
```
* map的遍历  
map可使用range关键字遍历  
for key, value := range mp {
    fmt.Println("Key: ", key, "---->"  "Value: ", value)
}
```
m需要说明的是map的遍历顺序是随机的。
