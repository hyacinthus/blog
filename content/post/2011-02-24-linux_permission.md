---
title: Linux执行命令出错
author: muninn
type: post
date: -001-11-30T00:00:00+00:00
url: /2011/02/24/linux_permission.html
duoshuo_thread_id:
  - 1184800744742584344
categories:
  - 未分类
tags:
  - Linux

---
执行Linux命令时报

cannot restore segment prot after reloc: Permission denied

查了很久权限没任何问题啊

原来是SELinux的问题

我自己装的时候都不装这个

这台机器是别人装的默认是开启SELinux的

企业内部服务器不暴露在互联网上

有企业防火墙就可以了 没必要再开类似的东西

&nbsp;

使用root用户修改/etc/sysconfig/selinux

SELINUX=disabled

然后再执行如下命令手动关闭就不用重启了

setenforce 0