---
title: Docker源码分析之架构学习
date: 2017-09-11 11:34:24
tags: [Docker]
---

<!-- vim-markdown-toc GFM -->

* [学习背景](#学习背景)
* [Docker介绍](#docker介绍)
* [Docker架构](#docker架构)
    * [DockerDaemon](#dockerdaemon)
        * [Engine](#engine)
        * [Job](#job)
    * [Driver](#driver)
    * [Docker Container](#docker-container)

<!-- vim-markdown-toc -->
# 学习背景
从今天开始Docker源码的学习和总结，以《Docker源码分析》一书的结构和解说为基础，配合其它资料学习，旨在弄懂每一个细节和概念。

# Docker介绍
Docker借助操作系统层的虚拟化来实现资源隔离，因此在运行时，Docker容器与宿主机是共享同一操作系统的，不会产生额外的操作系统开销，从而可大大提高资源利用率和提升I/O性能。 
# Docker架构
Docker主要模块
- DockerClient
- DockerDaemon
- Docker Registry
- Graph
- Driver
- libcontainer
- Docker Container

## DockerDaemon
1. 接收并处理Docker Client请求
2. 管理所有的Docker容器

DockerDaemon结构
- Docker Server
- Engine
- Job

### Engine
Engine存储大量的容器信息，管理Docker大部分Job的执行。
### Job
Job是Engine内部最基本的工作执行单元。

## Driver
Docker Driver主要一下三类驱动：
1. graphdriver：
2. networkdriver
3. execdriver

## Docker Container
Docker
Container是Docker架构中服务交付的最终表现形式和交付单位，通过DockerDaemon的管理，libcontainer的执行，最终是创建出一个Docker容器。
