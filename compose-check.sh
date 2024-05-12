#! /usr/bin/env bash
# Verifies that files passed in are valid for docker-compose
set -e

# Check if docker or podman commands are available
if [[ -z "${CONTAINER_ENGINE}" ]]; then
    if command -v docker &>/dev/null; then
        CONTAINER_ENGINE=docker
    elif command -v podman &>/dev/null; then
        CONTAINER_ENGINE=podman
    else
        echo "ERROR: Neither 'docker' or 'podman' were found"
        exit 1
    fi
fi

if command -v "${CONTAINER_ENGINE}" &>/dev/null && ${CONTAINER_ENGINE} help compose &> /dev/null; then
    COMPOSE="${CONTAINER_ENGINE} compose"
elif command -v "${CONTAINER_ENGINE}-compose" &> /dev/null; then
    COMPOSE="${CONTAINER_ENGINE}-compose"
else
    echo "ERROR: Neither '${CONTAINER_ENGINE}-compose' or '${CONTAINER_ENGINE} compose' were found"
    exit 1
fi

check_file() {
    local file=$1
    env $COMPOSE --file "$file" config --quiet 2>&1 |
        sed "/variable is not set. Defaulting/d"
    return "${PIPESTATUS[0]}"
}

check_files() {
    local all_files=( "$@" )
    has_error=0
    for file in "${all_files[@]}"; do
        if [[ -f "$file" ]]; then
            if ! check_file "$file"; then
                echo "ERROR: $file"
                has_error=1
            fi
        fi
    done
    return $has_error
}

if ! check_files "$@"; then
    echo "Some compose files failed"
fi

exit $has_error
