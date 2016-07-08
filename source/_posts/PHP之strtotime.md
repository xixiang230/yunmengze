---
title: PHP之strtotime
date: 2016-06-13 23:18:34
tags: [PHP]  
categories: [技术]  
---
# 用途 
strtotime用于将英文文本的日期时间描述解析为unix时间戳。  
```
strtotim(time, now); // 成功返回时间戳，失败返回FALSE
```
其中time规定要解析的时间字符串。time字符串参数是必须的，不能为空，否则返回false。  
now用来计算返回值的时间戳，默认使用系统当前时间，即相当于now参数给出的时间。  
time和now字符串参数都不区分大小写。  
1. 获取指定日期的unix时间戳  
```
strtotime("2016-06-14");  //返回2016年06月14日0点0分0秒的时间戳  
```
2. 返回英文文本日期的时间戳  
```
strtotime("now");  
strtotime("+1 day");   //打印明天此时的时间戳，相对与此时系统时间(默认)加1天  
strtotime("+1 days");  //打印明天此时的时间戳，相对与此时系统时间(默认)加1天  
strtotime("-1 day");   //打印昨天此时的时间戳  
strtotime("+10 days");   //打印10天后此时的时间戳  
strtotime("3 October 2016");  
strtotime("+5 hours"));  
strtotime("+1 week");  
strtotime("+1 week 3 days 7 hours 5 seconds");  
strtotime("next Monday");  //下周周一
strtotime("last Sunday");  //上周周日
echo date("Y-m-d H:i:s", time());  
echo date("Y-m-d H:i:s", strtotime("+1 day"));  
echo date("Y-m-d H:i:s", strtotime("-1 day"));  
echo date("Y-m-d H:i:s", strtotime("+1 week"));  
echo date("Y-m-d H:i:s", strtotime("next Thursday"));  
```
2. first、second、third......等关键字  
为辅助性关键字，可与星期，天等组合使用  
```
echo date("Y-m-d H:i:s", strtotime("second sunday");  //计算当前时间后开始的第一二个星期天
```
3. previous和next关键字  
与星期、天等组合，表示指定时间的前一星期或前一天，下一个星期或者下一天。    
```
echo date("Y-m-d H:i:s", strtotime("Previous sunday", strtotime("2016-06-13");  
```
4. last关键字  
即可以作为上一个，也可以作为最后一个。  
```
echo date("Y-m-d H:i:s", strtotime("last sunday, strtotime("2016-06-13")));  
```
5. back和front关键字  
对一天中的小时向前或向后操作，back表示将时间设置为指定时间值后一小时的15分位置，front则表示将时间设置为指定小时值前一个小时
的45分位置。    
```
echo date("Y-m-d H:i:s", strtotime("back of 24", strtotime("2016-06-14")));  
echo date("Y-m-d H:i:s", strtotime("front of 24", strtotime("2016-06-14")));  
```
# strtotime("-1 month")求值问题
对于后一月比前一月天数多的情况下得到的结果可能不是你想要的结果，但如果前一月的今天存在的话会返回正常。不存在，会自动将日期计算到
下个月。    
# strtotime函数长用于时间大小比较  
1. 首先通过strtotime函数将指定时间转化为时间戳  
2. 通过转换后的时间戳值进行比较  
