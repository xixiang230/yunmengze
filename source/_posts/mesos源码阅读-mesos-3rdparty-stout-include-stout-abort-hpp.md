---
title: mesos源码阅读-mesos/3rdparty/stout/include/stout-abort.hpp
date: 2017-09-14 13:45:45
tags: [mesos]
---
#ifndef __STOUT_ABORT_HPP__
#define __STOUT_ABORT_HPP__

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef __WINDOWS__
#include <stout/windows.hpp>
#else
#include <unistd.h>
#endif // __WINDOWS__

#include <string>

#include <stout/attributes.hpp>

// 宏中的#的功能是将其后面的宏参数进行**字符串化**操作（Stringizing operator），简单说就是在它引用的宏变量的左右各加上一个双引号。
如定义好
```
#define STRING(x) #x
```
之后，下面二条语句就等价。
char *pChar = "hello";
char *pChar = STRING(hello);

还有一个#@是加单引号（Charizing Operator）
```
#define makechar(x)  #@x
char ch = makechar(b);  // 与char ch = 'b';等价。
```

// NOTE: These macros are already defined in Visual Studio (Windows) headers.
#ifndef __WINDOWS__
#define __STRINGIZE(x) #x
#define _STRINGIZE(x) __STRINGIZE(x)
#endif // __WINDOWS__


// C++ Primer:
如果两个**字符串字面值**位置紧邻，且仅由空格、缩进和换行符等分隔，则他们实际上是一个整体。当书写的字符串字面值比较长，写在一行不太合适时，可以采取分开书写的方式。
2) __FILE__ ：宏在预编译时会替换成当前的源文件名
3) __LINE__：宏在预编译时会替换成当前的行号
4) __FUNCTION__：宏在预编译时会替换成当前的函数名称
5）类似的宏还有 __TIME__,__STDC__, __TIMESTAMP__等,就完全当一个变量来使用即可。
// Signal safe abort which prints a message.
#define _ABORT_PREFIX "ABORT: (" __FILE__ ":" _STRINGIZE(__LINE__) "): "

C99编译器标准允许定义**可变参数宏(variadic macros)**，这样你就可以使用拥有可以变化的参数列表的宏。可变参数宏就像下面这个样子:
```
#define debug(...) printf(__VA_ARGS__)
```
缺省号代表一个可以变化的参数列表。使用保留名 __VA_ARGS__ 把参数传递给宏。当宏的调用展开时，实际的参数就传递给 printf()了。例如: 
```
Debug("Y = %d\n", y);
```
而处理器会把宏的调用替换成: 
```
printf("Y = %d\n", y);
```
因为debug()是一个可变参数宏，所以能在每一次调用中传递不同数目的参数，这里'...'指可变参数。这类宏在被调用时，它(这里指'...')被表示成零个或多个符号，包括里面的逗号，一直到到右括弧结束为止。当被调用时，在宏体(macro body)中，那些符号序列集合将代替里面的__VA_ARGS__标识符。 __VA_ARGS__：总体来说就是将左边宏中 ... 的内容原样抄写在右边 __VA_ARGS__ 所在的位置。它是一个可变参数的宏，是新的C99规范中新增的。
#define ABORT(...) _Abort(_ABORT_PREFIX, __VA_ARGS__)

// 这是C++11的attribute specifier sequence( http://en.cppreference.com/w/... )， 关于[[noreturn]]，官方解释是
Indicates that the function does not return. 
This attribute applies to function declarations only. The behavior is undefined if the function with this attribute actually returns.
该specifier用来指示函数永不返回，有助于编译器进行编译优化（如尾递归等），也可以用于抑制编译器给出不必要的警告（如int f();
f();，不加[[noreturn]]的话，编译器会警告f()的返回值被忽略）

但是，若函数的确有返回值，而你却指定[[noreturn]]的话，这就是未定义行为了。 类似这种为通用属性，使用左右双中括号包含
[[ attribute-list ]]
[[ attr1 ]] void fun [[ attr2 ]] ();
[[ attr1 ]] int array [[ attr2 ]] [10];

C++11中的预定义通用属性包括 [[ noreturn ]] 标识不会返回的函数，[[ carries_dependency ]] 标识不会将控制流返回给原调用函数的函数，如
[[ noreturn ]] void ThrowAway() {
     throw "exception”;
}

