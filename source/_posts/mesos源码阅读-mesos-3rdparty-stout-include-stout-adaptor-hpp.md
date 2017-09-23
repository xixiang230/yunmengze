---
title: mesos源码阅读-mesos-3rdparty-stout-include-stout-adaptor.hpp
date: 2017-09-15 12:07:32
tags:[mesos]
---

#ifndef __STOUT_ADAPTOR_HPP__
#define __STOUT_ADAPTOR_HPP__

// boost区间适配器
类似迭代器的适配器，range库提供区间适配器，可以把一个区间适配成另一个区间，因为区间的能力基于迭代器，因此变动了迭代器也就变动了区间，使区间不仅能表达元素的范围，更可以处理元素。

range库的适配器位于名字空间boost::adaptors，需要包含头文件<boost/range/adaptors.hpp>
其中适配器reversed表逆序区间
#include <list>
#include <iostream>
#include <boost/range/adaptor/reversed.hpp>

int main() {
    std::list<int> x { 2, 3, 5, 7, 11, 13, 17, 19 };
    for (auto i : boost::adaptors::reverse(x))
        std::cout << i << '\n';
    for (auto i : x)
        std::cout << i << '\n';
}

template<class BidirectionalRange >  
reversed_range < BidirectionalRange >  boost::adaptors::reverse (BidirectionalRange &rng) 
  
template<class BidirectionalRange >  
reversed_range< const BidirectionalRange >  boost::adaptors::reverse (const BidirectionalRange &rng) 

#include <boost/range/adaptor/reversed.hpp>

// This is modeled after boost's Range Adaptor. It wraps an existing
// iterator to provide a new iterator with different behavior. See
// details in boost's reference document:
// http://www.boost.org/doc/libs/1_53_0/libs/range/doc/html/index.html
namespace adaptor {

using boost::adaptors::reverse;

} // namespace adaptor {

#endif // __STOUT_ADAPTOR_HPP__

