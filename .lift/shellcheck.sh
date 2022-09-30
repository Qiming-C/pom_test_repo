#!/bin/bash

cmd=$3

if [[ "$cmd" = "run" ]] ; then
    if [[ -f '.shellcheck.env' ]] ; then
        source '.shellcheck.env'
    fi
    find . -type f -iname '*.sh' -print0 2>/dev/null | xargs -0 -I {} -P "$(nproc)"  bash -c "shellcheck -f diff \"{}\" | git apply -p2 --ignore-whitespace --reject --whitespace=warn >/dev/null"
    git commit . -m 'Apply shellcheck suggestions' 1>&2

    if [[ ! ( "[]" = "$jsonout" ) ]] ; then
        echo "{ \"tool_notes\" : [], \
                \"warnings\" : [], \
                \"pull_request\" : { \"title\"  : \"Fix ShellCheck Issues\", \"body\" : \"These issues were discovered by ShellCheck\", \"source_commit\" : \"$(git rev-parse HEAD)\" } }"
    else
        echo "{ \"tool_notes\" : [], \"warnings\" : [] }"
    fi
fi

if [[ "$cmd" = "name" ]] ; then
    echo "Shellcheck"
fi

if [[ "$cmd" = "applicable" ]] ; then
    files=$(find . -name '*.sh')
    if [[ -z "$files" ]] ; then
        echo "false"
    else
        echo "true"
    fi
fi

if [[ "$cmd" = "version" ]] ; then
    echo "5"
fi
