#!/bin/bash

set -eu

utils_dir="$(readlink -f "$(dirname "$0")")"
bundles_dir="${utils_dir%/*}"
base_dir="${bundles_dir%/*}"

local_repo_bundle_dir="$base_dir/local_repo_bundle_files"
remote_source_code_dir="$base_dir/remote_source_code"
bundle_name="local_source_code"

cd "$remote_source_code_dir"
bundle="$local_repo_bundle_dir/$bundle_name.bundle"

if [ -f "$bundle" ]; then
    ( set -x; git fetch "$bundle" develop:feature )
else
    echo "[INFO] No bundle file: local_source_code"
fi