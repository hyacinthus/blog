---
title: Oracle 11g中慎用exp和imp
author: muninn
type: post
date: -001-11-30T00:00:00+00:00
url: /2011/06/15/oracle_expdp.html
duoshuo_thread_id:
  - 1184800744742584360
categories:
  - 未分类
tags:
  - ORACLE

---
在Oracle 11g中

由于11系列的产品存储机制的改变

表在第一次存储数据时才会分配segment

这就导致用exp命令导出数据库会发现空表基本都没有被导出

&#160;

在网上看到了很多人出了很多办法

什么插入一条数据再删除

什么修改系统参数

我就觉得很可笑

&#160;

除非特别特殊的情况

为何非要吊死在这个命令上呢

Oracle在10g的时候便已经提供了两个更加先进的替换命令

叫expdp和impdp

&#160;

感兴趣的人使用expdp help=y看下帮助

或者在网上搜索下用法

就会发现这一对命令用起来格式和exp以及imp是一样的

只不过更加强大 改进了更多的东西而已

所以普通的数据库导入导出

用这一对命令就可以了

别再用落后的exp和imp了