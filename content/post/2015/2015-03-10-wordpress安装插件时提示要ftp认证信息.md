---
title: wordpress安装插件时提示要ftp认证信息
author: muninn
type: post
date: 2015-03-10T09:58:22+00:00
url: /2015/03/10/wordpress安装插件时提示要ftp认证信息.html
duoshuo_thread_id:
  - 1184800744742584426
categories:
  - 技术
tags:
  - wordpress

---
本来按照官方的说法 把wordpress放在一个root的公共目录下完全没什么问题
  
但是我考虑到有可能一个机器好几个实例 就把文件放在普通用户下了
  
然后改了改权限 可以运行了
  
然后就碰到了不能升级不能安装插件的问题

因为服务器设置了只能用key登陆嘛 认证那个页面虽然能填key但是怎么都不对
  
FTP当然是不会用了 都没装
  
我就开始改权限

开始走了弯路 研究了半天nginx的权限
  
最后发现 只要php-fpm的进程对那个wordpress目录有写权限就可以
  
php-fpm在ubuntu里默认用www-data用户的
  
甚至不用管nginx的用户和权限