/* eslint-disable react/jsx-props-no-spreading */
import type { Meta, StoryObj } from '@storybook/react';
import { Button } from './Button';

const meta: Meta<typeof Button> = {
  component: Button,
};

export const component: StoryObj<typeof Button> = {
  args: {
    children: 'Button',
    labelSize: 16,
  },
  argTypes: {
    children: {
      table: {
        disable: true,
      },
    },
    labelSize: {
      control: {
        type: 'range',
        min: 0,
        max: 100,
        step: 1,
      },
      table: {
        category: 'Content',
      },
    },
    direction: {
      control: {
        type: 'select',
        options: ['horizontal', 'vertical'],
      },
      table: {
        category: 'Content',
      },
    },
    spacing: {
      control: {
        type: 'range',
        min: 0,
        max: 100,
        step: 1,
      },
      table: {
        category: 'Content',
      },
    },
    filled: {
      table: {
        category: 'Content',
      },
    },
    background: {
      control: {
        type: 'color',
      },
      table: {
        category: 'Content',
      },
    },
    edgeColors: {
      table: {
        category: 'Edge',
      },
    },
    edges: {
      control: {
        type: 'check',
      },
      options: ['top', 'right', 'bottom', 'left'],
      table: {
        category: 'Edge',
      },
    },
    edgeRadius: {
      control: {
        type: 'range',
        min: 0,
        max: 100,
        step: 1,
      },
      table: {
        category: 'Edge',
      },
    },
    edgeWidth: {
      control: {
        type: 'range',
        min: 0,
        max: 50,
        step: 0.5,
      },
      table: {
        category: 'Edge',
      },
    },
    padding: {
      control: {
        type: 'range',
        min: 0,
        max: 100,
        step: 1,
      },
      table: {
        category: 'Spacing',
      },
    },
    paddingRatio: {
      control: {
        type: 'range',
        min: 0,
        max: 10,
        step: 0.1,
      },
      table: {
        category: 'Spacing',
      },
    },
    margin: {
      control: {
        type: 'range',
        min: 0,
        max: 100,
        step: 1,
      },
      table: {
        category: 'Spacing',
      },
    },
    expanded: {
      table: {
        category: 'Constraints',
      },
    },
    minWidth: {
      table: {
        category: 'Constraints',
      },
    },
    maxWidth: {
      table: {
        category: 'Constraints',
      },
    },
    minHeight: {
      table: {
        category: 'Constraints',
      },
    },
    maxHeight: {
      table: {
        category: 'Constraints',
      },
    },
  },
};

export default meta;
