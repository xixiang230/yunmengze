---
title: TRUNK介绍
date: 2018-01-01 08:16:09
tags: [trunk]
categories: [网络]
---
# 背景
VLAN的作用是**分割广播域**，处于不同VLAN的端口在二层是无法通信的，而两台交换机上处于同一VLAN间的端口要想通信，需要用线连接起来，一台交换机上VLAN最多可以设定4000多个，两台交换机之间当然不可能连4000多跟线了。

# trunk
为了解决上面问题，可以用一根**骨干链路trunk**来连接两台交换机，实现让两台交换机上处于相同VLAN的端口能相互通信，trunk上用特定的封装方式来支持转发不同VLAN的帧，封装主要是因为trunk上是允许转发不同VLAN的帧，所以需要打上特殊标记来区分帧到底属于哪个VLAN。比如，收到VLAN2的帧后会打上VLAN2的标记，通过trunk链路转发出去，对方交换机收到帧后，发现是VLAN2的帧，就讲VLAN2的标记去掉后发送到VLAN2的端口，实现相同VLAN在不同交换机间的通信。

# 示例
![trunk](https://github.com/xixiang230/xixiang230.github.io/blob/master/images/trunk.jpg?raw=true)
上图两台交换机的f0/1口配置为VLAN2，f0/0口配置成trunk接口，这样R1和R2就相当于直连可以互相ping通。R1发出的包，经过SW1在二层上呗打上VLAN2的标记，通过trunk链路转发到SW2，SW2去掉帧上的VLAN2的标记，经过VLAN2的端口即f0/1口发送到R2。
