FROM alpine:3.21@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN apk add --no-cache ca-certificates mysql-client=${VERSION} mariadb-connector-c bash
# mariadb-connector-c is needed for caching_sha2_password plugin

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
