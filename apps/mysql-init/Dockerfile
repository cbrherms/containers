FROM alpine:3.22@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

USER root

RUN \
    apk add --no-cache \
    bash \
    ca-certificates \
    catatonit \
    mysql-client~"${VERSION}" \
    mariadb-connector-c
# mariadb-connector-c is needed for caching_sha2_password plugin

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER nobody:nogroup

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
