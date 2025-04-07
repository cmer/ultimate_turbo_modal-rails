const fs = require('fs');
const path = require('path');

const versionFilePath = path.resolve(__dirname, '..', 'VERSION');
const packageJsonPath = path.resolve(__dirname, '..', 'package.json');

// Read version from VERSION file
const version = fs.readFileSync(versionFilePath, 'utf8').trim();

// Read package.json
const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));

// Update version if it's different
if (packageJson.version !== version) {
  packageJson.version = version;
  // Write updated package.json, preserving indentation (2 spaces)
  fs.writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2) + '\n');
  console.log(`Updated package.json version to ${version}`);
} else {
  console.log(`package.json version (${packageJson.version}) is already up to date.`);
}