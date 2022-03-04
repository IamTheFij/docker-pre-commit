#! /usr/bin/env bash
# Verifies that files passed in are valid for docker-compose
set -e

if command -v docker-compose &> /dev/null ; then
    COMPOSE=docker-compose
elif command -v docker &> /dev/null && docker help compose &> /dev/null; then
    COMPOSE=docker compose
else
    echo "ERROR: Neither 'docker-compose' or 'docker compose' were found"
    exit 1
fi

check_file() {
    local file=$1
    env $COMPOSE --file "$file" config --quiet 2>&1 \
        | sed "/variable is not set. Defaulting/d"
    return "${PIPESTATUS[0]}"
}

check_files() {
    local all_files=( "$@" )
    has_error=0
    for file in "${all_files[@]}" ; do
        if [[ -f "$file" ]]; then
            if ! check_file "$file" ; then
                echo "ERROR: $file"
                has_error=1
            fi
        fi
    done
    return $has_error
}

if ! check_files "$@" ; then
    echo "Some compose files failed"
fi

exit $has_error
