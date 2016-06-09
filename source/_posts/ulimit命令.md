---
title: ulimit命令
date: 2016-06-06 22:00:45
tags: [shell]
categories: [技术, Linux]
---
# 作用  
用于查看和设置用户进程资源使用限制，是一个内建命令

# 语法  
ulimit [-acdfHlmnpsStvw] [size]
# 参数
* -H 设置硬件资源限制  
* -S 设置软件资源限制  
* -a 显示当前所有的资源限制
* -c size 设置core文件的最大值，单位:blocks
* -n size 设置内核可以同时打开的文件描述符的最大值
* -u 用户最多可开启的程序数目  
......
Linux在运行时，能打开的文件句柄数量是有限制的，默认为1024。这些打开的文件描述符也包含SOCKET的熟练，该上限可用ulimit内建命令
修改，且仅对当前登录账户目前的使用环境有效。
# 实用举例  
```
ulimit -a    #显示用户当前的各种进程资源限制
ulimit -u 10240   #将用户的最大进程数设置为10240个  
ulimit -n 4096    #将每个进程可以打开的文件数据设置为4096，默认为1024
ulimit -c    #查看core文件的生成开关是否关闭，为0表示关闭  
ulimit -c    #关闭core文件的生成  
ulimit -c 1000    #设置core文件大小最大为1000k
ulimit -c unlimited    #把core文件大小设置为无限大，默认情况下，core文件的大小被设置为0
```
