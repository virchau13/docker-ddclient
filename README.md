# docker-ddclient

This is a Dockerfile for [DDClient](https://github.com/ddclient/ddclient) using the `develop` branch.

## How to use
Mount your `ddclient.conf` into `/etc/ddclient/`, for example with `docker-compose`:
```yaml
services:
  ddclient:
    image: virchau13/docker-ddclient:latest
    container_name: ddclient
    volumes:
      - /path/to/ddclient.conf:/etc/ddclient/ddclient.conf
    restart: unless-stopped
```

## Why?

At the time of writing, DDClient hasn't had an official release since 8 Jan 2020 (v3.9.1).
However, several things have been added to DDClient since that date that may be useful.
For example, Cloudflare token support is present in DDClient/develop but not in v3.9.1.

The most well-known Dockerfile for DDClient is [LinuxServer.io's](https://github.com/linuxserver/docker-ddclient), 
which uses the latest release of DDClient, _not_ the development version. 
See [this open issue on that repository](https://github.com/linuxserver/docker-ddclient/issues/45).
This Dockerfile was greatly inspired by theirs.

This Dockerfile simply uses the `develop` branch.
