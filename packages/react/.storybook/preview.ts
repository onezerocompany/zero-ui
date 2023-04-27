import type { Preview } from '@storybook/react';
import { Theme } from '../src/components/Layout/Theme/Theme';

const theme = new Theme({});

const preview: Preview = {
  parameters: {
    actions: { argTypesRegex: '^on[A-Z].*' },
    layout: 'centered',
    viewport: {
      defaultViewport: 'responsive',
      viewports: {
        mobile: {
          name: 'Mobile',
          styles: {
            width: '375px',
            height: '667px',
          },
        },
        tablet: {
          name: 'Tablet',
          styles: {
            width: '768px',
            height: '1024px',
          },
        },
        desktop: {
          name: 'Desktop',
          styles: {
            width: '1440px',
            height: '900px',
          },
        },
      },
    },

    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
        range: /number$/,
      },
    },
    backgrounds: {
      default: 'scaffold',
      values: [
        {
          name: 'scaffold',
          value: theme.colors.scaffold.surface,
        },
        {
          name: 'content',
          value: theme.colors.content.surface,
        },
      ],
    },
  },
};

export default preview;
