#!/bin/bash
set -e

# Check for uncommitted changes
if ! git diff --quiet; then
  echo "There are uncommitted changes. Aborting."
  exit 1
fi

# Update version
echo "Updating version in package.json..."
yarn update-version

# Install dependencies
echo "Installing dependencies..."
yarn install

# Build project
echo "Building project..."
yarn build

# Add, commit, and push changes
VERSION=$(cat ../VERSION)
echo "Adding changes to git..."
git add .
echo "Committing changes (Release NPM v$VERSION)..."
git commit -m "Release NPM v$VERSION"
echo "Pushing changes..."
git push

# Publish to npm
echo "Publishing to npm..."
yarn publish

echo "Release complete!"
