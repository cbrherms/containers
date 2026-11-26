# MAM-Scripts container

For each script's purpose and environment-variable configuration, see the
[MAM-Scripts documentation](https://github.com/cbrherms/MAM-Scripts#readme).

This image adds a small container entrypoint around those scripts:

- Set `SCRIPT_NAME` to the script filename, such as `autodl.sh`,
  `autospend.sh`, or `seedbox-api.sh`.
- Additional arguments supplied to the container are passed to that script.
- The container runs as `nobody:nogroup` and exposes `/config` as a volume.
- `UMASK` defaults to `0002`; `TZ` defaults to `Etc/UTC`.

For example:

```sh
docker run --rm \
  --env SCRIPT_NAME=autospend.sh \
  --env MAM_ID \
  --env POINTS_BUFFER=10000 \
  --volume /path/to/data:/config \
  ghcr.io/cbrherms/mam-scripts:rolling
```

Provide credentials such as `MAM_ID` through your container platform's secret
mechanism. The image includes Bash and the command-line tools used by the
upstream scripts; it does not add another configuration format or change their
environment-variable behavior.
