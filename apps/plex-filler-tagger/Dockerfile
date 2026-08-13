# renovate: datasource=docker depName=python
ARG BASE_PYTHON_VERSION=3.14
FROM python:${BASE_PYTHON_VERSION} as builder

ARG VERSION

RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/cbrherms/plex-filler-tagger.git .
RUN git checkout "tags/${VERSION}" -b "build-${VERSION}"

RUN pip install --no-cache-dir -r requirements.txt


FROM python:${BASE_PYTHON_VERSION}-slim

ARG BASE_PYTHON_VERSION
ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV PYTHONUNBUFFERED=1 \
    IS_DOCKER=true

RUN addgroup --system app && adduser --system --ingroup app app

WORKDIR /app

COPY --from=builder /usr/local/lib/python${BASE_PYTHON_VERSION}/site-packages /usr/local/lib/python${BASE_PYTHON_VERSION}/site-packages
COPY --from=builder /app/src ./src

RUN chown -R app:app /app
RUN mkdir -p /config && \
    chown -R app:app /config

USER app

CMD ["python", "-m", "src"]
