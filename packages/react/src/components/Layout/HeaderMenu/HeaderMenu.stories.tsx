import type { Meta, StoryObj } from '@storybook/react';
import { HeaderMenu } from './HeaderMenu';

const meta: Meta<typeof HeaderMenu> = {
  component: HeaderMenu,
  parameters: {
    layout: 'fullscreen',
  },
};

export const component: StoryObj<typeof HeaderMenu> = {};

export default meta;
