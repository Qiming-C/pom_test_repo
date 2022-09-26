#!/usr/bin/env bash

if [[ "$3" == "name" ]] ; then
    echo "pr-test"
    exit 0
fi

if [[ "$3" == "applicable" ]] ; then
    echo true
    exit 0
fi

if [[ "$3" == "version" ]] ; then
    echo 5
    exit 0
fi

if [[ "$3" == "run" ]] ; then
    echo "This is some new contents for some file.\n" >> the_new_file
    # branch=$(git rev-parse --abbrev-ref HEAD)
    branch=LIFT-4445
    git add the_new_file 1>&2
    git commit -m 'New commit message' 1>&2
    echo "{\"warnings\" : [], \"tool_notes\" : [], \"pull_request\" : { \"title\" : \"PR from a V5 tool\", \"body\" : \"foo bar baz\", \"source_commit\" : \"$(git rev-parse HEAD)\", \"target_branch\" : \"${branch}\" }}"
fi