# Kometa container

For Kometa configuration and usage, see the
[official documentation](https://kometa.wiki/en/latest/).

This image is based on the version of `kometateam/kometa` selected in
[metadata.yaml](./metadata.yaml). Its container-specific additions are:

- The 1Password CLI (`op`) is installed at `/usr/local/bin/op`. Its build
  version can be set with `OP_CLI_VERSION`.
- PyYAML is installed for Python.
- The image runs as user `kometa` (UID/GID 1000), with `/config` as its home
  directory.

The image keeps the upstream Kometa entrypoint and command behavior. Follow
Kometa's documentation for its configuration files, integrations, and Docker
usage; mount configuration and other persistent files where the upstream guide
expects them.
