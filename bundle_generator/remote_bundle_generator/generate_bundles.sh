#!/bin/bash

set -eu

utils_dir="$(readlink -f "$(dirname "$0")")"
bundles_dir="${utils_dir%/*}"
base_dir="${bundles_dir%/*}"

remote_repo_bundle_dir="$base_dir/remote_repo_bundle_files"
remote_source_code_dir="$base_dir/remote_source_code"
bundle_name="remote_source_code"

cd "$remote_source_code_dir"
git show-ref > "$remote_repo_bundle_dir/$bundle_name.reflist"
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
  ( set -x; git bundle create "$remote_repo_bundle_dir/$bundle_name.bundle" $branches develop  )
else
  echo "[INFO] Skip generating bundle: $bundle_name"
fi