+++
date = "2017-10-15T21:12:49+08:00"
title = "使用 Caddy 制作前端 Docker 镜像"
tags = ["microservice","javascript","docker","caddy"]
draft = false

+++

## 简介

今年夏天又开始新的创业项目，忙得没日没夜，好久没写博客了。
但是也许 Docker 越来越火，知乎的专栏每天都有新的人关注，不抽空写点太对不起大家。
之前写过 API 镜像，今天来说说前端镜像。
本文适用于任何一个需要编译的前端框架，我们利用 Docker 的两段构建，用一个 Dockerfile 一气呵成的产出不含源码的生产镜像。
镜像内用了 Caddy 当作服务器，又经过了半年的发展，虽然版本还没到1，但 Caddy 已经足够强大和健壮了。

## Caddyfile

为了能让项目在 Caddy 镜像中被访问，我们在项目根目录建一个叫 Caddyfile 的文件，供后续镜像内启动服务时使用。

```Caddyfile
0.0.0.0:80
root /www
gzip
log stdout
errors stdout
```

解释一下，我们未来会把编译好的项目放在容器的 /www 目录。
服务器在容器的80端口。启用gzip，并且将日志输出在stdout--这是 Docker 的推荐做法。

## Dockerfile

然后就开始我们的二段构建了:

```Dockerfile
# build
FROM node:8 as builder

ADD . /src

WORKDIR /src

RUN npm i && npm run build

# product
FROM abiosoft/caddy

COPY --from=builder /src/dist /www

COPY Caddyfile /etc/Caddyfile
```

我们首先使用 node 的官方镜像对项目进行编译，工作目录为 /src ，编译结果为 /src/dist 。
然后我们再将 dist 文件夹复制为 caddy 镜像的 /www 目录。
最后我们将我们的 Caddyfile 覆盖镜像原版的。

值得一提的是，我们使用的 abiosoft/caddy 这个镜像并非官方版本，但是比较活跃，感兴趣也可以去看源码。

## 使用镜像

如果一台物理机只准备使用这一个镜像，那么我们之前的 Caddyfile 不应该限定80端口，并且应该指定域名，以此来使用 Caddy 的自动 HTTPS 特性。
做了如此修改后将镜像启动时绑定80和443端口就好。

但是大部分时候，我们只是让镜像的80端口映射在主机的某个端口，主机上还有一层 Web 服务器。就不再罗嗦这里应该怎么配置了。
