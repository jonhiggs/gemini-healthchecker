# gemini-healthcheck

A lightweight tool to check that a set Gemini targets are online. Notification emails are sent to the site owner when a failure is detected.

The intent is to allow hosts serving Gemini content to easily check the health of themselves and each other. With at least two hosts checking that your content is online, you can be fairly sure you will be notified in the event of a failure.


## Features

- Only raises notifications after a few consecutive failures.
- Notifications are only sent by email.
- Check frequency is configurable per target.
- A generated gemtext page showing the status of all targets.


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

1. Generate the status page in a cronjob (`make content/index.gmi`
1. Serve `content/index.gmi`


