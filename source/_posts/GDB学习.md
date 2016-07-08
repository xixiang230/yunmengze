---
title: GDB学习
date: 2016-06-21 22:33:15
tags: [GDB]
categories: [技术]
---
1. 源码编译
```
g++ -g -Wall -o house_roober 198_house_roober.cpp -std=c++11
gcc -g -Wall -o house_roober 198_house_roober.c
```
其中-g选项表示让编译器将符号表(对应程序的变量和代码行的内存地址列表)保存在生成的可执行文件中，这样在
调试时就讷讷个在调试会话中引用源码的变量名和行号。  
2. GDB启动 
```
gdb house_roober
gdb a.out
gdb -tui house_roober   #以tui模式运行GDB，可将终端分屏为源码窗口和控制窗口  
```
即可进入GDB调试模式。  
3. GDB常用命令  
```
l或list #从第一行开始列出源码  
回车    #重复上一次命令  
quit    #退出GDB
ctrl+d  #退出GDB
return  #按下回车再次执行最近执行过的那条命令
r或run     #执行程序  
frame num #栈帧编号，当前正在执行的函数的帧编号为0，其父帧编号为1，依次类推。  
up      #调到调用栈中的下一个父帧  
down    #引向相反的方向  
backtrace #显示整个栈  
方向键  #滚动查看代码
p       #输出当前值  
print   #输出当前值  
ctrl+p  #浏览上一个GDB命令  
ctrl+n  #浏览下一个GDB命令  
```
如果修改程序重新编译，不必重新启动GDB，GDB会在运行程序之前自动重新加载新的二分表和新的符号表。
4. 断点设置相关命令  
```
break LineNumber  #在LineNumber行上设置断点  
break 16          #在源码第16行处设置断点  
break FileName:LineNumber #在源码文件FileName的LineNumber行处设置断点  
break FunctionName  #在FunctionName函数入口(第一行可执行代码)处设置断点。
break func        #在函数func()入口处设置断点
break FileName:FunctionName #在源码文件FileNaem的函数Function入口处设置断点。  
```
在函数名上设置断点相比行断点而言，如果修改了源代码，使得函数位置所在行发生变化，行断点就失去原来的作用了，
而函数断点仍然有效。但需要注意函数重载的情况。  
当GDB使用多个断点中断一行源码时，只会中断一次。  

5. 条件断点  
```
condition BreakNum Cond    #condition后跟断点编号和条件
condition 1 num == 1         #当满足条件num==1时，GDB才会在断点行编号1处暂停程序的执行  
```
如果以后要删除条件，但保持断点，键入:
```
cond BreakNum  
```
用break if可以将break和condition命令组合成一个步骤  
```
break BreakNum if cond  
break 30 if num == 1  #条件语句可以用小括号括起来  
```
#  临时断点tbreak
和break类似，但该命令设置的断点在首次到达该指定行后就不再有效  
# 删除断点  
1. break 可以基于标志符删除断点
```
delete BreakNum1 #删除指定断点编号 
delte            #删除所有断点  
```
2. clear 依据断点位置，工作方式删除，与break命令对应  
```
clear function   
clear FileName:function 
clear BreakNum  
clear FileName:BreakNum
clear          #清除GDB将执行的下一个指定处的断点  
```
3. 禁用与启用断点  
```
disable BreakPointList  #用空格分隔开的多个断点标志符  
disable                 #禁用现存所有断点  
enable BreakPointList   #启用断点  
enable once BreakPointList  #在下次引起GDB暂停执行后禁用  
```
4. 断点查看
```
info break              #查看断点信息
info breakpoints 
i b 
```
5. 使用commands命令设置命令列表  
让GDB在每次到达某个断点时自动执行一组命令，从而自动完成某一任务  
```
commands BreakPointNumber  
......
commands
......
end
```
实例  
```
commands 1     #首先输入GDB命令，进入commands模式

[silent]       #可选的silent命令，在命令列表开始处设置，避免GDB输出冗长  
printf "fibonacci was passed %d .\n", n       #设置命令列表，这里的printf和C中printf用法类似，可省略括号。   
end
```
# 执行  
```
step       #单步执行，单步进入 
s          #单步执行
next       #下一步，单步越过
n          #下一步
```
step与next区别: 在函数调用时，step会进入函数，而next会导致下一次暂停出现在函数调用之后  
setp与next后都可跟可选的一个数值，表要使用step或next执行的额外行数  
# 无条件恢复程序执行  
1. continue
```
continue 
c  
```
无条件恢复程序执行，直到遇到下一个断点或程序结束  
另外continue可接受一个可选的数值参数n，要求GDB忽略接下来的n个断点。  
2. finish(fin) 和 until(u)命令恢复
finish命令指示GDB恢复执行，直到恰好在当前帧完成之后为止。  
until命令通常用来在不进一步循环中暂停(除了循环中的中间断点)的情况下完成正在执行的循环。until会执行循环的其余部分
(如果遇到断点，还是会暂停)，让GDB在循环后面的第一行代码处暂停。  
until命令也可以接受源码中的位置作为参数，用法与break命令相同。  
```
until 13
until swap 
until swapflaw.c:13
until swapflaw.c:swap
```
上述命令均可方便地使程序一直执行到swap()函数的入口。  

#监视点
监视点是一种特殊类型的断点，区别在于监视点没有"住在"某一行源码中，而是指示GDB每当某个表达式改变了值就暂停
执行。
```
watch z        #设置监视点，watch后跟变量名，也可以是复杂的表达式  
```
监视点只能监视存在切在作用域中的变量，一旦遍历不再存在于调用栈的任何帧中，GDB会自动删除监视点。  
GDB实际上是在遍历的内存位置改变值时中断。  
