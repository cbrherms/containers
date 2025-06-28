FROM python:3.11 as builder

ARG VERSION

RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/cbrherms/plex-filler-tagger.git .
RUN git checkout "tags/${VERSION}" -b "build-${VERSION}"

RUN pip install --no-cache-dir -r requirements.txt


FROM python:3.11-slim

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV PYTHONUNBUFFERED=1 \
    IS_DOCKER=true

RUN addgroup --system app && adduser --system --ingroup app app

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /app/src ./src

RUN chown -R app:app /app
RUN mkdir -p /config && \
    chown -R app:app /config

USER app

CMD ["python", "-m", "src"]
