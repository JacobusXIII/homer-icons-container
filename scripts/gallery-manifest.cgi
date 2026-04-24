#!/bin/sh
set -eu

printf 'Status: 200 OK\r\n'
printf 'Content-Type: application/json; charset=utf-8\r\n'
printf 'Cache-Control: no-store\r\n'
printf '\r\n'

if upstream_git_version="$(cd /repo && git rev-parse --short=12 HEAD 2>/dev/null)"; then
  :
else
  upstream_git_version="unknown"
fi

if [ -f /etc/homer-icons-container-version ]; then
  container_version="$(sed -n '1p' /etc/homer-icons-container-version)"
else
  container_version="unknown"
fi

base_url="${BASE_URL:-}"

printf '{'
printf '"generated_at":"%s",' "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
printf '"upstream_git_version":"%s",' "$(printf '%s' "$upstream_git_version" | sed 's/\\/\\\\/g; s/"/\\"/g')"
printf '"container_version":"%s",' "$(printf '%s' "$container_version" | sed 's/\\/\\\\/g; s/"/\\"/g')"
printf '"base_url":"%s",' "$(printf '%s' "$base_url" | sed 's/\\/\\\\/g; s/"/\\"/g')"
printf '"icons":['

first=1
find /repo/png /repo/svg -type f \( -name '*.png' -o -name '*.svg' \) -print | LC_ALL=C sort | while IFS= read -r abs; do
  rel="${abs#/repo/}"
  if [ "$first" -eq 1 ]; then
    first=0
  else
    printf ','
  fi
  esc=$(printf '%s' "$rel" | sed 's/\\/\\\\/g; s/"/\\"/g')
  printf '"%s"' "$esc"
done

printf ']}'
