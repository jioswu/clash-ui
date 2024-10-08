# 在Linux服务器上使用clash的方案

基于Dockerfile搭建clash+webui 解决docker被墙后无法更新和拉取镜像 config请从本地使用的配置文件复制过去,主要添加 external-ui: /opt/clash/ui 用来指定webui的路径

```config.yaml
mode: rule
mixed-port: 7890
allow-lan: true
log-level: info
external-controller: :9097
external-ui: /opt/clash/ui
secret: ''
```

## 编译镜像
```
docker build -t jios/clash-ui:1.0.1 .
```
## 导出镜像
```
docker save jios/clash-ui:1.0.1 | gzip > clash-ui.tar.gz
```
## 导入镜像
```
gunzip -c clash-ui.tar.gz | docker load
```
## 创建网络
```
docker network create my_network
```


## 本地测试用
```
docker run --name=clash-ui --network my_network \
-p 5890:9097 -p 57890:7890 \
-v ~/jdata/docker-data/clash-ui/config:/opt/clash/config \
-d jios/clash-ui:1.0.1
```

## 远程服务器使用方法
```
docker run --name=clash-ui --network my_network \
-p 5890:9097 -p 57890:7890 \
-v /jdata/docker-program/clash-ui/config:/opt/clash/config \
-d jios/clash-ui:1.0.1
```

## 通过 http://127.0.0.1:57890/ui 访问ui界面

## 代理启用
```
export https_proxy=http://127.0.0.1:57890 http_proxy=http://127.0.0.1:57890 all_proxy=socks5://127.0.0.1:57890
```
