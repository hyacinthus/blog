
+++
date = "2017-03-10T20:30:13+08:00"
title = "为 Docker 设置代理"
tags = ["docker","gfw","systemd"]
comments = true

+++

因为众所周知的原因，Docker在国内的使用举步维艰。于是，很多组织在国内提供了`mirror`或者叫`加速器`。
甚至在1.13的release note中提到微软提供了官方的中国镜像，然后我并没有找到怎么启用，找到了再写。

使用这些镜像或者加速器，拉取各种官方镜像是ok了，自有的镜像也可以放在国内的`registry`。
但是官方镜像只是沧海一粟，大量的组织或个人的镜像都在`docker hub`，这一部分并没有被镜像同步。
于是，你还是需要一个代理。

本文假设：
* 你已经有一个http代理了
* Linux发行版的服务管理器使用的是systemd
* 本文写于 Version 17.03.0-ce , 在 Docker 1.13 和 17.03 上是可以的，不排除将来有所改变

顺带说一句，Windows版的在 Settings 的图形界面上直接可以设置代理。

## 关于systemd

很多人可能对systemd还不熟悉，但主流发行版已经全都切换成systemd了，还是很有必要了解一下。
```bash
# 重启docker
$ sudo systemctl restart docker
# 对应的旧的命令，其实现在还是支持，效果和上一句一样。
$ sudo service docker restart
# 设置开机启动
$ sudo systemctl enable docker
```

`systemd`是由文件夹`/lib/systemd/system`中的`docker.service`文件定义的。
我们随便搜索一下systemd教程，就知道怎么样自己编写一个service文件了。
于是你可能跃跃欲试，把这个文件改一改，代理加进去就好了嘛。

等等，不要着急，如果你自己在做一个自己的服务，当然是要自己直接写这个文件了。但是，我们的docker是从官方源安装的。
这意味着你现在改了这个文件虽然会生效，但是docker一升级，这个文件又被覆盖了呢。针对这个问题，systemd当然也有解决方案。

你其实只需要创造一个叫 `<something>.conf` 的配置文件，名字随便起，放在
`/etc/systemd/system/docker.service.d` 目录。你就覆盖了默认的启动配置，并且它会作为你的用户配置一直存在。


### HTTP proxy

好了，现在我们可以开始加代理配置了。

1.  默认情况下这个配置文件夹并不存在，我们要创建它。

    ```bash
    $ mkdir -p /etc/systemd/system/docker.service.d
    ```

2.  创建一个文件 `/etc/systemd/system/docker.service.d/http-proxy.conf`
    包含 `HTTP_PROXY` 环境变量:

    ```conf
    [Service]
    Environment="HTTP_PROXY=http://proxy.example.com:80/"
    ```

3.  如果有局域网或者国内的registry，我们还需要使用 `NO_PROXY` 变量声明一下，比如你可以能国内的daocloud.io放有镜像:

    ```conf
    Environment="HTTP_PROXY=http://proxy.example.com:80/" "NO_PROXY=localhost,127.0.0.1,daocloud.io"
    ```

4.  刷新systemd配置:

    ```bash
    $ sudo systemctl daemon-reload
    ```

5.  用系统命令验证环境变量加上去没:

    ```bash
    $ systemctl show --property=Environment docker
    Environment=HTTP_PROXY=http://proxy.example.com:80/
    ```
6.  万事俱备，重启docker，在外面的世界遨游吧:

    ```bash
    $ sudo systemctl restart docker
    ```

ps. 本文只是对官方文档的翻译和简化，希望大家还是学会活用google，检索官方文档，比看博客更有时效性。