inline NORETURN void _Abort(const char* prefix, const char* message)
{
  // NOTE: On Windows, `_write` takes an `unsigned int`, not `size_t`. We
  // preform an explicit type conversion here to silence the warning. `strlen`
  // always returns a positive result, which means it is safe to cast it to an
  // unsigned value.
#ifndef __WINDOWS__
  const size_t prefix_len = strlen(prefix);
  const size_t message_len = strlen(message);
#else
  const unsigned int prefix_len = static_cast<unsigned int>(strlen(prefix));
  const unsigned int message_len = static_cast<unsigned int>(strlen(message));
#endif // !__WINDOWS__

  // Write the failure message in an async-signal safe manner,
  // assuming strlen is async-signal safe or optimized out.
  // In fact, it is highly unlikely that strlen would be
  // implemented in an unsafe manner:
  // http://austingroupbugs.net/view.php?id=692
  // NOTE: we can't use `signal_safe::write`, because it's defined in the header
  // which can't be included due to circular dependency of headers.

//1.EINTR(intr 系统调用被禁止)错误产生的原因；
当阻塞于某个慢系统调用的一个进程，捕获到某个信号且相应信号处理函数返回时，该系统调用可能会返回一个EINTR错误。例如：在socket服务器端，设置了信号捕获机制，有子进程当在父进程阻塞于慢系统调用时，由父进程捕获到了一个有效信号时，内核会致使accept返回一个EINTR错误(被中断的系统调用)。

// 2.如何解决：
当碰到EINTR错误的时候，可以采取有一些可以重启的系统调用进行重启，而对于有一些系统调用是不能够重启的。例如：accept、read、wiret、seletc、ioctl和open之类的函数来说是可以进行重启的。不过对于套接字编程中的connect函数是不能进行重启的。

若connetct函数返回一个EINTR错误的时候，则不能再次调用它，否则将返回一个错误。针对connect不能重启的特性，必须调用select函数来等待连接完成。

慢系统调用（slow system call）该术语适用于那些可能永远阻塞的系统调用。永远阻塞的系统调用是指调用永远无法返回，多数网络支持函数都属于这一类。

调用系统调用的时候，有时系统调用会被中断，此时系统调用会返回-1，并且错误码被置为EINTR。但是，有时并不将这样的情况作为错误，有两种处理方法:
1.如果错误码为EINTR则重新调用系统调用，例如Postgresql中有一段代码:
```
retry1:  
if (send(port->sock, &SSLok, 1, 0) != 1)  {  
    if (errno == EINTR)  
        goto retry1;    /* if interrupted, just retry */  
}

2.重新定义系统调用,忽略错误码为EINTR的情况。例如,Cherokee中的一段代码:
int  cherokee_stat (const char *restrict path, struct stat *buf)  {  
    int re;  
    do {  
        re = stat (path, buf);  
    } while ((re == -1) && (errno == EINTR));  
    return re;  
}  

有时候，在调用系统调用时，可能会接收到某个信号而导致调用退出。譬如使用system调用某个命令之后该进程会接收到SIGCHILD信号，然后如果这个进程的线程中有慢系统调用，那么接收到该信号的时候可能就会退出，返回EINTR错误码。

EINTR 　　linux中函数的返回状态，在不同的函数中意义不同：

1）write
表示：由于信号中断，没写成功任何数据。 　　The call was interrupted by a signal before any data was written.

2）read
表示：由于信号中断，没读到任何数据。 　　The call was interrupted by a signal before any data was read.

3）sem_wait
函数调用被信号处理函数中断 　　The call was interrupted by a signal handler.

4）recv
由于信号中断返回，没有任何数据可用。 　　function was interrupted by a signal that was caught, before any data was available.

  while (::write(STDERR_FILENO, prefix, prefix_len) == -1 && errno == EINTR);
  while (message != nullptr && ::write(STDERR_FILENO, message, message_len) == -1 && errno == EINTR);

  // NOTE: Since `1` can be interpreted as either an `unsigned int` or a
  // `size_t`, removing the `static_cast` here makes this call ambiguous
  // between the `write` in windows.hpp and the (deprecated) `write` in the
  // Windows CRT headers.
  // 通常情况下，size_t其实就是unsigned int，是用typedef给unsigned int指定的别名。
  while (::write(STDERR_FILENO, "\n", static_cast<size_t>(1)) == -1 && errno == EINTR);

exit和abort都是用来终止程序的函数，他们的不同如下：
exit会做一些释放工作：释放所有的静态的全局的对象，缓存，关掉所有的I/O通道，然后终止程序。如果有函数通过atexit来注册，还会调用注册的函数。不过，如果atexit函数扔出异常的话，就会直接调用terminate。

abort：立刻terminate程序，没有任何清理工作。abort函数导致异常程序终止。

```
#include <stdlib.h>
void abort(void);   // 函数决不返回。
```


这个函数向调用者发送SIGABRT(abrt)信号。（进程不该忽略这个信号。）ISO C指出调用abort将会用raise(SIGABRT)来向主机环境分发一个不成功的终止消息。

ISO C要求如果信号被捕获而信号处理器返回，abort仍然不返回到它的调用者。如果信号被捕获，信号不能返回的唯一方式是调用exit、_exit、
_Exit、longjmp或siglongjmp。（10.15节讨论了longjmp和siglongjmp的区别。）POSIX.1也规定 abort覆盖进程对这个信号的阻塞或忽略。

让进程捕获SIGABRT的意图是允许它执行任何它想在进程终止前的清理。如果进程不在信号处理器里终止它自己，那么根据POSIX.1当信号处理器返回时，abort终止这个进程。

ISO C对这个函数的规定让实现来决定输出流是否被冲洗以及临时文件是否被删除。POSIX.1要求更多，要求如果abort调用终止进程，那么在进程里的打开的标准I／O流上的效果将和进程在终止前为每个流调用fclose的效果一样。

系统V的早期版本从abort函数产生SIGIOT信号。此外，一个进程可能忽略这个信号或捕获它并从信号处理器返回，在这种情况下abort返回到它的调用者。

4.3BSD产生了SIGILL信号。在这样做之前，4.3BSD函数反阻塞这个信号并重置它的布署为SIG_DFL（带有核心文件的终止）。这避免了一个进程忽略或捕获这个信号。

历史上，abort的实现在它们处理标准I／O流的方式上有所区别。为了健壮的程序和更好的可移植性，如果我们想标准I／O流被冲洗，那么我们在调用abort前应该明确地做这件事。

因为多数UNIX系统的temfile的实现在创建这个文件后立即调用unlink，所以ISO
C关于临时文件的警告通常不用我们担心。exit()和_exit()函数都可以用于结束进程，不过_exit()调用之后会立即进入内核，而exit()函数会先执行一些清理之后才会进入内核，比如调用各种终止处理程序，关闭所有I/O流等_exit()函数的描述,意思是_exit()函数终止调用的进程，进程所有的文件描述符（在linux中一切皆文件）都被关闭，
这个进程的所有子进程将被init（最初的进程，所有的进程都是来自init进程，所有的进程都由其父进程创建，即init进程是所有进程的祖先！）进程领养,并且这个终止的进程将向它的父进程发送一个sigchld信号。_exit()的参数status被返回给这个终止进程的父进程来作为这个终止进程的退出状态，这个退出状态值能被wait()函数族的调用收集（就是通过wait()函数来获得子进程的退出状态，之后wait()函数将会释放子进程的地址空间，否则会出现zoom进程）。

  _exit()函数是系统调用。会清理内存和包括pcb（内核描述进程的主要数据结构）在内的数据结构，但是不会刷新流，而exit()函数会刷新流。比如exit()函数会将I/O缓冲中的数据写出或读入（printf()就是I/O缓冲,遇到‘\n’才会刷新，若直接调用exit()则会刷新,而_exit()则不会刷新）exit()函数导致子进程的正常退出，并且参数status&0377这个值将被返回给父进程。exit()应该是库函数。exit()函数其实是对_exit()函数的一种封装（库函数就是对系统调用的一种封装）。

   

3.return
不是系统调用，也不是库函数，而是一个关键字，表示调用堆栈的返回（过程活动记录），是函数的退出，而不是进程的退出。

return函数退出，将函数的信息返回给调用函数使用，与exit()和_exit()函数有本质区别。abort()函数用于异常退出。返回一个错误代码。错误代码的缺省值是3。abort()函数导致程序非正常退出除非sigabrt信号被捕捉到，并且信号处理函数没有返回（即abort()函数给自己发送sigabrt信号），如果abort()函数导致程序终止，所有的打开的流将被关闭并且刷新。

  abort();
}


inline NORETURN void _Abort(const char* prefix, const std::string& message)
{
  _Abort(prefix, message.c_str());
}


#endif // __STOUT_ABORT_HPP__


对于socket接口(指connect/send/recv/accept..等等，不包括不能设置非阻塞的如select)，在阻塞模式下有可能因为发生信号返回EINTR错误，由用户做重试或终止。 但是，在非阻塞模式下，是否出现这种错误呢？ 对此，重温了系统调用、信号、socket相关知识，得出结论是：不会出现。 

首先 
1.信号的处理是在用户态下进行的，也就是必须等待一个系统调用执行完了才会执行进程的信号函数，所以就有了信号队列保存未执行的信号 
2.用户态下被信号中断时，内核会记录中断地址，信号处理完后，如果进程没有退出则重回这个地址继续执行 

socket接口是一个系统调用，也就是即使发生了信号也不会中断（因为信号处理是在用户态下进行）必须等socket接口返回了，进程才能处理信号。也就是，EINTR错误是socket接口主动抛出来的，不是内核抛的。socket接口也可以选择不返回，自己内部重试之类的，那阻塞的时候socket接口是怎么处理发生信号的? 

举例 
socket接口，例如recv接口会做2件事情， 
1.检查buffer是否有数据，有则复制清除返回 
2.没有数据，则进入睡眠模式，当超时、数据到达、发生错误则唤醒进程处理 

socket接口的实现都差不了太多，抽象说 
1.资源是否立即可用，有则返回 
2.没有，就等... 

对于 
1.这个时候不管有没信号，也不返回EINTR，只管执行自己的就可以了 
2.采用睡眠来等待，发生信号的时候进程会被唤醒，socket接口唤醒后检查有无未处理的信号(signal_pending)会返回EINTR错误。 

所以 
socket接口并不是被信号中断，只是调用了睡眠，发生信号睡眠会被唤醒通知进程，然后socket接口选择主动退出，这样做可以避免一直阻塞在那里，有退出的机会。非阻塞时不会调用睡眠。 
