#!/bin/sh

set -eo pipefail

# Check if the version argument matches the pattern #.#.#
if ! echo "$1" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'; then
  echo "Error: Version must match the pattern #.#.# (e.g., 1.2.3)" >&2
  exit 1
fi

VERSION="$1"

# Download the archive from the specified version
wget -O archive.zip "https://github.com/legend-hq/legend-scripts/releases/download/$VERSION/artifacts.zip"

# Ensure the archive is deleted when the script exits
trap 'rm -f archive.zip' EXIT

# Unzip the `out/` folder into the releases directory with the version
mkdir -p releases
unzip -o archive.zip -d "releases/$VERSION"

echo "Artifacts for version $VERSION have been extracted to releases/$VERSION."
