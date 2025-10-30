#!/bin/bash

pids=()

cleanup() {
    for pid in "${pids[@]}"; do
        if kill -0 "$pid" 2>/dev/null; then
            kill "$pid"
        fi
    done
    exit 1
}

trap cleanup SIGINT SIGTERM

sxhkd &
pids+=($!)
xeyesee &
pids+=($!)
nbb &
pids+=($!)

wait
