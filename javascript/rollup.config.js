import resolve from '@rollup/plugin-node-resolve';
import css from 'rollup-plugin-css-only';
import { terser } from 'rollup-plugin-terser';

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
    css({ output: 'vanilla.css' })
  ]
};
