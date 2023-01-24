#!/bin/bash

set -eu

utils_dir="$(readlink -f "$(dirname "$0")")"
bundles_dir="${utils_dir%/*}"
base_dir="${bundles_dir%/*}"

local_source_code_dir="$base_dir/local_source_code"
remote_repo_bundle_dir="$base_dir/remote_repo_bundle_files"
bundle_name="remote_bundle"

cd "$local_source_code_dir"
bundle="$remote_repo_bundle_dir/$bundle_name.bundle"
if [ -f "$bundle" ]; then
  ( set -x; git fetch "$bundle" develop:feature )
else
  echo "[INFO] No bundle file: remote_bundle.bundle"
fi
