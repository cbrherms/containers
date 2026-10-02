FROM alpine:3.22@sha256:5291449c3df73caf6ed85e649dec1b9e818b39a5d8c871e97afc13e9cd5e8fa8

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
