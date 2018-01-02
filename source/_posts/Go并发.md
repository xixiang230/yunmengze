---
title: Go并发
date: 2017-12-31 23:01:51
tags:[Go]
categories: [技术]
---
# goroutine
goruotine本质上就是协程，比线程颗粒更小，十几个goroutine可能提现在底层就是五六个线程，且Go语言内部已经帮你实现了goroutine直接的内存共享。执行一个groutine只需要极小的栈内存(4~5KB)，具体会根据相应的数据伸缩。正因为如此，可同时运行成千上万个并发任务，goroutine比thread更易用、高效、轻便。
<!-- more -->

# 使用
通过go关键字即可启动一个goroutine，例:
```
package main
import (
  "fmt"
  "runtime"
)

func say(s string) {
  for i := 0; i < 5; i++ {
      runtime.Gosched()
      fmt.Println(s)
  }
}

func main() {
    go say("world")  // 开一个新的Goroutine执行
    say("hello")     // 当前Goroutine执行
}
```
