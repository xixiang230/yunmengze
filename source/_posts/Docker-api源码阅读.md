---
title: Docker api源码阅读
date: 2017-09-12 13:45:15
tags: [Docker]
---
# Engine API
Engine API主要用于负责client端命令行与daemon之间的通信，也适用于第三方软件控制daemon。主要包含如下部分：
1. api/swagger.yam: Swagger定义的API
2. api/types: client和server共有的types，包含各种对象、选项、响应等。大部分为人工编写，部分为Swagger定义。 
3. cli: client命令行
4. client: client命令行使用的Go client，可被第三方Go程序使用。
5. daemon: API的server
