# llama-swap WoL proxy

This image builds the `wol-proxy` command from the pinned llama-swap release in
[metadata.yaml](./metadata.yaml). Renovate tracks later llama-swap releases.
The containerization approach was inspired by
[NuttySalmon/ls-wol-proxy-docker](https://github.com/NuttySalmon/ls-wol-proxy-docker).

The proxy listens on `:8080` by default. A request received while llama-swap is
unavailable sends a Wake-on-LAN packet and waits for the upstream to become
ready. `/status` reports the upstream status.

## Run

On a Linux host, host networking lets the proxy send the WoL broadcast onto the
local network:

```sh
docker run --rm --name llama-swap-wol-proxy \
  --network host \
  --env LLAMA_SWAP_API_KEY \
  --env LS_WOL_MAC=BA:DC:0F:FE:E0:00 \
  --env LS_WOL_UPSTREAM=http://192.168.1.13:8080 \
  ghcr.io/cbrherms/llama-swap-wol-proxy:v276
```

Set `LLAMA_SWAP_API_KEY` on the host if llama-swap uses API keys. The proxy uses
it as a bearer token when connecting to the upstream `/api/events` SSE endpoint.
Alternatively, pass `-api-key`; that flag takes precedence over the environment
variable. The key is not required when upstream authentication is disabled.

For Kubernetes, the connection and proxy options can be set as environment
variables instead of command arguments:

```yaml
env:
  - name: LS_WOL_MAC
    value: "BA:DC:0F:FE:E0:00"
  - name: LS_WOL_UPSTREAM
    value: "http://llama-swap:8080"
  - name: LS_WOL_LISTEN
    value: ":8080"
  - name: LS_WOL_LOG
    value: "info"
  - name: LS_WOL_TIMEOUT
    value: "60"
  - name: LS_WOL_REQUIRE_CONFIRM
    value: "false"
  - name: LLAMA_SWAP_API_KEY
    valueFrom:
      secretKeyRef:
        name: llama-swap
        key: api-key
```

`LS_WOL_MAC` and `LS_WOL_UPSTREAM` are required unless provided as command
arguments. The other `LS_WOL_*` variables are optional and default to the
upstream defaults below. Command arguments override their matching
`LS_WOL_*` values. Use a Kubernetes Secret for `LLAMA_SWAP_API_KEY`.

## Options

| Option | Environment variable | Default | Description |
| --- | --- | --- | --- |
| `-mac` | `LS_WOL_MAC` | required | MAC address of the machine to wake |
| `-upstream` | `LS_WOL_UPSTREAM` | required | Upstream llama-swap URL |
| `-listen` | `LS_WOL_LISTEN` | `:8080` | Address on which the proxy listens |
| `-log` | `LS_WOL_LOG` | `info` | Log level: `debug`, `info`, `warn`, or `error` |
| `-timeout` | `LS_WOL_TIMEOUT` | `60` | Seconds to wait for the upstream before failing a request |
| `-api-key` | `LLAMA_SWAP_API_KEY` | empty | Bearer key for the upstream SSE connection; the flag takes precedence |
| `-require-confirm` | `LS_WOL_REQUIRE_CONFIRM` | `false` | Require confirmation on the web page before waking the server; accepts `true` or `false` |

These are the upstream command-line options; configure them as arguments after
the image name. `/api/events` requests do not trigger a wake. With
`-require-confirm`, browser requests to `/` or `/ui/` show a confirmation page,
while other requests receive `503` until the user confirms.

## Wake-on-LAN networking

Wake-on-LAN must be enabled in the target machine's firmware and network
adapter. `wol-proxy` sends a UDP broadcast to port 9, so it needs a network path
that carries broadcasts onto the same LAN segment as the target. On Linux,
`--network host` is the straightforward Docker setup; bridge networking does
not normally forward the container's broadcast to the physical LAN. Allow UDP
port 9 broadcasts through any host or LAN firewall that filters them.

The proxy does not require `NET_ADMIN`, `NET_RAW`, or root. The image runs as
UID/GID `65532` and includes CA certificates for HTTPS upstreams.
