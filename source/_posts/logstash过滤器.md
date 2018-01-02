---
title: logstash过滤器
date: 2018-01-01 22:36:32
tags: [logstash]
---
# grok正则捕获
grok是logstash最重要的插件，可以在grok里预定义好命名正则表达式，并在后面的处理中引用之。
下面是给配置文件添加一个过滤器区段的配置。配置要添加在输入和输出区段之间，虽然说logstash执行区段的时候并不依赖于书写时的次序，不过为了看得方便，尽量按次序书写：
```
input {stdin{}}
filter {
  grok  {
    match => {
        "message" => "\s+(?<request_time>\d+(?:\.\d+)?\s+"
    }
  }
}
output {stdout{}}
```
运行logstash进程然后输入"begin 123.456 end"，将会看到类似如下输出：
```
{
    “message" => "begin 123.456 end",
    "@version" => "1",
    "@timestamp" => "2014-08-09T11:55:32.186Z",
    "host" => "host",
    "request_time" => "123.456"
}
```
上面输出结果美中不足的地方是request_time应该是数值而不是字符串。不过我们有办法来做字段值类型转换。

# grok表达式语法
grok支持把预定义的grok表达式写入到文件，在新版的logstash里，pattern目录已经为空，示例：
```
USERNAME [a-zA-Z0-9._-]+
USER %{USERNAME}
```
上面第一行为用普通的正则表达式来定义一个grok表达式；
第二行，通过打印赋值格式，用前面定义好的grok表达式来定义另一个grok表达式。
grok表达式的打印复制格式的完整语法如下：
```
%{pattern_name:capture_name:data_type}
```
data_type当前只支持int和float。
现在，我们可以改进前面的配置如下：
```
filter {
    grok {
        match => {
            "message" => "%{WORD:request_time:float} %{WORD}"
        }
    }
}
```
重新运行进程后结果如下：
```
{
    "message" => "begin 123.456",
    "@version" => "1",
    "@timestamp" => "2014-08-09T12:23:36.634Z"
    "host" => "host",
    "request_time => 123.456
}
```
现在，request_time就是数值类型了。

# 最佳实践
实际运用中，需要处理各种各样的日志文件，如果都是在配置文件里各自些一行自己的表达式，就难以管理了，所以建议把所有的grok表达式统一写入到一个地方，然后用filter/grok的patterns_dir选项来指明。
