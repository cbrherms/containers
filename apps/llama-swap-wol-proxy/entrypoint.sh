#!/bin/sh
set -eu

if [ -n "${LS_WOL_MAC:-}" ]; then
    set -- -mac "$LS_WOL_MAC" "$@"
fi

if [ -n "${LS_WOL_UPSTREAM:-}" ]; then
    set -- -upstream "$LS_WOL_UPSTREAM" "$@"
fi

if [ -n "${LS_WOL_LISTEN:-}" ]; then
    set -- -listen "$LS_WOL_LISTEN" "$@"
fi

if [ -n "${LS_WOL_LOG:-}" ]; then
    set -- -log "$LS_WOL_LOG" "$@"
fi

if [ -n "${LS_WOL_TIMEOUT:-}" ]; then
    set -- -timeout "$LS_WOL_TIMEOUT" "$@"
fi

case "${LS_WOL_REQUIRE_CONFIRM:-false}" in
    1|true|TRUE|yes|YES|on|ON)
        set -- -require-confirm "$@"
        ;;
    0|false|FALSE|no|NO|off|OFF|"")
        ;;
    *)
        printf '%s\n' "LS_WOL_REQUIRE_CONFIRM must be true or false" >&2
        exit 2
        ;;
esac

exec /wol-proxy "$@"
