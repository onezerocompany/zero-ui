import { Config } from '@stencil/core';
import { reactOutputTarget as react } from '@stencil/react-output-target';

// css post processing
import { postcss } from '@stencil/postcss';
import autoprefixer from 'autoprefixer';

export const config: Config = {
  namespace: 'zero-ui-web',
  plugins: [
    postcss({
      plugins: [autoprefixer()],
    }),
  ],
  outputTargets: [
    react({
      componentCorePackage: '@onezerocompany/zero-ui-web',
      proxiesFile: '../zero-ui-react/src/components/stencil-generated/index.ts',
      includeDefineCustomElements: true,
    }),
    {
      type: 'dist',
      esmLoaderPath: '../loader',
    },
    {
      type: 'dist-custom-elements',
    },
    {
      type: 'dist-hydrate-script',
    },
  ],
};
