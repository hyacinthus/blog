---
title: ORACLE中AS和IS的不同
author: muninn
type: post
date: 2010-11-30T00:00:00+00:00
url: /2010/11/30/oracle_as_is.html
duoshuo_thread_id:
  - 1184800744742584333
categories:
  - 未分类
tags:
  - ORACLE

---
答案是基本没有不同 哈哈

这是ORACLE为了方便而设置的同义词

在建存储过程(PROCEDURE)/函数(FUNCTION)

以及自定义类型(TYPE)/包(PACKAGE)的时候

用这两种都不会报错

&#160;

但是 并不是所有的地方都可以这样

在建视图(VIEW)的时候

是只能用 AS 而不能用 IS 的

&#160;

相反在声明游标(CURSOR)的时候

是只能用 IS 而不能用 AS 的

&#160;

我也是好奇才研究这个问题

中文网站上并没有详细的讨论过这个问题

查阅了很多资料和文档

有趣的是 发现在哪里都有难以理解的偏执狂

&#160;

在ORACLE官方论坛

看到一个人问存储过程用AS和IS什么区别

下边就有人回答没有区别 但是在视图里就不能用IS

这时候一个路人跳出来说

人家楼主明明问的是在存储过程里有什么区别

你不好好回答

逞的什么能 还扯什么视图

&#160;

这时候路人都看不下去了说人家回答问题怎么了

有人说经常见有人问这种语法问题说下也好

第一个回答的人很有涵养说大家不要吵

讨论问题就好了 我回答要是违规版主会处理的

这时候那个偏执狂继续跳出来战群雄

说这里是存储过程版面 讨论的什么语法问题

谁会在这里问语法问题 这里不欢迎你们

后来 后来当然是大家都不理他了
