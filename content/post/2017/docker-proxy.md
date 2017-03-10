
+++
date = "2017-03-09T20:30:13+08:00"
title = "为 Docker 设置代理"
tags = ["docker","gfw","systemd"]
draft = true

+++

因为众所周知的原因，Docker在国内的使用举步维艰。于是，很多组织在国内提供了`mirror`或者叫`加速器`。
甚至在1.13的release note中提到微软提供了官方的中国镜像，然后我并没有找到怎么启用，找到了再写。

使用这些镜像或者加速器，拉取各种官方镜像是ok了，自有的镜像也可以放在国内的`registry`。
但是官方镜像只是沧海一粟，大量的组织或个人的镜像都在`docker hub`，这一部分并没有被镜像同步。
于是，你还是需要一个代理。

本文假设：
* 你已经有一个http代理了
* Linux发行版使用的是systemd
* 本文写于 Version 17.03.0-ce , 在 Docker 1.13 和 17.03 上是可以的，不排除将来有所改变

顺带说一句，Windows版的在 Settings 的图形界面上直接可以设置代理。

## 关于systemd

很多人可能对systemd还不熟悉，但主流发行版已经全都切换成systemd了，还是得了解一下。
```bash
# 重启docker
$ sudo systemctl restart docker
# 对应的旧的命令，其实现在还是支持，效果和上一句一样。
$ sudo service docker restart
# 设置开机启动
$ sudo systemctl enable docker
```

`systemd`是由一个在`/lib/systemd/system/docker.service`
The recommended way is to use a systemd drop-in file documentation). These are local files named `<something>.conf` in the
`/etc/systemd/system/docker.service.d` directory.

However, if you had previously used a package which had an `EnvironmentFile`
(often pointing to `/etc/sysconfig/docker`) then for backwards compatibility,
you drop a file with a `.conf` extension into the
`/etc/systemd/system/docker.service.d` directory including the following:

```conf
[Service]
EnvironmentFile=-/etc/sysconfig/docker
EnvironmentFile=-/etc/sysconfig/docker-storage
EnvironmentFile=-/etc/sysconfig/docker-network
ExecStart=
ExecStart=/usr/bin/dockerd $OPTIONS \
          $DOCKER_STORAGE_OPTIONS \
          $DOCKER_NETWORK_OPTIONS \
          $BLOCK_REGISTRY \
          $INSECURE_REGISTRY
```

To check if the `docker.service` uses an `EnvironmentFile`:

```bash
$ systemctl show docker | grep EnvironmentFile

EnvironmentFile=-/etc/sysconfig/docker (ignore_errors=yes)
```

Alternatively, find out where the service file is located:

```bash
$ systemctl show --property=FragmentPath docker

FragmentPath=/usr/lib/systemd/system/docker.service

$ grep EnvironmentFile /usr/lib/systemd/system/docker.service

EnvironmentFile=-/etc/sysconfig/docker
```

You can customize the Docker daemon options using override files as explained in
the [HTTP Proxy example](systemd.md#http-proxy) below. The files located in
`/usr/lib/systemd/system` or `/lib/systemd/system` contain the default options
and should not be edited.

### HTTP proxy

This example overrides the default `docker.service` file.

If you are behind an HTTP proxy server, for example in corporate settings,
you will need to add this configuration in the Docker systemd service file.

1.  Create a systemd drop-in directory for the docker service:

    ```bash
    $ mkdir -p /etc/systemd/system/docker.service.d
    ```

2.  Create a file called `/etc/systemd/system/docker.service.d/http-proxy.conf`
    that adds the `HTTP_PROXY` environment variable:

    ```conf
    [Service]
    Environment="HTTP_PROXY=http://proxy.example.com:80/"
    ```

3.  If you have internal Docker registries that you need to contact without
    proxying you can specify them via the `NO_PROXY` environment variable:

    ```conf
    Environment="HTTP_PROXY=http://proxy.example.com:80/" "NO_PROXY=localhost,127.0.0.1,docker-registry.somecorporation.com"
    ```

4.  Flush changes:

    ```bash
    $ sudo systemctl daemon-reload
    ```

5.  Verify that the configuration has been loaded:

    ```bash
    $ systemctl show --property=Environment docker
    Environment=HTTP_PROXY=http://proxy.example.com:80/
    ```
6.  Restart Docker:

    ```bash
    $ sudo systemctl restart docker
    ```
