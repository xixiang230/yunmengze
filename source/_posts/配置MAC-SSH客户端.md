---
title: 配置MAC SSH客户端/Users/baidu/GitHub/Hexo/source/_posts/配置MAC-SSH客户端.md
date: 2016-05-16 22:26:54
tags: [mac,iTerm2]
---
# iTerm2快捷键  
|快捷键|功能|  
|:------|-----|  
|⌘ + T|新建标签页|
|⌘ + 数字|各 tab 标签切换|  
|⌘ + f |查找 ，所查找的内容会被自动复制 ,输入查找的部分字符，找到匹配的值按tab，即可复制|  
|⌘ + d|垂直分屏|
|⌘ + shitf + d|水平分屏| 
|⌘ + r|换到新一屏|
|ctrl + u|清空当前行，无论光标在什么位置|  
|⌘ + shift + h|会列出剪切板历史|  
|⌘ + enter|全屏|	
<!-- more -->

# 设置共享ssh会话  
功能：每天只要输入一次token密码，只要不关闭第一个ssh窗口，便可共享第一次会话，无需重新输入密码。  
执行如下命令操作：  

    vim ~/.ssh/config  
    添加：  
    Host *  
    ControlPath ~/.ssh/master-%r@%h:%p  
    ControlMaster auto  
    
# 与服务器共享文件 
功能： 实现rz，sz命令上传和下载文件  

*  下载lrzsz-0.12.20.tar.gz，安装lrzsz  

       tar zxvf lrzsz-0.12.20.tar.gz
       cd lrzsz-0.12.20
       sudo ./configure && make && make install
       sudo ln -s /usr/local/bin/lrz /usr/local/bin/rz
       sudo ln -s /usr/local/bin/lsz /usr/local/bin/sz  
    
* 下载iterm2-zmodem.zip并解压  
    
       sudo cp iterm2-recv-zmodem.sh iterm2-send-zmodem.sh /usr/local/bin  
       sudo chmod +x /usr/local/bin/iterm2-*  
      
* 设置iTerm2  
       
       iTerm->Preferences->Profiles->Advanced->Default->Triggers->Edit  
       点击左下角"+"，双击表格添加如下格式的两行配置  

|Regularexpression|Action|Parameters|
|:-----------------:|:------:|:----------:|
|\*\*B0100|Run Silent Coprocess|/usr/local/bin/iterm2-send-zmodem.sh| 
|\*\*B00000000000000|Run Silent Coprocess|/usr/local/bin/iterm2-recv-zmodem.sh|
       
* 使用  

       上传文件到服务器：在服务器上执行rs  
       下载文件到MAC：在服务器上执行sz filename1 filename2 ... filename3 

       
       