import resolve from '@rollup/plugin-node-resolve';
import css from 'rollup-plugin-css-only';
import { terser } from 'rollup-plugin-terser';

export default {
  input: 'javascript/index.js',
  output: {
    file: 'dist/ultimate_turbo_modal.min.js',
    format: 'esm'
  },
  external: [
    // This makes us not inline dependencies.
    /node_modules/
  ],
  inlineDynamicImports: true,
  plugins: [
    resolve(),
    terser(),
    css({ output: 'vanilla.css' })
  ]
};
