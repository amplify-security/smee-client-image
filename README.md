# `smee-client` Image

[![Amplify Security](https://github.com/amplify-security/smee-client-image/actions/workflows/amplify.yml/badge.svg?branch=main)](https://github.com/amplify-security/smee-client-image/actions/workflows/amplify.yml)
[![Release](https://github.com/amplify-security/smee-client-image/actions/workflows/release.yml/badge.svg?branch=main)](https://github.com/amplify-security/amplify-security/actions/workflows/release.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/amplifysecurity/smee-client?logo=docker)](https://hub.docker.com/r/amplifysecurity/smee-client)
[![Image Size](https://img.shields.io/docker/image-size/amplifysecurity/smee-client?logo=docker)](https://hub.docker.com/r/amplifysecurity/smee-client)

A minimal, secure docker image for [probot/smee-client](https://github.com/probot/smee-client). Currently, the
[`amplifysecurity/smee-client`](https://hub.docker.com/r/amplifysecurity/smee-client)
image size is under 93MB uncompressed.

## How to use this image

### Run `smee-client` using docker run

Running the image with no parameters will print the `smee-client` help message:

```
$ docker run --rm amplifysecurity/smee-client
Usage: smee [options]

Options:
  -v, --version          output the version number
  -u, --url <url>        URL of the webhook proxy service. Default:
                         https://smee.io/new
  -t, --target <target>  Full URL (including protocol and path) of the target
                         service the events will forwarded to. Default:
                         http://127.0.0.1:PORT/PATH
  -p, --port <n>         Local HTTP server port (default: 3000)
  -P, --path <path>      URL path to post proxied requests to` (default: "/")
  -h, --help             display help for command
```

Use the `-u` and `-t` parameters to connect to your [Smee.io](https://smee.io/) channel and forward
events to your local target.

```
$ docker run --rm amplifysecurity/smee-client -u $SMEE_URL -t http://localhost:8080/webhook
Forwarding https://smee.io/******** to http://localhost:8080/webhook
Connected https://smee.io/********
```

### Run `smee-client` using docker compose

To use the image in docker compose, ensure that the smee service is linked to your receiving service.
This image also specifies a non-root user (UID 1000) and so can be run with `no-new-privileges:true`.

```yaml
services:
  smee:
    image: amplifysecurity/smee-client
    links:
      - api:api
    command: -u https://smee.io/******** -t http://api:8080/webhook
    security_opt:
      - no-new-privileges:true
  api:
    build:
      context: .
    ports:
      - "8080:8080"
```

## Inspiration

This project was inspired by [deltaprojects/smee-client-docker](https://github.com/deltaprojects/smee-client-docker),
which we have used in the past. However, this project was seemingly no longer maintained, and included several high-severity
security issues. We plan to maintain this image by keeping up to date with upstream `smee-client` releases and security
patches.
