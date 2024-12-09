FROM alpine:3.21@sha256:21dc6063fd678b478f57c0e13f47560d0ea4eeba26dfc947b2a4f81f686b9f45

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN apk add --no-cache ca-certificates mysql-client=${VERSION} mariadb-connector-c bash

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
