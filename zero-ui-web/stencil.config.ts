import { Config } from '@stencil/core';
import { reactOutputTarget as react } from '@stencil/react-output-target';

// css post processing
import { postcss } from '@stencil/postcss';
import autoprefixer from 'autoprefixer';

export const config: Config = {
  namespace: 'zero-ui-web',
  globalStyle: 'src/global/zero-ui-web.css',
  globalScript: 'src/global/zero-ui.ts',
  plugins: [
    postcss({
      plugins: [autoprefixer()],
    }),
  ],
  outputTargets: [
    react({
      componentCorePackage: 'zero-ui-web',
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
      type: 'www',
      serviceWorker: null, // disable service workers
    },
  ],
};
