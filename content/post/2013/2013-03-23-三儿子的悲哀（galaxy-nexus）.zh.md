---
title: 三儿子的悲哀（Galaxy Nexus）
author: muninn
type: post
date: 2013-03-23T09:39:17+00:00
url: /2013/03/23/三儿子的悲哀（galaxy-nexus）.html
duoshuo_thread_id:
  - 1184800744742584397
categories:
  - 评测
tags:
  - Android
  - google

---
作为一个工程师
  
一直觉得被老罗批的一塌糊涂的原生安卓还挺好用的
  
没有来电显示吧 自己装一个软件
  
然后再简单装几个微博微信instagram什么的
  
基本就够用了

可是不知从某天开始
  
系统变得奇慢无比
  
开一个APP要卡好几秒
  
任何操作都要延迟一会

我寻思良久 不确定是什么导致的
  
怀疑有二
  
被自动推送了4.2.2
  
换了办公室那个地方信号及其微弱
  
可是 在信号好的地方 卡顿也就是有所好转 没有消失
  
至于版本 就没法测试了
  
我怀疑是某些国产应用水土不服
  
在新的系统上有兼容问题

其实真实的症状就好像CPU降频到了20%
  
然后导致任何操作都会很卡
  
内存占用和空间占用都无任何异常 后台也无任何可疑进程

说来说去 最后只能刷机了
  
本来以为可以一辈子等OTA推送最新的系统 直到它服役结束
  
不放心国内的任何资料 于是跑到CM官网
  
按照教程废了很久的劲 主要有以下几步

  1. <span style="line-height: 14px;">下载adb和fastboot这两个工具，它们都在官方的工具包里，不放心国内的修改版，于是直接去官网下。https://developer.android.com/sdk/index.html 下载DOWNLOAD FOR OTHER PLATFORMS 里的 SDK Tools Only。 直接下的整个的sdk由于是绿色的，不知为何在win8上有问题。 把这个工具下载下来还没完，安装后有个Manager，要在里边再让它自动安装平台相关的tools。这是和以前不一样的地方。</span>
  2. 解锁。必须在usb调试模式，4.2以后进调试模式需要费一点劲，自己搜一下方法。adb reboot bootloader ，然后，手机就启动到了bootloader的界面，这个时候驱动和以前不一样了，Windows是自动寻找不到的，要手动去下载一个。下载下来又遇到问题，win8默认不能安装没有认证的驱动，又需要在win8上折腾很久。直到adb devices能认出来手机以后，执行 fastboot oem unlock ，这一步执行了以后手机会恢复出厂设置。一定要在此前备份资料。
  3. 由于解锁后恢复出厂设置了，又需要开机随便点过向导界面，设置USB调试。然后下载安装ClockworkMod Recovery 。
  4. 这个时候，启动到Recovery模式，安装ROM和Google APPs就好了。记得要双cache。

整个过程在这里 https://wiki.cyanogenmod.org/w/Install\_CM\_for_maguro
  
我只是记录了在Win8上操作的几个坑