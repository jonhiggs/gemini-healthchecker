# gemini-healthcheck

A lightweight tool to check that Gemini targets are online and notify their owner when they aren't.

All targets are expected to respond with 20 within its timeout.

This tool does not, and will not do any of the following:

- Providing any any hint about why a request failed.
- Check targets on protocols other than Gemini.
- Perform certificate checks.
- Verifying page content.

When a failure is detected, it quickly checks a few more times to rule out a transient error, then sends a notification email to the site's owner.

## Status Page

A Gemtext page can be generated to show the status of all configured targets.

## Requirements

It's implemented as a shell script with a few dependencies.

- Redis server
- redis-cli
- jq
- gmni


## Setup

TODO

1. Add a user.
1. Checkout this repo.
1. Setup `etc/targets.json`.
1. Install the dependencies.
1. Setup a systemd service.

```
[Unit]
Description=Gemini Healthchecker

[Service]
Type=simple
ExecStart=/home/healthchecker/src/gemini-healthchecker/bin/check
Restart=on-failure
StandardOutput=file:/var/log/healthchecker/output

[Install]
WantedBy=default.target
```

1. Generate the status page in a cronjob (`make content/index.gmi`)
1. Serve `content/index.gmi`

