# MySQL initialization container

This image connects to an existing MySQL-compatible server and creates or
updates an application user, creates one or more databases, and grants that
user access. It is a one-shot initialization container; it does not run a
database server.

## Configuration

| Variable | Required | Default | Description |
| --- | --- | --- | --- |
| `INIT_MYSQL_HOST` | Yes | — | Hostname or address of the database server |
| `INIT_MYSQL_SUPER_PASS` | Yes | — | Password for the administrative database account |
| `INIT_MYSQL_SUPER_USER` | No | `root` | Administrative database account name |
| `INIT_MYSQL_USER` | Yes | — | Application account to create or update |
| `INIT_MYSQL_PASS` | Yes | — | Password for the application account |
| `INIT_MYSQL_DBNAME` | Yes | — | One database name or a space-separated list |
| `DISABLE_SSL_VERIFICATION` | No | `false` | Set to `true` to use the MariaDB client's `--skip-ssl` option |

The administrative account needs permission to manage users, databases, and
grants. The image attempts to create the application account for both
`localhost` and `%`, then grants it privileges on each listed database.

Use your platform's secret mechanism for both passwords. Keep SSL verification
enabled unless connecting to a server that cannot use TLS. Setting
`DISABLE_SSL_VERIFICATION=true` disables TLS entirely; it does not merely skip
certificate verification.

## Example

Run the image as a one-shot job with the database credentials supplied through
environment variables:

```sh
docker run --rm \
  --env INIT_MYSQL_HOST=mysql.example.net \
  --env INIT_MYSQL_SUPER_USER=root \
  --env INIT_MYSQL_SUPER_PASS \
  --env INIT_MYSQL_USER=app \
  --env INIT_MYSQL_PASS \
  --env INIT_MYSQL_DBNAME="appdb appdb_test" \
  ghcr.io/cbrherms/mysql-init:rolling
```

The container runs as `nobody:nogroup`; configure network access from the
container to the database server. For Kubernetes, use a Job and source the
password variables from a Secret.

Inspired by
[onedr0p/postgres-init](https://github.com/onedr0p/containers/tree/main/apps/postgres-init).
