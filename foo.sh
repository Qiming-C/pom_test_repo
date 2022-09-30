#!/usr/bin/env bash

function fn() {
    if [[ "$1" =~ "baz" ]] ; then
        echo "Do something safe"
    else
        echo "Do something unsafe"
    fi
}

foo="bar baz"
fn "$foo"
