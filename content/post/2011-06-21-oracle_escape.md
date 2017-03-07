---
title: Oracle转义字符
author: muninn
type: post
date: 2011-06-21T00:00:00+00:00
url: /2011/06/21/oracle_escape.html
duoshuo_thread_id:
  - 1184800744742584361
categories:
  - 未分类
tags:
  - ORACLE

---
程序员都知道 有特殊字符的地方 就应该有转义字符

今天想查数据库中X_开头的字段有多少个

用这样的语句

select count(*) from user\_tab\_columns where column\_name like &#8216;X\_%&#8217;

可结果当然是不对的 因为下划线代表的是一个字符

这就成了X后面至少还有一个字符的字段个数

于是我在下划线前边正斜杠反斜杠的试验 均没有作用

只好去查文档

原来Oracle的转义字符是自己指定的

这样查就可以了

select count(*) from user\_tab\_columns where column\_name like &#8216;X/\_%&#8217;ESCAPE &#8216;/&#8217;

当然把斜线换成除了下划线和百分号的其他任何字符都可以的
