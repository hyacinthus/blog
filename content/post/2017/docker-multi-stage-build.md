+++
date = "2017-04-14T13:12:49+08:00"
title = "Docker 重要更新: 原生支持多阶段构建(multi-stage build)"
tags = ["microservice","golang","docker"]
draft = false

+++
![Docker + alpine](https://static.crandom.com/tech/alpine.jpg)
Docker 的口号是 Build, Ship, and Run Any App, Anywhere.
但是我们在应用过程中会遇到一个问题，我们在 build 的时候，把源码也 build 进去了。
然后就继续把源码 Ship 出去吗？这可不行。所有的编译型语言都面临这个困扰。
即使是脚本型语言，build 的时候也会使用很多上线时用不到的构建工具，
而我们希望减小生产镜像的体积，这样我们的小鲸鱼才能多拉一点集装箱嘛。

## 传统做法

我们最终的目的是要将编译好的可执行文件复制到 `alpine` 这样的迷你镜像里，
那么该怎么弄到编译好的文件呢？基于 Docker 的思想，我们肯定需要在一个标准容器中编译，
这样这个过程才是标准化的，再说，你在 Ubuntu 编译出一个二进制文件在 alpine 也运行不了。

于是我们先需要准备一个编译用的自定义镜像。一般是用相应语言的 alpine 基础镜像，
把编译项目额外需要的各种工具打包进去，比如 golang 目前没有官方的包管理，
你就需要把你用的包管理工具装进去。

然后我们需要在运行 container 时把主机的一个目录通过 -v 挂载到 container上，
让它把编译的结果输出到这个挂载的目录，这样我们就在主机上拿到这个文件了。

最后，我们用一个最小的 `alpine` 镜像，把二进制文件复制进去。
可能你还需要设置一下时区之类的。

## 持续集成

上面的流程，在用持续集成工具时又变成了一个问题。你会发现每一家 CI 提供商都不太一样。
你未必有权限控制 CI 时的宿主机。

比如 `Docker Cloud`，你需要定义 pre-build 的 hook 去完成这个工作，
在 `SEMAPHORE`，你发现你有了一台宿主机，这下和我们在本地的做法可以一样了。
在更多的提供商，你会发现他们只是能根据 git 仓库和 Dockerfile 构建镜像，
你用他们的系统甚至没办法做出一个最小镜像……
中国的 `DaoCloud` 其实挺先进的，很早就推出了安全镜像的概念，让你的构建通过两步完成。
但是，那个配置的内容太多让不太懂的人看了直接晕掉。

## 官方方案

在2017年5月3日即将发行的 `Docker 17.05.0-ce` 中，Docker 官方提供了简便的多阶段构建
(multi-stage build) 方案。我用例子为大家介绍下：

```dockerfile
FROM muninn/glide:alpine AS build-env
ADD . /go/src/app
WORKDIR /go/src/app
RUN glide install
RUN go build -v -o /go/src/app/app-server

FROM alpine
RUN apk add -U tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
COPY --from=build-env /go/src/app/app-server /usr/local/bin/app-server
EXPOSE 80
CMD ["app-server"]
```

首先，第一个 `FROM` 后边多了个 `AS` 关键字，可以给这个阶段起个名字。
我举例子这个[镜像](https://github.com/hyacinthus/docker-glide/blob/master/Dockerfile.alpine)是官方
 golang:alpine 加上构建工具 glide ，我们照旧安装依赖， build 出一个二进制程序。

然后，第二部分用了官方的 `alpine` 镜像，改变时区到中国，新特性体现在 `COPY` 关键字，
它现在可以接受 `--from=` 这样的参数，从上个我们起名字的阶段复制文件过来。

就这么简单，现在你只需要一个 Dockerfile 就什么都搞定了。

## 多项目构建

于是现在你可以把好几个项目的二进制文件构建在一个迷你镜像中发布了，继续举个栗子：

```dockerfile
from debian as build-essential
arg APT_MIRROR
run apt-get update
run apt-get install -y make gcc
workdir /src

from build-essential as foo
copy src1 .
run make

from build-essential as bar
copy src2 .
run make

from alpine
copy --from=foo bin1 .
copy --from=bar bin2 .
cmd ...
```

这个就是把两个项目编译出来的文件最终合并到了一个镜像里。

好了，祝贺那些不支持多段构建的 CI 服务，Docker 帮你们追平了竞争对手。
我有机会会写一个支持 Docker 的 CI 的主观评论，也欢迎大家吐槽各路 CI 给我提供素材。
