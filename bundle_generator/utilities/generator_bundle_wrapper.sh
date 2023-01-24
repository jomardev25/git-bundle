#!/bin/bash

help() {
  echo "Usage: $0 FILE ..."
  exit
}

for f in "$@"; do
  cmd="${f%.*}.cmd"
  cat <<EOF | sed -E 's@$@\r@' > "$cmd"
cd /d %~dp0
"C:\\Program Files\\Git\\bin\\bash.exe" "$f"
pause
EOF
  echo "Generated: $cmd"
done
