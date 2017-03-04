---
title: Oracle wait for a undo record 的解决
author: muninn
type: post
date: 2014-05-16T06:57:29+00:00
url: /2014/05/16/oracle-wait-for-a-undo-record-的解决.html
duoshuo_thread_id:
  - 1184800744742584418
categories:
  - 技术
tags:
  - ORACLE

---
当 Oracle 的性能有问题的时候
  
有个要检查的地方是用dba用户
  
select * from v$session_wait
  
可以看到所有等待的事件
  
然后对着等待原因一条一条的google
  
其中有几种是可以忽略的
  
有的确实是会反映出问题

<a style="color: #000000;" href="https://blog.csdn.net/dbseeker/article/details/8795143">wait for a undo record</a> 这个事件
  
如果出现了大量
  
是回滚的任务太多被卡住了
  
<span style="color: #333333;">show parameter  fast_start_parallel_rollback<br /> 看看这个参数<br /> 如果不是false 请改成关闭<br /> alter system set fast_start_parallel_rollback=false;<br /> 它关闭的是回滚的并行操作<br /> 按理说是并行应该没什么问题 但是可能不成熟<br /> 多了就是会卡住 调整成串行很快卡住的任务就完成了<br /> 不要问我为什么 我也不知道 正在寻找<br /> 谁知道了也可以告诉我</span>

具体的这个参数可以google 很容易找到官方说明
  
另文本文参考了如下这篇 这位作者还模拟了一把 更加敬业
  
https://blog.csdn.net/dbseeker/article/details/8795143