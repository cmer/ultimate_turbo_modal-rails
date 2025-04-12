import resolve from '@rollup/plugin-node-resolve';
import css from 'rollup-plugin-css-only';
import { terser } from 'rollup-plugin-terser';
import replace from '@rollup/plugin-replace';
import { readFileSync } from 'fs';

const pkg = JSON.parse(readFileSync('./package.json', 'utf8'));
const packageVersion = pkg.version;

export default {
  input: './index.js',
  output: [
    {
      file: 'dist/ultimate_turbo_modal.js',
      format: 'esm'
    },
    {
      file: 'dist/ultimate_turbo_modal.min.js',
      format: 'esm',
      plugins: [terser()]
    }
  ],
  external: ['@hotwired/stimulus'],
  inlineDynamicImports: true,
  plugins: [
    resolve(),
    css({ output: 'vanilla.css' }),
    replace({
      preventAssignment: true,
      values: {
        '__PACKAGE_VERSION__': JSON.stringify(packageVersion)
      }
    })
  ]
};
