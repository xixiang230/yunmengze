---
title: Hexo安装部署
date: 2016-05-19 07:53:53
tags: [Hexo]
categories: [技术]
---
# Git安装  

```
brew intall git
```

# Node.js安装  

* 安装nvm  

```
$ curl https://raw.github.com/creationix/nvm/master/install.sh | sh
```
或
```
wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh
```

* 安装Node.js  
```
nvm instll 0.10
```
* 安装Hexo

```
sudo npm install -g hexo-cli
sudo npm instll hexo --save
```

* 安装Hexio插件
```
sudo npm install hexo-generator-index --save
sudo npm install hexo-generator-archive --save
sudo npm install hexo-generator-category --save
sudo npm install hexo-generator-tag --save
sudo npm install hexo-server --save
sudo npm install hexo-deployer-git --save
sudo npm install hexo-deployer-heroku --save
sudo npm install hexo-deployer-rsync --save
sudo npm install hexo-deployer-openshift --save
sudo npm install hexo-renderer-marked@0.2 --save
sudo npm install hexo-renderer-stylus@0.2 --save
sudo npm install hexo-generator-feed@1 --save
sudo npm install hexo-generator-sitemap@1 --save
```
# 创建博客  
```
hexo init       #初始化
sudo npm instll #安装依赖
```

