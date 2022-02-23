# gemini-healthcheck

A lightweight tool to check that Gemini targets are online and notify their owner when they aren't.

All targets are expected to respond with 20 within its timeout.

This tool does not, and will not do any of the following:

- Providing any any hint about why a request failed.
- Check targets on protocols other than Gemini.
- Perform certificate checks.
- Verify page content.

When a failure is detected, it quickly checks a few more times to rule out a transient error, then sends a notification email to the site's owner.


## Requirements

- [gemget](https://github.com/makeworld-the-better-one/gemget)


## Setup

You'll probably need to allow your user to linger processes: `loginctl enable-linger $USER`.

Then setup your crontab with something like this:

```
PATH=/path/to/gemini-healthchecker/bin:/usr/local/bin:/usr/bin:/bin
XDG_RUNTIME_DIR=/run/user/<your_user_id>

MAILTO="jon@shit.cx"
* * * * * check gemini://shit.cx/                   0.5 | msmtp-mailer

MAILTO="another_jon@shit.cx"
* * * * * check gemini://status.shit.cx/            0.5 | msmtp-mailer
```

There isn't really any reason to use msmtp-mailer if your server has a well configured MTA. If it doesn't, then it may be helpful.

If you want, you can also generate a status page with `bin/dump_status`.
