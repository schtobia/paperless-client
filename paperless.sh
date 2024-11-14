#! /bin/sh
# SPDX-FileCopyrightText: 2024 Tobias Schmidl
#
# SPDX-License-Identifier: AGPL-3.0-or-later

load_env () {
    [ ! -r "./.env" ] && { echo "env file not readable, please make sure a .env is present." >&2; exit 1; }
    . "./.env"
    [ -z "$TOKEN" ] && { echo "Parameter TOKEN is not present in env file, please fill it with a valid paperless API token." >&2; exit 1; }
    [ -z "$BASE_URL" ] && { echo "Parameter BASE_URL is not present in env file, please fill it with the URL of your paperless server." >&2; exit 1; }
}

print_usage () {
    cat << END_OF_COMMENT
    $(basename "$0") get_tasks | put_document <file>

    commands:
        get_tasks       Get the list of tasks. This is not formatted, i.e. you'll
                        have to pipe it yourself through a formatter.
        put_document    Uploads the document under <file> to your paperless
                        instance.

    return values:
        If everything went alright, $(basename "$0") returns 0. Every other return
        value indicates an error.

END_OF_COMMENT
}

AUTH_PARM="Authorization: Token $TOKEN"

case "$1" in
    get_tasks)
        load_env
        curl -H "$AUTH_PARM" "${BASE_URL}/api/tasks/"
    ;;
    put_document)
        load_env
        [ ! -r "$2" ] && { echo "file not readable." >&2; exit 1; }
        curl -H "$AUTH_PARM" -X "POST" "${BASE_URL}/api/documents/post_document/" -H 'Accept: application/json' --form "document=@${2}"
    ;;
    *)
        print_usage
        exit 1
    ;;
esac
