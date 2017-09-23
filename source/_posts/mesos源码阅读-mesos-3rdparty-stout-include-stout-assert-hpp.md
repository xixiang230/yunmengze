---
title: mesos源码阅读-mesos-3rdparty-stout-include-stout-assert.hpp
date: 2017-09-15 12:31:33
tags: [mesos]
---
#ifndef __STOUT_ASSERT_HPP__
#define __STOUT_ASSERT_HPP__

#include <stout/abort.hpp>

// Provide an async signal safe version `assert`. Please use `assert`
// instead if you don't need async signal safety.

宏 (void)0 , 这样用的目的是防止该宏被用作右值, (void)0 本身也不能作右值, 因为 void 非实际的类型! (void)0 就是把 0 转换成空类型的意思(void)0把0强行转换成void， 然后就没做什么了，这个语句只是一直在把整形字面值(int)0转换成void

相当于空语句，你也可以删了，如果你不删，在RELEASE版本下编译时也会被编译器删了，DEBUG版本会保留，但没什么意思，仅为占用一点点执行时间

(void)0 (+;) is a valid, but 'does-nothing' C++ expression, that's everything.  It doesn't translate to the no-op instruction of the target architecture, it's just an empty statement as placeholder whenever the language expects a complete statement (for example as target for a jump label, or in the body of an if clause).

EDIT: (updated based on Chris Lutz's comment)
It should be noted that when used as a macro, say #define noop ((void)0) the (void) prevents it from being accidentally used as a value like int x = noop;

For the above expression the compiler will rightly flag it as an invalid operation. GCC spits error: void value not ignored as it ought to be and VC++ barks 'void' illegal with all types.

You should note that, used as a macro (say, #define noop (void)0), the (void) prevents it from being accidentally used as a value (as in int x = noop;

Thanks Chris, for clarifying regarding why the type cast to void is made; it prevents from accidental usage of the said noop exp. in expression like assignment, now I did understand

Any expression that doesn't have any side-effects can be treated as a no-op by the compiler, which dosn't have to generate any code for it (though it may). It so happens that casting and then not using the result of the cast is easy for the compiler (and humans) to see as not having side-effects.

which basically means assert(whatever); is equivalent to ((void)(0));, and does nothing.

From the C89 standard (section 4.2): The header <assert.h> defines the assert macro and refers to another macro,
NDEBUG
which is not defined by <assert.h>. If NDEBUG is defined as a macro name at the point in the source file where <assert.h> is included, the assert macro is defined simply as #define assert(ignore) ((void)0)


#ifdef NDEBUG
#define ASSERT(e) ((void) 0)
#else
#define ASSERT(e) ((void) ((e) ? ((void) 0) : ABORT(#e)))
#endif

#endif // __STOUT_ASSERT_HPP__
