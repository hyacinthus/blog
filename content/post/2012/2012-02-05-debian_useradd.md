---
title: Debian6创建用户
author: muninn
type: post
date: 2012-02-05T07:56:23+00:00
url: /2012/02/05/debian_useradd.html
duoshuo_thread_id:
  - 1184800744742584385
categories:
  - 技术
tags:
  - Debian
  - Linux

---
可能大家会觉得这篇太弱了&#8230;

建个用户都要记

我以前一直用的redhat系的那些发行版

用Debian以后很多东西都要摸索

&#160;

昨天才搞清楚apt-get和aptitude

今天建用户也挺坎坷

&#160;

用户名用nicky代替吧

首先直接useradd nicky

发现除了用户啥都没有 连用户目录都没有

后来发现如果不自己指定的话

需要useradd –m nicky才会自动在home建目录

&#160;

然后就是切到新用户以后发现不太对&#8230;

和进到aix差不多

不能用tab 不能用退格删除&#8230;

太无力了

设置了半天profile 发现完全没用

后来竟然发现&#8230;原来用户的默认shell不是bash

需要在root执行

usermod -s /bin/bash nicky

这样才是用bash了

然后 一切就都又熟悉了