FROM --platform=$BUILDPLATFORM golang:1.27.4-alpine AS builder

ARG VERSION
ARG TARGETOS
ARG TARGETARCH

WORKDIR /src

RUN apk add --no-cache ca-certificates git

RUN git clone --depth 1 --branch "${VERSION}" https://github.com/mostlygeek/llama-swap.git .

RUN go test ./cmd/wol-proxy

RUN mkdir -p /out && \
    CGO_ENABLED=0 GOOS="${TARGETOS}" GOARCH="${TARGETARCH}" \
    go build -trimpath -ldflags="-s -w" -o /out/wol-proxy ./cmd/wol-proxy

FROM alpine:3.22

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /out/wol-proxy /wol-proxy
COPY --chmod=0755 entrypoint.sh /entrypoint.sh

USER 65532:65532

EXPOSE 8080/tcp
STOPSIGNAL SIGINT
ENTRYPOINT ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/mostlygeek/llama-swap"
