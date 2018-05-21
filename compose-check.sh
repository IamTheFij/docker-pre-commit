#! /bin/bash
# Verifies that files passed in are valid for docker-compose
set -e

check_file() {
    local file=$1
    docker-compose -f "$file" config -q 2>&1 \
        | sed "/variable is not set. Defaulting/d"
    return ${PIPESTATUS[0]}
}

check_files() {
    local all_files=$@
    has_error=0
    for file in $all_files ; do
        if [[ -f "$file" ]]; then
            if ! check_file "$file" ; then
                has_error=1
            fi
        fi
    done
    return $has_error
}

if ! check_files $@ ; then
    echo "To ignore, use --no-verify"
fi

exit $has_error
