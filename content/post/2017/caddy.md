+++
date = "2017-03-12T21:27:09+08:00"
title = "caddy"
tags = ["caddy","golang","webserver"]
draft = true

+++

`caddy`是一个像 Apache, nginx, 或 lighttpd 的web服务器。
你要问nginx已经很好了，为什么要用caddy呢? 我觉得caddy最大的特点是用起来简单，
然后呢，它还有下面这些开箱即用的特性:

* `HTTP/2` 全自动支持HTTP/2协议，无需任何配置。
* `自动HTTPS` Caddy 使用 Let's Encrypt 让你的站点全自动变成全站HTTPS，无需任何配置。当然你想使用自己的证书也是可以的。
* `Multi-core` 因为caddy是golang写的，所以当然可以合理使用多核啦。
* `IPv6` 完全支持IPv6环境.
* `WebSockets` Caddy 对WebSockets有很好的支持.
* `Markdown` 自动把md转成 HTML ，当然，我后续要给大家介绍更强大的hugo来干这个事情.
* `Logging` Caddy 对log格式的定义很容易，更好的满足你日志收集的需求。
* `Easy Deployment` 得益于go的特性，caddy只是一个小小的二进制文件，没有依赖，很好部署。

