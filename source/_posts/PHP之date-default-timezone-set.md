---
title: PHP之date_default_timezone_set
date: 2016-06-13 22:36:17
tags: [PHP]  
categories: [技术]  
---
# 用法  
sets the default timezone used by all date/time functions。  
```
bool date_default_timezone_set(timezone);  
bool date_default_timezone_set(string $timezone_identifier);  
```
其中timezone是必须的，取值可为"UTC"，"Europe/Paris"等。如果时区设置不合法，则会对每个日期时间函数的调用产生一条E_NOTICE级别的错误信息打印出来。    
```
date_default_timezone_set('Europe/Paris');  
date_default_timezone_set('America/New_York');  
date_default_timezone_set('Asia/Chongqing');  
date_default_timezone_set('Asia/Shanghai');  
date_default_timezone_set('Asia/Harbin');  
date_default_timezone_set('PRC'); //中国标准时间   
```
# 补充  
```
string date_default_timezone_get ( void );  
```
Gets the default timezone used by all date/time functions in a script
