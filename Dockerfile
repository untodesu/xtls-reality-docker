FROM alpine:latest
LABEL mantainer="myelectronix"

ARG XRAY_CORE_VERSION=latest
ENV SNI=www.samsung.com
ENV SHORT_ID=aabbccdd

RUN set -e &&\
    apk add --no-cache bash libqrencode curl &&\
    wget https://github.com/XTLS/Xray-core/releases/${XRAY_CORE_VERSION}/download/Xray-linux-64.zip &&\
    mkdir /opt/xray &&\
    mkdir /opt/xray/config &&\
    unzip ./Xray-linux-64.zip -d /opt/xray  &&\
    rm -rf Xray-linux-64.zip

WORKDIR /opt/xray

COPY config.json config/config.json
COPY get-client-qr.sh .
COPY get-client-settings.sh .
COPY regenerate-client-settings.sh .
COPY entrypoint.sh .

EXPOSE 443
ENTRYPOINT [ "/bin/bash","./entrypoint.sh" ]
