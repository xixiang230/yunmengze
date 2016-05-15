---
title: Git常用命令整理
tags:
- Git
---
# 初始化配置
* 配置使用git仓库的人员姓名  
`git config --global user.name "xixiang230"`

* 配置使用git仓库人员的email  
`git config --global user.email "371524660@qq.com"`

<!-- more -->
* 打开用户git配置文件目录  
`vim ~/.gitconfig`

* 查看git配置  
`git config --list`  

* 命令别名(git co 代替git checkout)  
`git config --global alias.co checkout`
---    
# 初始化仓库  
* 初始化一个版本仓库  
`git init`  
---  

# 添加文件  
* 取消对文件的修改  
`git checkout -- readme.txt`    
`git co --  <file>`  
`git co .`  
* 获取远端分支  
`git checkout -b sf origin/serverfix`  
* 将工作文件修改提交到本地暂存区  
`git add <file>`  

* 将所有修改过的工作文件提交到暂存区  
`git add .`    
---  
# 删除文件  
* 从版本库中删除文件  
`git rm <file>`  
* 移除跟踪，但不删除文件  
`git rm --cached readme.txt`  
---  
# 移动文件  
* 移动文件  
`git mv file_from file_to`  
---  
# 查看文件diff  
* 比较当前文件和暂存区文件差异  
`git difff <file>`  
`git diff`  

* 比较两次提交之间的差异  
`git diff <$id1> <$id2>`  

* 比较已暂存文件和上次提交文件的差异  
 `git diff --cached`  
 ---
# 查看提交记录  
* 查看提交的历史记录    
`git log`  
`git log <file>`  
* 查看最近两次提交内容的差异  
`git log -p -2`  
* 简要显示增改行数统计  
`git log --stat`   
---  
# 取得Git仓库  
* Clone远程版本库  
`git clone git@github.com:xixiang230/hello-word.git`  
`git clone https://github.com/xixiang230/hello-word.git`

* 添加远程仓库地址
`git remote add origin git@github.com:xixiang230/hello-word.git`  

* 删除远程仓库  
`git remote rm <repository>`  

* 查看远程仓库，-v列出远程服务器地址和仓库名称  
`git remote -v`  

* 查看远程服务器仓库状态  
`git remote show origin`  

* 从远程仓库抓取数据(更新同步)  
`git fetch`  

* 抓取远程仓库所有分支更新并合并到本地
`git pull`  

* 推送数据到远程仓库（推送当前分支到master分支）  
`git push origin master`  

* push 所有分支  
`git push`  

* 查看远程仓库信息  
`git remote show origin`  

* 远程仓库的删除和重命名(pb改为paul)  
`git remote rename pb paul`  
---  
# 提交修改  

* 添加当前修改文件到暂存区  
`git add .`  

* 提交修改  
`git commit -m "message"`  

* 把已经跟踪的文件全部提交，跳过add步骤  
`git commit -a -m "message"

* 推送更新到远程服务器  
`git push origin master`  

* 查看仓库状态  
`git status`  
---  
# 取消暂存文件  
* 取消已经暂存的文件  
`git reset HEAD fileName`  

* 假设已经使用如下命令，将修改过的文件a,b添加到暂存区    
`git add .`  
现在只想提交a文件，不想提交b文件，执行如下命令  
`git reset HEAD b`

* 从暂存区恢复到工作文件  
`git reset <file>`  
`git reset -- .`  
 
* 恢复最近一次提交，即放弃上次提交后的所有本次修改  
`git reset --hard`  

* 取消对文件的修改，回滚到未修改状态  
`git checkout -- fileName`

* 从暂存区恢复到工作文件  
`git reset <file>`  
---  
# 创建分支  
* 创建test分支  
`git branch test`  
* 切换到test分支  
`git checkout test`  
* 创建并切换到test分支  
`git checkout -b test`  
* 分支合并到当前分支  
`git merge hotfix`  
---  
# 查看分支  
* 查看最后一次commit信息  
`git branch -v`  
* 筛选出已经/尚未与当前分支合并的分支  
`git branch --merged`  
`git branch --no-merger`  
* 查看所有分支信息  
`git branch -r`  
--- 
# 删除分支  
* 删除test分支  
`git branch -D test`  
--- 

