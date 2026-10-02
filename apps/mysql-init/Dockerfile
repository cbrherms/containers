FROM alpine:3.24@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

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
