#!/bin/sh
echo -ne '\033c\033]0;darkness\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/dark.x86_64" "$@"
