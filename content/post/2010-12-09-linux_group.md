---
title: usermod修改用户群组的问题
author: muninn
type: post
date: -001-11-30T00:00:00+00:00
url: /2010/12/09/linux_group.html
duoshuo_thread_id:
  - 1184800744742584336
categories:
  - 未分类
tags:
  - AIX
  - Linux

---
今天测试的程序 发现应用用户对oracle突然没权限了

去/etc/group看了一下 发现果然应用用户不在dba组了

这时才想起来之前自己用usermod -G给这个用户加过组

&nbsp;

于是仔细查了查资料 才发现的确有问题

也许以前都是改/etc/group文件的 对usermod这个命令并不熟悉

usermod &ndash;G 并不是往从组里加一个group

而是会把用户以前的组全部抹掉 完全赋值成新的

所以用的时候已经记得把所有需要的组写一遍

&nbsp;

其实如此说来改组还是直接去改/etc/group方便了

这个文件每行的格式为

组名:加密的口令:GID:用户1,用户2,&hellip;