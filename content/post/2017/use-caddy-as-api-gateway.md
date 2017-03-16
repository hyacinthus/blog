+++
date = "2017-03-16T21:12:49+08:00"
title = "使用 caddy 作为微服务的 API gateway"
tags = ["microservice","golang","api","caddy"]
draft = true

+++

## 背景

大家都知道，Docker在这些年让IT界产生了深刻的变革，
从开发到测试到运维，处处都有它的身影。
它同时也和微服务架构相互促进，并肩前行。

在最新版的Docker里，随着 `swarm mode` 的成熟，
在较简单的场景里已经可以不再需要专门的`基础设施管理`，
`服务编排`，`服务发现`，`健康检查`，`负载均衡`等等。

但是`API gateway`还是需要一个的。或许再加上一个`日志收集`，
你的微服务架构就五脏俱全了。
我们知道`Nginx Plus`是可以很好的胜任 API gateway 的工作的，
但它是商业软件。`Nginx`我们不说认证啊限流啊统计啊之类的功能，
单就请求转发这一点最基本的就出了问题。

我们知道Docker是用DNS的方式，均衡同一名称的服务请求到不同的node，
但是Nginx为了速度，在反向代理的时候会有一个不可取消的 DNS Cache，
这样我们Docker在根据容器的扩展或收缩动态的更新DNS，可Nginx却不为所动，
坚持把请求往固定的IP上发，不说均衡，这个IP甚至可能已经失效了呢。

有一个配置文件上的小Hack可以实现Nginx每次去查询DNS，我本来准备写一篇文章来着，
现在看来不用了，我们找到了更优雅的`API gateway`, [Caddy](https://caddyserver.com) 。
我上篇文章也写了一个它的简介。

## 应用

我们先用golang写一个最简单的HTTP API，你可以用你会的任何语言写出来，
它为`GET`请求返回 Hello World 加自己的 hostname .

```golang
package main

import (
	"io"
	"log"
	"net/http"
	"os"
)

// HelloServer the web server
func HelloServer(w http.ResponseWriter, req *http.Request) {
	hostname, _ := os.Hostname()
	log.Print("Hello, world! I am " + hostname + " :)\n")
	io.WriteString(w, "Hello, world! I am "+hostname+" :)\n")
}

func main() {
	http.HandleFunc("/", HelloServer)
	log.Fatal(http.ListenAndServe(":12345", nil))
}
```

