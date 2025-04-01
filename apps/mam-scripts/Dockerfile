FROM alpine:3.21

ARG TARGETPLATFORM
ARG VERSION

ENV UMASK="0002" \
    TZ="Etc/UTC"

USER root
WORKDIR /app

RUN apk add --no-cache \
        bash \
        bc \
        catatonit \
        coreutils \
        curl \
        findutils \
        jq \
        trurl \
        tzdata \
    && \
    apk add --no-cache --virtual=.build-deps \
        git \
    && \
    git clone --single-branch --branch "${VERSION}" https://github.com/cbrherms/MAM-Scripts.git . \
    && \
    chown -R root:root /app && chmod -R 755 /app \
    && apk del --purge .build-deps \
    && rm -rf /root/.cache /root/.cargo /tmp/*

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER nobody:nogroup
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/cbrherms/MAM-Scripts"
