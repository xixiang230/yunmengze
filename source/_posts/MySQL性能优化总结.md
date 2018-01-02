---
title: MySQL性能优化总结
date: 2018-01-01 08:45:35
tags: [MySQL]
---
# 为查询缓存而优化你的查询
开启MySQL服务器的查询缓存是提高性能最有效的方式之一。当有很多相同查询呗执行了多次时，这些查询结果会被放到一个缓存里，后续的相同查询就不用操作表而变成直接访问缓存结果了。

但问题是某些查询语句会让MySQL不使用缓存，这是我们要注意的。例：
```
// 查询缓存不开启
$r = mysql_query('SELECT username FROM tb WHERE sigdate >= CURDATE()');
// 开启查询缓存
$today = date("Y-m-d");
$r = mysql_query("SELECT username FROM tb WHERE sigdate >= '$today'");
```
上面两条SQL语句差别在于CURDATE()函数的使用，MySQL的查询缓存对这个函数不起作用，像NOW()、RAND()或是其它类似SQL函数都不会开启查询缓存，因为这些函数的返回值是不定的，是易变的，所以你需要用个变量来代替MySQL的函数，从而开启缓存。
