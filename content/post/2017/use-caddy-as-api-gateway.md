+++
date = "2017-03-16T21:12:49+08:00"
title = "使用 caddy 作为微服务的 API gateway"
tags = ["microservice","golang","api","caddy"]
draft = false

+++

## 背景

大家都知道，Docker这些年让IT界产生了深刻的变革，
从开发到测试到运维，处处都有它的身影。
它同时也和微服务架构相互促进，并肩前行。

在最新版的 Docker(CE 17.03) 里，随着 `swarm mode` 的成熟，
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

接下来的所有代码，都在这个[demo](https://github.com/hyacinthus/caddy-api-gateway-demo)中，
你可以clone下来玩，也能在此基础上做自己的实验。

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
	log.Println(hostname)
	io.WriteString(w, "Hello, world! I am "+hostname+" :)\n")
}

func main() {
	http.HandleFunc("/", HelloServer)
	log.Fatal(http.ListenAndServe(":12345", nil))
}
```

## Docker 化

我们需要把上面的应用做成一个docker镜像，暴露端口`12345`。
接着才有可能使用`Docker Swarm`启动成集群。
本来做镜像特别简单，但我为了让大家直接拉镜像测试时快一点，用了两步构建，
先编译出应用，然后添加到比较小的`alpine`镜像中。大家可以不必在意这些细节。
我们还是先来看看最终的`docker-compose.yml`编排文件吧。

```yaml
version: '3'
services:
    app:
        image: muninn/caddy-microservice:app
        deploy:
            replicas: 3
    gateway:
        image: muninn/caddy-microservice:gateway
        ports:
            - 2015:2015
        depends_on:
            - app
        deploy:
            replicas: 1
            placement:
                constraints: [node.role == manager]
```

这是最新版本的`docker-compose`文件，不再由`docker-compose`命令启动，而是要用`docker stack deploy`命令。
总之现在这个版本在编排方面还没有完全整合好，有点晕，不过能用。现在我们看到编排中有两个镜像：

* muninn/caddy-microservice:app 这是我们上一节说的app镜像，我们将启动3个实例，测试上层的负载均衡。
* muninn/caddy-microservice:gateway 这是我们接下来要讲的gateway了，它监听2015端口并将请求转发给app。

## 用 caddy 当作 gateway

为了让caddy当作gateway，我们主要来看一下`Caddyfile`:

```
:2015 {
    proxy / app:12345
}
```

好吧，它太简单了。它监听本机的2015端口，将所有的请求都转发到 app:12345 。
这个app，其实是一个域名，在docker swarm的网络中，它会被解析到这个名字服务随机的一个实例。

将来如果有很多app，将不同的请求前缀转发到不同的app就好啦。
所以记得写规范的时候让一个app的endpoint前缀尽量用一样的。

然后caddy也需要被容器化，感兴趣的可以看看Dockerfile.gateway .

## 运行服务端

理解了上面的内容，就可以开始运行服务端了。直接用我上传到云端的镜像就可以。本文用到的三个镜像下载时总计26M左右，不大。
clone我背景章节提到的库进入项目目录，或者仅仅复制上文提到的compose文件存成`docker-compose.yml`，然后执行如下命令。

```shell
docker-compose pull
docker stack deploy -c docker-compose.yml caddy
```

啊，对了，第二个stack命令需要你已经将docker切到了swarm模式，如果没有会自动出来提示，根据提示切换即可。
如果成功了，我们检查下状态：

```shell
docker stack ps caddy
```

如果没问题，我们能看到已经启动了3个app和一个gateway。然后我们来测试这个gateway是否能将请求分配到三个后端。


## 测试

我们是可以通过访问`http://{your-host-ip}:2015`来测试服务是不是通的，用浏览器或者curl。
然后你会发现，怎么刷新内容都不变啊，并没有像想象中的那样会访问到随机的后端。

不要着急，这个现象并非因为caddy像nginx那样缓存了dns导致均衡失败，而是另一个原因。
caddy为了反向代理的速度，会和后端保持一个连接池。当只有一个客户端的时候，用到总是那第一个连接呢。
为了证明这一点，我们需要并发的访问我们的服务，再看看是否符合我们的预期。

同样的，测试我也为大家准备了镜像，可以直接通过docker使用。
```shell
docker run --rm -it muninn/caddy-microservice:client
```

感兴趣的人可以看client文件夹里的代码，它同时发起了30个请求，并且打印出了3个后端被命中的次数。

另外我还做了一个shell版本，只需要`sh test.sh`就可以，不过只能看输出拉，没有自动检查结果。

好了，现在我们可以知道，caddy可以很好的胜任微服务架构中的 API Gateway 了。

## API Gateway

什么？你说没看出来这是个 API Gateway 啊。我们前边只是解决了容器项目中 API Gateway 和DNS式服务发现配合的一个难题，
接下来就简单了啊，我们写n个app，每个app是一个微服务，在gateway中把不同的url路由到不同的app就好了啊。

## 进阶

`caddy`还可以轻松的顺便把认证中心做了，微服务建议用jwt做认证，将权限携带在token中，caddy稍微配置下就可以。
我后续也会给出教程和demo 。auth2.0我认为并不适合微服务架构，但依然是有个复杂的架构方案的，这个主题改天再说。

`caddy`还可以做`API状态监控`,`缓存`,`限流`等API gateway的职责，不过这些就要你进行一些开发了。
你还有什么更多的想法吗？欢迎留言。
