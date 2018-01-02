---
title: ZooKeeper源码阅读之服务启动
date: 2018-01-02 22:17:22
tags: [zookeeper]
---
# 背景
分布式系统本质上来说就是不同节点上的进程并发执行，并且相互之间对进程的行为进行协调处理的过程。不同节点上的进程互相协调行为的过程叫做分布式同步。许多分布式系统都需要一个进程来作为任务的协调者，执行一些其它进程并不执行的特殊操作，自动选举出一个协调者的过程就是分布式选举，Zookeeper正是为了解决这一系列问题。

# ZK服务启动
Zk服务的启动方式有：单机模式，伪分布式模式，分布式模式。

# 单机模式
单机模式意味着只有一台机器，流程简单，通过读物conf目录下的zoo.cfg配置文件启动。几个重要参数：
1. tickTime：用于ZK服务端和客户端的会话控制，包括心跳，一般会话超时时间为该值得两倍，单位为毫秒。
2. dataDir：该目录用来存放数据库的镜像和操作数据库的日志。
3. clientPort：ZK服务端监听客户端的端口，默认2181。
ZK服务启动后，可通过ps或jps命令查看。
也可以通过启动脚本自带参数status来查看ZK进程状态
```
./zkServer.sh status
```
ZK服务运行后，可以通过命令行工具访问之
```
./zkCli.sh -server localhost:2181
```
# 分布式模式
多台ZK机器构成一个集群，集群内的所有机器成为quorum。集群最小配置为3台，最佳配置为5台。其中1台为Leader，另外4台为Follower，一旦Leader宕机，剩余的Follower就会重新选举出Leader。
分布式字段
* initLimit：follower对于leader的初始化连接timeout时间；
* syncLimit：follower对于leader的同步timeout时间
* timeout的计算公式为：initLimit*tickTime，syncLimit*tickTime
另外，对于配置：
```
server.ID=node1:port1:port2
```
其中port1用于follower和leader之间的通信，采用TCP方式，port2用于选举leader用。

# 流程源码解释
ZK的启动由zkServer.sh发起，真正的起源是Java类QuorumPeerMain，然后进行一系列配置后启动负责ZK服务的线程。

## zkServer.sh
这个脚本有好几种参数选择，包括start，start-foregroud，print-cmd，stop等
对于start方法，脚本使用nohup命令提交作业

## QuorumPeerMain
QuorumPeerMain类的Main函数很简单，直接调用initializeAndRun方法，参数即为zkServer.sh传入的参数，比如“start"，在initializeAndRun方法内部，首先启动的是定时清除镜像任务，默认设置为保留3分，由于
purgeInterval 这个参数默认设置为 0，所以不会启动镜像定时清除机制
接下来，如果配置的 ZooKeeper 服务器大于 1 台，调用 runFromConfig
方法进行集群信息配置，并启动 QuorumPeer 线程。
每个 QuorumPeer 线程启动之前都会先启动一个 cnxnFactory 线程，首先初始化
ServerCnxnFactory，这个是用来接收来自客户端的连接的，也就是这里启动的是一个 TCP
服务器。在 ZooKeeper 里提供两种 TCP 服务器的实现，一个是使用 Java 原生 NIO
的方式，另外一个是使用 NETTY。默认是 NIO 的方式，一个典型的 Reactor 模型，
