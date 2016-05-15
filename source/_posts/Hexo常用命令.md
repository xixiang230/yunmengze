---
title: Hexo常用命令
tags: [Hexo]
---
 
# 基本命令 
* hexo安装命令  
`npm install hexo -g`  

* hexo升级  
`npm update hexo -g`  

<!-- more -->
* hexo初始化目录  
`hexo init`  

* 创建新文章  
`hexo n`  

* 生成静态页面（需在init的目录下执行）  
`hexo g`  
`hexo generate`  

* 部署  
`hexo d`  
`hexo deploy`  

* 生成并部署  
`hexo d -g`  

* 本地启动，进行文章预览调试    
`hexo server`  
`hexo s`  
 输入http://localhost:4000即可查看本地预览效果  
 
* 更改端口  
`hexo server -p 5000`
  
* 清除缓存  
`hexo clean`  

# 模板  
```
title: 使用Hexo搭建个人博客
layout: post
date: 2016-05-15 19:07：43
comments: true
categories: Blog
tags: [Hexo]
keywords: Hexo, Blog
description: 生命在于折腾
```
# 部署设置  
修改 _config.yml为
```
# Deployment
\#\# Docs: http://hexo.io/docs/deployment.html
deploy:
  type: git  
  repository: git@github.com:xixiang230/xixiang230.github.io.git  
  branch: master
```

# 报错  
1. 找不到git部署  
```ERROR Deployer not found: git```  
**解决方法**  
```npm install hexo-deployer-git --save```  
# 显示RSS  
* 安装RSS插件  
`npm install hexo-generator-feed --save`  
# 开启RSS功能 
编辑hexo/_config.yml，添加如下代码  
rss: /atom.xml  
