---
title: oracle的long数据类型
author: muninn
type: post
date: 2011-04-01T00:00:00+00:00
url: /2011/04/01/oracle_long.html
duoshuo_thread_id:
  - 1184800744742584352
categories:
  - 未分类
tags:
  - ORACLE

---
做ETL的时候碰到一个LONG类型的字段

作为多年的程序员直接就把它当成长整形了

后来发现报错了……

仔细一查 发现这个LONG和数字相差好远

不知oracle定义的时候是怎么想的

怪不得现在的版本官方不建议用这个类型了

在网上找了点这个类型的资料

> 1、LONG 数据类型中存储的是可变长字符串，最大长度限制是2GB。   
> 2、对于超出一定长度的文本，基本只能用LONG类型来存储，数据字典中很多对象的定义就是用LONG来存储的。   
> 3、LONG类型主要用于不需要作字符串搜索的长串数据，如果要进行字符搜索就要用varchar2类型。   
> 4、很多工具，包括SQL*Plus，处理LONG 数据类型都是很困难的。   
> 5、LONG 数据类型的使用中，要受限于磁盘的大小。

> 能够操作 LONG 的 SQL 语句：   
> 1、Select语句   
> 2、Update语句中的SET语句   
> 3、Insert语句中的VALUES语句

> 限制：   
> 1、一个表中只能包含一个 LONG 类型的列。   
> 2、不能索引LONG类型列。   
> 3、不能将含有LONG类型列的表作聚簇。   
> 4、不能在SQL*Plus中将LONG类型列的数值插入到另一个表格中,如insert into &#8230;select。   
> 5、不能在SQL*Plus中通过查询其他表的方式来创建LONG类型列,如create table as select。   
> 6、不能对LONG类型列加约束条件（NULL、NOT NULL、DEFAULT除外），如：关键字列(PRIMARY KEY)不能是 LONG 数据类型。   
> 7、LONG类型列不能用在Select的以下子句中：where、group by、order by，以及带有distinct的select语句中。   
> 8、LONG类型列不能用于分布查询。   
> 9、PL/SQL过程块的变量不能定义为LONG类型。   
> 10、LONG类型列不能被SQL函数所改变，如：substr、instr。

以上内容出自<a href="https://blog.csdn.net/zzr173/archive/2008/04/22/2313646.aspx" target="_blank">这里</a>。
