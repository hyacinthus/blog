---
title: Oracle删除有数据的用户
author: muninn
type: post
date: 2011-03-18T00:00:00+00:00
url: /2011/03/18/oracle_drop_user.html
duoshuo_thread_id:
  - 1184800744742584350
categories:
  - 未分类
tags:
  - ORACLE

---
oracle在drop有数据的用户的时候

会报错误

ORA-01922: CASCADE must be specified to drop &#8216;username&#8217;.

正如提示的

你只需要输入命令

drop user 用户名 cascade;

就会把这个用户的对象全部一起删除
