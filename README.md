<!--
SPDX-FileCopyrightText: 2024 Tobias Schmidl

SPDX-License-Identifier: AGPL-3.0-or-later
-->

# paperless-client

![pre-commit enabled](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)

This simple client is a wrapper around the paperless-ng API. It allows you to
upload documents to your paperless-ng instance. By design it doesn't use
anything besides curl, so that it can be used in a wide range of environments,
like Alpine Linux or OpenWRT.

## Installation

```text
curl -ROLf1 https://git.schmidl.dev/schtobia/paperless-client/raw/branch/master/paperless.sh
chmod +x paperless.sh
echo BASEURL=<your paperless-ng instance> > .env
echo TOKEN=<your paperless-ng token> >> .env
```

## Usage

```text
paperless.sh get_tasks | put_document <file>

commands:
    get_tasks       Get the list of tasks. This is not formatted, i.e. you'll
                    have to pipe it yourself through a formatter.
    put_document    Uploads the document under <file> to your paperless
                    instance.

return values:
    If everything went alright, paperless.sh returns 0. Every other return
    value indicates an error.
```
