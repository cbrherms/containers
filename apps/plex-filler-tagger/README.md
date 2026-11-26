# Plex Filler Tagger container

For application configuration, environment variables, and behavior, see the
[upstream Plex Filler Tagger documentation](https://github.com/cbrherms/plex-filler-tagger#readme).

This image builds the upstream release selected in
[metadata.yaml](./metadata.yaml), uses Python 3.13, and runs `python -m src` as
the unprivileged `app` user. It sets `IS_DOCKER=true`, so the application's
default configuration path is `/config/config.yaml`.

Mount your configuration file at that path, or set `CONFIG_PATH` to another
path inside the container. Store Plex and Sonarr API keys in container secrets,
and ensure the `app` user can read the mounted configuration. The image does
not change the application's documented environment variables or processing
behavior.
