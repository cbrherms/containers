ARG VERSION
FROM kometateam/kometa:${VERSION}

ARG TARGETPLATFORM
ARG TARGETARCH

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir pyyaml

ARG OP_CLI_VERSION=2.23.0
RUN echo "Downloading 1Password CLI v${OP_CLI_VERSION} for architecture ${TARGETARCH}" && \
    curl -sSLo /tmp/op.zip "https://cache.agilebits.com/dist/1P/op2/pkg/v${OP_CLI_VERSION}/op_linux_${TARGETARCH}_v${OP_CLI_VERSION}.zip" && \
    unzip -o /tmp/op.zip op -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/op && \
    rm -f /tmp/op.zip

USER nobody:nogroup

LABEL org.opencontainers.image.source="https://github.com/kometateam/kometa"
