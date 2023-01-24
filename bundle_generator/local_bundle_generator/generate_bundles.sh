#!/bin/bash

set -eu

utils_dir="$(readlink -f "$(dirname "$0")")"
bundles_dir="${utils_dir%/*}"
base_dir="${bundles_dir%/*}"

local_repo_bundle_dir="$base_dir/local_repo_bundle_files"
local_source_code_dir="$base_dir/local_source_code"
bundle_name="remote_bundle"

cd "$local_source_code_dir"
git show-ref > "$local_repo_bundle_dir/$bundle_name.reflist"
branches="$(git show-ref --heads |
      awk '
        / refs\/heads\/master$/ {
          next
        }
        {
          sub(/^[^ ]+ [^\/]+\/[^\/]+\//, "")
          print
        }'
    )"

if [ -n "$branches" ]; then
  ( set -x; git bundle create "$local_repo_bundle_dir/$bundle_name.bundle" $branches develop  )
else
  echo "[INFO] Skip generating bundle: $bundle_name.bundle"
fi