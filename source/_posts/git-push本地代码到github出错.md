---
title: git push本地代码到github出错
date: 2016-05-15 17:37:27
tags: [git]
---
# 问题描述  
    git push -u origin master  
    To git@github.com:******/Demo.git  
    ! [rejected] master -> master (non-fast-forward)  
    error: failed to push some refs to 'git@github.com:******/Demo.git'  
    hint: Updates were rejected because the tip of your current branch is behind  
    hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')  
    hint: before pushing again.  
    hint: See the 'Note about fast-forwards' in 'git push --help' for details.    

# 原因  
远程repository和本地的repository冲突导致的，在github创建版本库时，在github的版本库页面点击了创建README.md文件的按钮创建了说明文档，但是却没有pull到本地。因为远程仓库比你的本地库更新，这样就产生了版本冲突的问题，所以得先 pull下来，再 push上去就ok了。  

# 解决办法  
1. 强制push  
`git push -u origin master -f`  
这样会使远程修改丢失，一般是不可取的，尤其是多人协作开发的时候。  
2. push前先将远程repository修改pull下来  
```
 git pull origin master  
 git push -u origin master  
```  
没有设定远程跟踪分支的话 你要使用这个命令 git pull origin master  

3. 若不想merge远程和本地修改，可以先创建新的分支： 
`git branch [name]`  
然后push  
`git push -u origin [name]`  
