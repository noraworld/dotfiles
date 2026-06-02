#!/usr/bin/env bash

# EXECUTE THIS EVERY TIME VS CODE EXTENSIONS ARE INSTALLED

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
output_file="${script_dir}/extensions.json"

code --list-extensions --show-versions | jq -R . | jq -s '{recommendations: .}' > "$output_file"
