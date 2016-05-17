---
title: git拉取失败 -- You have not concluded your merge (MERGE_HEAD exists)
date: 2016-05-15 17:19:19
tags: [git]
---
# 问题描述  
```
git pull  
You have not concluded your merge (MERGE_HEAD exists).  
Please, commit your changes before you can merge.  
```  
# 错误原因  
可能是因为在以前pull下来的代码没有自动合并导致的 

# 解决办法  
保留本地修改  
```
git merge --abort  
git reset --merge  
git pull           #获取线上仓库
``` 
