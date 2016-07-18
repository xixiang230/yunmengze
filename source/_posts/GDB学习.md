---
title: GDB调试利器学习
date: 2016-06-21 22:33:15
tags: [GDB]
categories: [技术]
---
1. 源码编译，在编译前需要加上-g选项。
```
g++ -g -Wall -o house_roober 198_house_roober.cpp -std=c++11
gcc -g -Wall -o house_roober 198_house_roober.c
g++ -g hello.cpp -o hello
```
其中-g选项表示让编译器将符号表(对应程序的变量和代码行的内存地址列表)保存在生成的可执行文件中，这样在
调试时就讷讷个在调试会话中引用源码的变量名和行号。  
2. GDB启动 
调试可执行文件
```
gdb <program可执行文件>
gdb house_roober
gdb a.out
gdb -tui house_roober   #以tui模式运行GDB，可将终端分屏为源码窗口和控制窗口  
```
调试core文件，core是程序非法执行后core dump后产生文件。
```
gdb <program> <core dump file>
gdb program core.11127
```
调试服务程序  
```
gdb <program> <PID>
gdb hello 11127
```
根据场景需求，选择相应的方式即可进入GDB调试模式。  
3. GDB常用命令  
```
回车    #重复上一次命令  
quit    #退出GDB
ctrl+d  #退出GDB
return  #按下回车再次执行最近执行过的那条命令
r或run     #执行程序，遇到断点时停在断点处等待用户输入下一步命令。    
frame num #栈帧编号，当前正在执行的函数的帧编号为0，其父帧编号为1，依次类推。  
up      #调到调用栈中的下一个父帧  
down    #引向相反的方向  
backtrace #显示整个栈  
方向键  #滚动查看代码
p       #输出当前值  
ctrl+p  #浏览上一个GDB命令  
ctrl+n  #浏览下一个GDB命令  
call function(args)   #调用程序中可见的函数，并传递可参数
call TestFun(55)
quit或q #退出gdb
```
如果修改程序重新编译，不必重新启动GDB，GDB会在运行程序之前自动重新加载新的二分表和新的符号表。
4. 查看源码  
```
l或list           #不带参数，从第一行开始或接着上一次list命令列出源码，默认每次显示10行  
list LineNumber   #显示当前文件以行号为中心的前后共10行代码
list 函数名       #显示函数名所在函数的源代码
list main
```
4. 断点设置命令  
```
break LineNumber  #在LineNumber行上设置断点  
break 16          #在源码第16行处设置断点  
break FileName:LineNumber #在源码文件FileName的LineNumber行处设置断点  
break FunctionName  #在FunctionName函数入口(第一行可执行代码)处设置断点。
break func        #在函数func()入口处设置断点
break FileName:FunctionName #在源码文件FileNaem的函数Function入口处设置断点。  
b fn1 if a > b             #条件断点设置
delete n                   #删除第n个断点  
disable n         #暂停第n个断点  
enable n          #开启第n个断点
lear LineNumber            #清除第n行的断点
info b 或 info breakpoints #显示当前程序的断点设置情况  
delete breakpoints         #清处所有断点
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
5. 打印相关  
print或p  表达式   #
表达式可以是任何当前正在被测试程序的有效表达式，比如当前正在调试C程序，那么表达式可以是任何C语言的有效表达式，包括数字，变量甚至函数调用。  
print num         #打印整数num的值  
print ++num       #把num值加1后打印  
print name        #显示字符串name的值  
print func(22)    #将整数22作为参数调用func函数
print func(a)     #将变量a作为参数调用func函数
display 表达式 #在单步运行时非常有用，使用display命令设置表达式后，将在每次单步进行指令后，紧接着输出被设置的表达式和值。  
display a 
whatis    #查询变量或函数的类型  
info function  #查询函数  
info locals    #显示当前堆栈页的所有变量  
5. 查询运行信息  
where/bt        #当前运行的堆栈列表  
bt backtrace    #显示当前调用堆栈  
up/down         #改变堆栈显示的深度  
set args        #指定运行时的参数  
show args       #查看设置好的参数  
info program    #查看程序是否在运行，进程号，被暂停的原因  
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
next       #下一步，单步跟踪程序，当遇到函数调用时，不会进入函数体。
n          #下一步
```
step与next区别: 在函数调用时，step会进入函数体，而next会导致下一次暂停出现在函数调用之后，而不会进入函数体。  
setp与next后都可跟可选的一个数值，表要使用step或next执行的额外行数  
# 无条件恢复程序执行  
1. continue
```
continue(简写 c)  
```
无条件恢复程序执行，继续执行，直到遇到下一个断点或程序结束  
另外continue可接受一个可选的数值参数n，要求GDB忽略接下来的n个断点。  

2. finish(fin) 和 until(u)命令恢复
finish命令指示GDB恢复执行，运行程序，直到恰好在当前帧完成之后为止(直到当前函数完成返回)，并打印函数返回时的堆栈地址和返回值以及参数值等信息。  
until命令通常用来在不进一步循环中暂停(除了循环中的中间断点)的情况下完成正在执行的循环。until会执行循环的其余部分，当厌倦了在一个循环体内单步跟踪时，until可以运行程序直到退出循序体。  
(如果遇到断点，还是会暂停)，让GDB在循环后面的第一行代码处暂停。  
until命令也可以接受源码中的位置作为参数，用法与break命令相同。  
```
until 行号     #运行至某行，不仅仅用来跳出循环  
until 13
until swap 
until swapflaw.c:13
until swapflaw.c:swap
```
上述命令均可方便地使程序一直执行到swap()函数的入口。  

#监视点
监视点是一种特殊类型的断点，区别在于监视点没有"住在"某一行源码中，而是指示GDB每当某个表达式改变了值就暂停
执行，即一旦被监视的表达式值改变，gdb将强行终止正在被调试的程序。
```
watch a        #设置监视点，watch后跟变量名，也可以是复杂的表达式  
```
监视点只能监视存在切在作用域中的变量，一旦遍历不再存在于调用栈的任何帧中，GDB会自动删除监视点。  
GDB实际上是在遍历的内存位置改变值时中断。  
5. 窗口分割  
layout      #用于分割窗口，可一边查代码一边测试  
layout src  #显示源码窗口
layout asm  #显示反汇编窗口  
layout regs #显示源码/反汇编和CPU寄存器窗口  
layout split #显示源码和反汇编窗口 
Ctrl+L      #涮新窗口
