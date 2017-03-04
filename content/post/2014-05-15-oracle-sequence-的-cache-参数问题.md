---
title: ORACLE SEQUENCE 的 CACHE 参数问题
author: muninn
type: post
date: 2014-05-15T09:56:16+00:00
url: /2014/05/15/oracle-sequence-的-cache-参数问题.html
duoshuo_thread_id:
  - 1184800744742584417
categories:
  - 技术
tags:
  - ORACLE

---
今日上线了个应用
  
发现测试上每笔一秒的交易生产上要5秒
  
经过追踪活跃的 session 情况
  
查到全部阻塞到了获取某个 Sequence 的下个值的时候

查阅了一下资料 发现建立 Sequence 的时候
  
Cache 这个参数很重要 尤其是在RAC集群环境下
  
设置了 Cache 以后 Oracle 会先将一定数据的序号取到内存里 大大的减少了锁等待的时间和写日志时间
  
但是在数据库 down 掉 关掉 或者干脆机器内存满了的时候 那些序号都可能消失掉
  
于是就发生 id 跳序号的情况
  
还有即使一切正常没有跳序号
  
RAC 环境还会有记录id次序和时间次序不一致的情况
  
但是肯定是不会出现重复序号的

所以其实还有一个 ORDER 参数
  
可以在 RAC 强制保持次序
  
当然会有一定代价

Cache 的默认值是20
  
如果使用频繁的话 建议保持在100以上
  
具体的数值可以在实际应用的时候测试一下
  
100的时候写入应该比 NOCACHE 能快很多倍

总之 我要说的是
  
在 RAC 环境下 如果是比较繁忙的应用
  
不要打 NOCACHE 的主意 完全无法接受
  
如果要求序列号连续 那只能在应用级别解决了
  
别想用数据库的 Sequence 了

对了 在把 Cache 从0调整到100后
  
我们的一个交易(大概有几十个insert) 从5秒降低到了0.5秒

以上基于 11g R2