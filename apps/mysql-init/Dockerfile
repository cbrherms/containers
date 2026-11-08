FROM alpine:3.24@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

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
