#!/bin/bash
set -e
cd $(dirname $0)/..

# Check for uncommitted changes
echo "Checking for uncommitted changes..."
if ! git diff --quiet; then
  echo "There are uncommitted changes. Aborting."
  exit 1
fi

echo "Building and releasing gem..."
bundle exec rake build
bundle exec rake release

echo "Building JavaScript..."
cd javascript
./scripts/release-npm.sh

echo "Done!"

