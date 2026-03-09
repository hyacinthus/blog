---
title: Debian6搭建pptp服务器好简单
author: muninn
type: post
date: 2012-02-01T07:47:06+00:00
url: /2012/02/01/debian_pptpd.html
duoshuo_thread_id:
  - 1184800744742584384
categories:
  - 技术
tags:
  - Debian
  - Linux

---
换了系统第一件事当然是装pptpd

发现debian真心简单

以前CentOS不能直接用这个 还挺复杂的

&#160;

先安装

aptitude install pptpd

&#160;

编辑 /etc/pptpd.conf

去掉这两行的注释 没必要按照网上的换ip段

localip 192.168.0.1   
remoteip 192.168.0.234-238

&#160;

编辑 /etc/ppp/chap-secrets

添加用户

username pptpd password *

分别是 用户名 服务 密码 ip

服务和ip都可以用*代替的

&#160;

编辑 /etc/sysctl.conf

启用转发 去掉下边这行的注释就好了

net.ipv4.ip_forward = 1

&#160;

这一步可选 看要不要自定dns

编辑 /etc/ppp/pptpd-options

下面两行本来是注释的 可以打开写上希望的dns

ms-dns 8.8.8.8   
ms-dns 8.8.4.4

&#160;

这一步挺必要 设置iptables

编辑 /etc/rc.local

把下面两行添加在exit 0之前就可以

至于为什么 可以参考<a href="https://wdj01.blog.51cto.com/1059856/521113" target="_blank">这篇文章</a>

iptables -t nat -A POSTROUTING -o eth0 -s 192.168.0.0/24 -j MASQUERADE   
iptables -I FORWARD -p tcp &#8211;syn -i ppp+ -j TCPMSS &#8211;set-mss 1356

&#160;

刷新系统配置 重启服务

sysctl -p   
service pptpd restart

&#160;

搞定