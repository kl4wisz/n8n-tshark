FROM alpine:latest AS alpine
FROM n8nio/n8n:2.44.7

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY
ENV HTTP_PROXY=$HTTP_PROXY \
    HTTPS_PROXY=$HTTPS_PROXY \
    http_proxy=$HTTP_PROXY \
    https_proxy=$HTTPS_PROXY \
    NO_PROXY=$NO_PROXY \
    no_proxy=$NO_PROXY

# Copy apk and its deps from Alpine
COPY --from=alpine /sbin/apk /sbin/apk
COPY --from=alpine /usr/lib/libapk.so* /usr/lib/

USER root
RUN apk update \
 && apk add --no-cache ca-certificates tshark curl \
 && update-ca-certificates \
 && rm -rf /var/cache/apk/*
USER node
