#!/bin/bash
set -e
cd $(dirname $0)/..

if [ "$1" == "--help" ]; then
  echo "Usage: $0 [--skip-gem] [--skip-js]"
  echo ""
  echo "Options:"
  echo "  --skip-gem   Skip building and releasing the gem."
  echo "  --skip-js    Skip building and releasing the JavaScript."
  echo "  --help       Show this help message."
  exit 0
fi

# Check for uncommitted changes
if ! git diff --quiet; then
  echo "There are uncommitted changes. Aborting."
  exit 1
fi


if [ "$1" != "--skip-gem" ]; then
  echo "Building and releasing gem..."
  bundle exec rake build

  # Check if Gemfile.lock is git dirty
  if ! git diff --quiet Gemfile.lock; then
    echo "Gemfile.lock is dirty. Adding, committing, and pushing."
    git add Gemfile.lock
    git commit -m "Update Gemfile.lock"
    bundle exec rake build
  fi

  bundle exec rake release
else
  echo "Skipping gem build and release..."
fi

if [ "$1" != "--skip-js" ]; then
  echo "Building JavaScript..."
  cd javascript
  ./scripts/release-npm.sh
else
  echo "Skipping JavaScript build..."
fi

echo "Done!"

