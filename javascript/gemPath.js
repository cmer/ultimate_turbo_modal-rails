const { execSync } = require('child_process');

function getUltimateTurboModalPath() {
  const path = execSync('bundle show ultimate_turbo_modal').toString().trim();
  return `${path}/**/*.{erb,html,rb}`;
}

module.exports = { getUltimateTurboModalPath };
