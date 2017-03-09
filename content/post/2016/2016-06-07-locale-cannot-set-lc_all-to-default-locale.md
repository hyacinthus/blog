---
title: 'locale: Cannot set LC_ALL to default locale'
author: muninn
type: post
date: 2016-06-07T02:02:20+00:00
url: /2016/06/07/locale-cannot-set-lc_all-to-default-locale.html
categories:
  - 技术
tags:
  - Linux
  - ubuntu

---
我之前用 Azure 的时候就碰到这个问题，当时搜索了一下解决了。
  
结果我今天用 ucloud 又出现了这个问题。
  
结果忘记那个生成语言包的命令了，又去搜，决定记下来。

一个云主机，用官方镜像列表中的 ubuntu server 14.04 初始化。
  
什么都没做，就有这个问题。
  
这几个厂商其实应该解决下这个问题。阿里云就没这问题。

先用 locale 命令看看

<pre class="lang:sh decode:true">ubuntu@10-9-53-8:~$ locale
locale: Cannot set LC_CTYPE to default locale: No such file or directory
locale: Cannot set LC_ALL to default locale: No such file or directory
LANG=en_US.UTF-8
LANGUAGE=en_US:en
LC_CTYPE=zh_CN.UTF-8
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=

ubuntu@10-9-53-8:~$ locale -a
locale: Cannot set LC_CTYPE to default locale: No such file or directory
C
C.UTF-8
en_US.utf8
POSIX

ubuntu@10-9-53-8:~$ localectl list-locales
C.UTF-8
en_US.utf8</pre>

所以其实这里只有一个问题。但有两个办法。
  
问题是设定的语言在系统里没有生成，不知道为啥默认的 LC_CTYPE 是中文。
  
想解决这个问题，要么生成中文的 locale ，要么全改成英文。
  
想要生成的话用这个命令:

<pre class="lang:sh decode:true ">ubuntu@10-9-53-8:~$ sudo locale-gen zh_CN.UTF-8
Generating locales...
  zh_CN.UTF-8... done
Generation complete.
ubuntu@10-9-53-8:~$ locale -a
C
C.UTF-8
en_US.utf8
POSIX
zh_CN.utf8
</pre>

想要改 locale 的话，去改

<pre class="">/etc/default/locale</pre>