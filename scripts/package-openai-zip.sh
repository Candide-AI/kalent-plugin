#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
out="${1:-"$root/dist/kalent-plugin.zip"}"
mkdir -p "$(dirname "$out")"
rm -f "$out"
(
  cd "$root"
  zip -r "$out" . \
    -x './.git/*' \
    -x './.git/***' \
    -x './dist/*' \
    -x './dist/***' \
    -x '*.zip'
)
zipinfo -1 "$out" | grep -qx 'plugin.json'
zipinfo -1 "$out" | grep -qx 'assets/logo.png'
zipinfo -1 "$out" | grep -qx 'mcp.json'
echo "$out"
