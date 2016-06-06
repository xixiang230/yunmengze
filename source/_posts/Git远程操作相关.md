---
title: Git远程操作相关
date: 2016-06-02 21:33:37
tags: [Git]  
categories: [技术]
---
# git clone  
在本地主机生成一个目录，默认与远程主机版本库同名  
```
git clone <版本库网址>
git clone https://github.com/jquery/jquery.git
git clone <版本库的网址> <本地目录名>  #支持本地重命名目录  
```
# git remote  
Git要求每个远程主机都指定了一个主机名，git remote命令就是用于管理主机名的  
* git remote  #不带选项
列出关联的所有远程主机,一般有一台名为origin的远程主机，在克隆版本库时，所使用的远程主机会被自动命名为origin。若想使用其他主机名，需要使用git clone 命令的-o 选项指定。    
```
git clone -o remote_maching_name http://github.com/xixiang230/
* git remote -v 
查看远程主机名以及网址  
* git remote show <主机名>  
查看主机详细信息  
* git remote add <主机名>  <网址>
用于添加主机  
* git remote rm <主机名> 
用于删除远程主机  
* 远程主机改名  
```
git remote rename <原主机名>  <新主机名>  
```  
# git fetch  
当远程主机版本库有更新(术语commit)，需要将远程仓库的更新同步到本地  
```
git fetch <远程主机名>  
```  
默认情况下，git fetch取回所有分支的更新，取回特定分支需要指定分支名  
``` 
git fetch <远程主机名>  <分支名>  
git fetch origin master  #取回origin主机的master分支  
```
git fetch 命令通常用来查看他人的进程，其取回的代码对本地开发代码无影响。  
git fetch 命令取回的更新，在本地主机上需要用"远程主机名/分支名"形式读取。比如读取origin主机的master分支，需用到origin/master。
# 产看远程分支
```
git branch -r  #查看远程分支，显示:   origin/master

git branch -a  #查看所用分支  
* master                      #表示本地主机的当前分支是master
remotes/origin/master         #表示远程分支是origin/master
```
取回远程主机的更新后，在其基础上，可使用git checkout命令创建一个新的分支  
```
git checkout -b new_branch origin/master  #表在origin/master的基础上，创建一个新分支  
```
#在本地分支上合并远程分支  
在当前分支上，合并origin/master  
```
git merge origin/master  
git rebase origin/master  
``` 
# git pull  
用于取回远程主机某个分支的更新，再与本地指定的分支合并  
```
git pull <远程主机名>  <远程分支名>:<本地分支名>  
取回origin主机的next分支，并与本地的master分支合并  
git pull origin next:master
如果是将远程分支与当前分支合并，可省略冒号后面的部分  
git pull origin next  #取回origin/next分支，再与当前分支合并，等同于先 git fetch再git merge
git fetch origin  
git merge origin/next  
```
在某些场合git会自动在本地分支和远程分支间建立追踪关系(tracking)，比如在git clone时，所有本地分支默认与远程主机的同名分支建立追踪关系。即本地master分支自动追踪origin/master分支。  
手动建立追踪关系  
git branch --set-upstream master origin/next #指定master分支追踪origin/next分支   
如果当前分支与远程分支存在追踪关系，git pull就可以省略远程分支名。  
```
git pull origin #本地当前分支自动与对应的origin主机上追踪的分支(remote-tracking branch)进行合并    
```
如果当前分支只有一个追踪分支，可省略远程主机名  
```
git pull  #当前分支自动与唯一一个追踪分支进行合并  
```
如果合并需要采用rebase模式，可使用--rebase选项。
```
git pull --rebase <远程主机名> <远程分支名>:<本地分支名>  
```
如果远程主机删除了某个分支，默认情况下，git pull不会在拉取远程分支的时候删除对应的本地分支，避免由于其他人操作了远程主机，导致git pull隐式删除本地分支。加-p参数会在本地删除远程已经删除的分支。  
```
git pull -p    #等同于
git fetch --prune origin  
git fecth -p
```
# git push
git push用于将本地分支的更新，推送到远程主机，格式与git pull类似。
```
git push <远程主机名> <本地分支名>:<远程分支名>  
```
分支推送顺序写法为:   <来源>:<目的>
git pull <远程分支>:<本地分支>  
git push <本地分支>:<远程分支>  
若省略远程分支名，则表示将本地分支推送给与之存在追踪关系的远程分支，通常两者同名，如果该远程分支不存在，则新建  
```
git push origin master
```
