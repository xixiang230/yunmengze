---
title: 'git push失败 -- ERROR: Repository not found --'
date: 2016-05-15 17:49:45
tags: [tag]
---
# 问题描述  
    git push -u origin master  
    ERROR: Repository not found.  
    fatal: The remote end hung up unexpectedly  
# 解决办法 
    ssh -T git@github.com  #make sure what was the github account used
    git remote -v  
    git remote rm origin   #if tips: fatal: remote origin already exists
    git remote add origin git@github.com:xixiang230/blog.git  
    git push -u origin master  
  
