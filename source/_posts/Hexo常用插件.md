---
title: hexo添加插件
date: 2016-06-09 22:25:16
tags: [Hexo]  
---
# 添加RSS
* 使用npm安装插件  
```
npm install hexo-generator-feed
```
* 在配置文件中引用插件  
```
在hexo/_config.yml添加  
plugins:  
-hexo-generator-feed  
```

# 添加Sitemap  
* 使用npm安装插件  
```
npm install hexo-generator-sitmap  
```
* 在配置文件中引用插件  
```  
在hexo/_config.yml中添加  
plugins:  
- hexo-generator-sitemap  
```
# 添加Hexo-url-image
* 使用npm安装插件
```
npm install hexo-url-image --save
```
* 配置
```
在_config.yml中设置image_server_url字段
...
#URL
image_server_url: http://some.bkt.couddn.com/
...
```
# 添加代码高亮插件 
* 使用npm安装
```
nmp install hexo-tag-vimhighlight --save
```
* 配置
```  
在hexo/_config.yml中添加  
plugins:  
- hexo-tag-vimhighlight  
```
* 使用  
```
{% vimhl python true %}   //true --> show line number
...
{% endvimhl %}
```
