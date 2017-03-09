---
title: Google App Engine更新的1.4.0
author: muninn
type: post
date: 2010-12-03T00:00:00+00:00
url: /2010/12/03/gae_update.html
duoshuo_thread_id:
  - 1184800744742584334
categories:
  - 未分类
tags:
  - GAE
  - news

---
&nbsp;&nbsp; &nbsp;Google App Engine服务器端和SDK包先后更新到了1.4.0。Google App Engine就是个Google提供的免费虚拟主机，可以支持Python语言和Java语言，很好玩哦。这个Blog就是搭建在GAE之上。

&nbsp;

&nbsp;&nbsp; &nbsp;本次是一个较大的版本更新，受到众多开发人员的期待。

&nbsp;&nbsp; &nbsp;更新的特性主要有:

1.新的Always On特性可以供三个应用实例在后台常驻运行.(此前最长只支持30秒)

2.可以支持一个实例初始化程序.

3.Channel API对所有的用户开放.

4.任务队列更新到正式版.

5.任务队列和任务计划的执行时间限制延长到10分钟.(此前是30秒)

6.可以自定义任务队列的重试时间.支持队列数目增加到100.

7.数据存储区现在可以查询类型,表空间和实体的属性.

8.URLFetch应答数据增加到32M.

9.程序发出的邮件附件限制从1M提高到10M,接收的限制仍然是10M.

10.数据存储的批量接口不再限制每次操作的数据量,普通请求仍为1M.

11.控制台的黑名单现在可以显示被拒绝的访问者信息.

12.自动图像裁剪服务支持像素上升到1600px.

13.可以下载源码了!(以前只能同步上传)

&nbsp;

&nbsp;&nbsp; &nbsp;另外还有一些小的更新个bug修复,详情请参见更新列表:

&nbsp;&nbsp; &nbsp;https://code.google.com/p/googleappengine/wiki/SdkReleaseNotes
