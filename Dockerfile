FROM alpine:3.20.1

LABEL author="jios<jioswu@vip.qq.com>" describe="webx-clash-ui"

WORKDIR /opt/clash

VOLUME ["/opt/clash/config"]

#COPY res/dbip-country-lite-2024-08.mmdb /opt/clash/config/Country.mmdb
COPY bin/clash-linux-v1.18.0 /opt/clash/
COPY web/yacd /opt/clash/ui

# 确保可执行文件具有执行权限
RUN chmod +x /opt/clash/clash-linux-v1.18.0

ENTRYPOINT ["/opt/clash/clash-linux-v1.18.0", "-d", "/opt/clash/config"]

#docker build -t jios/clash-ui:1.0.1 .