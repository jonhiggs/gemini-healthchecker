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

- openssl


## Setup

TODO

Run the script in your crontab.

