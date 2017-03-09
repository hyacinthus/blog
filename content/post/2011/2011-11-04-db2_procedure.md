---
title: DB2存储过程重载
author: muninn
type: post
date: 2011-11-03T23:37:33+00:00
url: /2011/11/04/db2_procedure.html
duoshuo_thread_id:
  - 1184800744742584378
categories:
  - 技术
tags:
  - DB2

---
DB2的存储过程和很多语言的函数一样 是支持重载的 

就是同一个名字的存储过程 可以有不同的参数.

根据传入参数的个数个类型 系统会自动调用相应的存储过程

&#160;

可当有好几个名字一样的存储过程的时候

Drop PROCEDURE xxxx不就不好使了

系统不知道删除哪个啊

对此有两种办法:

1. 加上参数,比如Drop PROCEDURE xxxx(varchar(8)) 

系统就会找参数是varchar(8)的那个删

2. 使用SPECIFIC NAME删

关于SPECIFIC NAME大家可以搜索一下 是存储过程在全库的唯一标识

有人以前可能不理解它存在的意义 现在应该明白了

它的意义就是因为对象的名字可以重载 唯一代表不了那个对象

事实刚说的第一种情况也是DB2会在系统表中寻找对应SPECIFIC NAME删

语法是 DROP SPECIFIC PROCEDURE xxxx