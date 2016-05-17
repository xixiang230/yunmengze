---
title: Git常用命令整理
tags: [git]
---
# 初始化配置  
git一共有3个配置文件：一是仓库级配置文件，位于当前仓库下(./.git/config)；二是全局配置文件(~/.gitconfig)；三是系统级别配置文件（/etc/gitconfig)。  

对于git而言，各个配置文件的权重比较为：仓库 > 全局 > 系统。git使用这一系列的配置文件来存储个人偏好，在工作时首先查找/etc/gitconfig文件（系统级），其次查找~/.gitconfig文件（全局级），最后查找仓库下的配置文件.git/config(仓库级)，以上三层配置层层推进，如有冲突，会以最后一次为准。虽然可手动编辑配置，但使用git config命令更为便捷。

当安装git后首先要做的就是设置用户名和e-mail地址，因为git的每次提交都会使用这两个信息，嵌入到提交之中。  
* 配置使用git仓库的人员姓名  
`git config --global user.name "xixiang230"`

* 配置使用git仓库人员的email  
`git config --global user.email "371524660@qq.com"`

<!-- more -->
* 打开用户git配置文件目录  
`vim ~/.gitconfig`

* 查看git配置，列出git可以在该处找出的所有配置  (--list)  
`git config --list`  
`git config -l`  

* 编辑git配置（--edit）  
`git config --local -e`  #编辑仓库级配置文件  
`git config --global -e` #编辑全局级配置文件  
`git config --system -e` #编辑系统级配置文件  

* 增加一个配置项(--add)  
`git config --add section.key value`  #(和前面一样，默认都操作local配置)  
其中add选项后面section，key，value一项都不能少。  
`git config --add cat.name Tom`  

* 使用git查找特定关键字的有效值（--get）  
`git config --get section.key`     #（默认获取local配置中的内容） 
`git config --get cat.age`  
等效于  
`git config user.name`  

* 命令别名(git co 代替git checkout)  
`git config --global alias.co checkout`  

>     通过git config 工具可获取和设置配置变量，这些变量可以控制Git的外观和操作。  
>     --global选项，使得git config工具读写用户账户下的配置文件(~/.gitconfig)  
>     --system选项，使得git config工具读写系统账户下的配置文件(/etc/gitconfig)
>     --local选项或不带选项，使得git config工具读写当前仓库的配置文件(.git/config)  

* 删除一个配置项（--unset）  
`git config [-local|--global|--sysytem] --unset section.key`  
`git config --local --unset cat.name`  
    
* 配置编辑器  
`git config --global core.editor vim`  
git在需要输入一些消息时会使用该指定的文本编辑器。  

* 配置比较工具 
`git config --global merge.tool vimdiff`  
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

* 为本地仓库添加一个远程仓库地址
`git remote add origin git@github.com:xixiang230/hello-word.git`  

* 删除远程仓库  
`git remote rm <repository>`  

* 查看远程仓库，-v列出远程服务器地址和仓库名称  
`git remote -v`  
    git remote -v  
    origin	git@github.com:xixiang230/blog.git (fetch)  
    origin	git@github.com:xixiang230/blog.git (push)  
    
    git remote  
    origin  

* 查看远程服务器仓库状态（显示远程信息）  
`git remote show origin`  

* 从远程仓库抓取数据(更新同步)  
`git fetch`  

* 抓取远程仓库所有分支更新并合并到本地
`git pull`  

* 推送数据到远程仓库（把本地仓库master分支跟踪到远程分支）  
`git push origin master`  

* push 所有分支  
`git push`  

* 查看远程仓库信息  
`git remote show origin`  

* 远程仓库的删除和重命名(pb改为paul)  
`git remote rename pb paul`  

* 修改远程分支地址  
`git remote set-url origin remote_git_address`  
---  
# 添加与提交  

* 添加当前目前下所有修改文件到暂存区  
`git add .`  
`git add *.c`  #添加以.c为后缀的文件  
`git add file`  #添加指定文件或目录    
git add 是将file的信息添加到git仓库的索引库中，并没有真正添加到库

* 提交修改到本地仓库    
`git commit -m "message"`  
git commit会将索引库中的内容向git仓库进行提交，这步之后文件file才真正提交到git仓库中。  

* 把已经跟踪的文件全部提交（添加并提交）  
`git commit -a -m "message"`  

现在文件已经提交到本地仓库了，接下来需要推送到远程仓库   

* 为本地仓库添加一个远程仓库（将本地仓库与远程仓库关联）  
`git remote add origin git@github.com:xixiang230/remote.git`  
* 推送更新到远程服务器(将本地master分支跟踪到远程分支)  
`git push origin master`  
在git仓库建立之初就有一个默认的master分支，如果建立了其他分支，也可用同样的方法跟踪。  

* 查看仓库当前的提交状态    
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
# git新建仓库操作流程  
1. global用户配置信息设置    
    git config --global user.name "xixiang230"  
    git config --global user.emai "371524660@qq.com"  
  
2. 新建仓库和关联  
    mkdir newrepository  
    cd new repository  
    git init           #  git本地初始化          
    touch README.md    
    git add README.md  
    git add .         #   将所有文件添加到版本控制系统
    git commit -m "first commit"  
    git remote add origin git@github.com:xixiang230/newrepository.git   # 添加远程仓库  
    git push -u origin master   # 将本地版本库推送到远程仓库
第一次推送master分支时可加上-u参数，git不但会把本地master分支内容推送到远程新的master分支，还会把本地master分支和远程master分支关联起来，在之后的推送或拉取时简化命令。    

