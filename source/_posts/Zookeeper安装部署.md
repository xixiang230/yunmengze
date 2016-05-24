---
title: Zookeeper安装部署
date: 2016-05-16 23:39:42
tags: [zookeeper]
---
# 下载  
进入[ZooKeeper](http://zookeeper.apache.org/releases.html "Title")官网找到合适的版本镜像下载。  
`wget http://apache.mirrors.ionfish.org/zookeeper/zookeeper-3.5.1-alpha/zookeeper-3.5.1-alpha.tar.gz`  
<!-- more -->
# 配置单机ZooKeeper  
进入zookeeper目录下的conf目录，创建zoo.cfg，内容有如下：  
    
    tickTime=2000  #zookeeper中使用的基本时间单位，单位ms
    dataDir=/home/users/liuzekun/download/zookeeper/zookeeper_9700/data  #数据目录，可任意
    dataLogDir=/home/users/liuzekun/download/zookeeper/zookeeper_9700/data/log  #日志目录，可任意，若没有设置该参数，默认会使用dataDir相同的设置  
    clientPort=9700  #监听client连接的端口号  
    
至此，zookeeper单机模式就已经配置好了，执行如下命令启动server  
`bin/zkServer.sh start`  
server启动后，便可启动client连接server了  
`bin/zkCli.sh -server localhost:4180`  
查看启动是否正常  
`echo stat | nc zk_host_ip zk_client_port`  
`echo stat | nc 127.0.0.1 9700`  

# 配置伪集群  
    
    |--zookeeper
    |----zookeeper0
    |----zookeeper1
    |----zookeeper2
  
  在zoo.cfg配置文件后增加  
      
    server.0=:127.0.0.1:2016:2017  
    server.1=:127.0.0.1:3016:3017  
    server.2=:127.0.0.1:4016:4017  
  
  在zoo.cfg配置文件中增加  
     
    tickTime=2000  
    initLimit=5  
    syncLimit=2  
  其余和单机模式类似  
  
* initLimit: zookeeper集群中的包含多台server, 其中一台为leader, 集群中其余的server为follower. initLimit参数配置初始化连接时, follower和leader之间的最长心跳时间. 此时该参数设置为5, 说明时间限制为5倍tickTime, 即5*2000=10000ms=10s。tickTime为zookeeper中使用的基本时间单位，单位为ms。

* syncLimit: 该参数配置leader和follower之间发送消息, 请求和应答的最大时间长度. 此时该参数设置为2, 说明时间限制为2倍tickTime, 即4000ms。  

*server.X=A:B:C  
`server.id=server ip:comunicate port:select port`  

  在dataDir目录中新建myid文件，并写入该server的id，与配置中保持一致。  
  启动各个server，启动客户端   
  
# 客户端连接  
* bin/zkCli.sh -server zk_host_ip:9700  
* ls / 