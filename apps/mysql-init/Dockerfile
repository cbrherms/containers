FROM alpine:3.22@sha256:8a1f59ffb675680d47db6337b49d22281a139e9d709335b492be023728e11715

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

RUN apk add --no-cache ca-certificates mysql-client=${VERSION} mariadb-connector-c bash
# mariadb-connector-c is needed for caching_sha2_password plugin

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
