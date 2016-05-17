---
title: ZooKeeper常用命令和工具
date: 2016-05-17 07:35:32
tags: [ZooKeeper]  
categories: [技术]
---
# 常用四字命令    
  ZooKeeper 支持某些特定的四字命令字母与其的交互，大多是查询命令，用来获取 ZooKeeper 服务的当前状态及相关信息。用户可在客户端可以通过 telnet 或 nc 向 ZooKeeper 提交相应的命令。常用四字命令如下表：  
<!-- more -->  
|四字命令|功能|  
|-------|----|  
|conf|输出相关服务配置详细信息|  
|cons|列出所有连接到服务器的客户端的完全的连接/会话的详细信息。包括“接受 / 发送”的包数量、会话 id 、操作延迟、最后的操作执行等等信息|
|dump|列出未经处理的会话和临时节点|
|envi|输出关于服务环境的详细信息（区别于 conf 命令）|
|reqs|列出未经处理的请求|  
|ruok|测试服务是否处于正确状态。如果确实如此，那么服务返回“imok ”，否则不做任何相应|  
|stat|输出关于性能和连接的客户端的列表|  
|wchs|列出服务器 watch 的详细信息|  
|wchc|通过 session 列出服务器 watch 的详细信息，它的输出是一个与watch 相关的会话的列表|  
|wchp|通过路径列出服务器 watch 的详细信息。它输出一个与 session相关的路径|  

示例：  
* 测试服务器是否处于正确状态，是否已经启动了该Server，回复imok表示已经启动    
`echo ruok | nc localhost 9700`  
* 输出服务器配置详情  
`echo conf | nc localhost 9700`  
* 测试服务器服务器状态，查看该节点是follower还是leader等    
`echo stat | nc localhost 9700`  
* 列出未经处理的会话和临时节点  
`echo dump | nc localhost 9700`  
* 关掉server  
`echo kill | nc localhost 9700`  

# 服务命令  
1. 启动zk服务  
`bin/zkServer.sh start`  
2. 查看zk服务状态  
`bin/zkServer.sh status`  
3. 停止zk服务  
`bin/zkServer.sh stop`  
4. 重启zk服务  
`bin/zkServer.sh restart`  
5. 启用ZooKeeper客户端连接到服务器  
`zkCli.sh -server localhost:9700` 

# 客户端命令     
1. 使用ls命令查看ZooKeeper目录树内容  
`ls /`  
2. 使用ls2命令查看当前节点内容以及更新次数等更多信息  
`ls2 /`  
3. 创建新的znode  
`create /liuzekun Hello`   #创建一个新的znode节点，路径为/Liuzekun，并关联到字符串数据Hello，注意这里内容无需引号包围  
4. 使用get命令获取znode节点中关联的数据内容  
`get /liuzekun` 
5. 使用set命令重置znode节点中关联的数据内容  
`set /liuzekun World`  
6. 使用delete命令删除znode节点  
`delete /liuzekun`  
7. 退出客户端  
`quit`  
8. 帮助命令  
`help`  