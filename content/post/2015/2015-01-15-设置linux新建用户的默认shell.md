---
title: 设置Linux新建用户的默认Shell
author: muninn
type: post
date: 2015-01-15T09:10:03+00:00
url: /2015/01/15/设置linux新建用户的默认shell.html
duoshuo_thread_id:
  - 1184800744742584424
categories:
  - 技术
tags:
  - Linux

---
有天装完新机器突然想把 useradd 的默认 shell 改成 zsh
  
搜索了一下 也许是我搜索的方式不对
  
有人一本正经的说把 useradd -s /bin/zsh 做成同义词
  
这不是逗我吗&#8230;

自己 man 了一下 useradd
  
说是只需要改 /etc/default/useradd 里的 SHELL 变量就好了
  
可是&#8230; 没有用!
  
不知道为什么 反正Ubuntu 14.04下没用

于是 在很多发行版里还有个命令 adduser
  
这个命令的默认配置在 /etc/adduser.conf
  
嗯 改这个是有用的 于是就用adduser命令创建用户吧
  
虽然啰嗦 但也省了你输入一大堆参数