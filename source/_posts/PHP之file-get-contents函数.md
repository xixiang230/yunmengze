---
title: PHP之file_get_contents函数
date: 2016-05-17 20:06:09
tags: [PHP]
---
# 用法  
file_get_contents函数用于把整个文件读入到一个字符串中，是用来将文件内容读入字符串的首选方法，如果操作系统支持，还会使用内存映射技术来增强性能。  
`string file_get_contents ( string $filename [, bool $use_include_path = false [, resource $context [, int $offset = -1 [, int $maxlen ]]]] )`  

* filename 为要读取的文件的名称，可以是绝对或相对路径名。  
* 返回：The function returns the read data 或者在失败时返回 FALSE。

```
  <?php
      $content = file_get_contents("../test.txt");  
      echo $content;  
  ?>  
```
# 弊端  
使用file_get_contents函数获取URL内容时，当URL访问不了，会导致页面漫长等待，甚至还导致PHP进程占用CPU达100%之多，造成服务宕机。  

而于是，现在的file_get_contents函数更多的是用于读取本地文件。

file函数用于把整个文件读入到一个数组中，数组中的每个单元对应着文件中的一行，其中包括换行符在内。读取失败返回false。  

# 使用curl代替file_get_contents  
示例：  

``` 
   <?php  
       $url = 'http://www.baidu.com';  
       
       $timeout = 5;  
       
       $ch = curl_init();  
       
       curl_setopt($ch, CURLOPT_URL, $url);  
       curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); //curlopt_returntransfer  
       curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);  //curlopt_connecttimeout  
       $file_contents = curl_exec($ch);  
       curl_close($ch);
       
       echo $file_contents;  
       
   ?>
```  

```  
   <?php
       if(function_exists('file_get_contents')) {
           $file_contents = file_get_contents($url);
        } else {
            $ch = curl_init();  
            $timeout = 5;  
            $curl_setopt($ch, CURLOPT_URL, $url);  
            $curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);  
            $curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);  
            $file_contents = curl_exec($ch);  
            curl_close($ch);  
        }
        echo $file_contents;  
```  

# 禁用file_get_contents  
关闭php的allow_url_fopen选项，可禁用file_get_contents来获取远程web页面的内容。  
```
打开php.ini配置  
将
allow_url_fopen = On  
改为
allow_url_fopen = Off  
```  

# 总结 
file_get_contents在用于获取ip地址信息时，与curl相比，大约有30%的性能差距。  平时用file_get_contents来读文件就行，file_get_contents如果远程超时并发大的话很可能把服务器拖垮，在获取远程信息，调用api之类用curl，建议禁用url_open。