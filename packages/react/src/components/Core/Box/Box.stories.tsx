import type { Meta, StoryObj } from '@storybook/react';
import { Label, LabelCategory } from '../Label/Label';
import { Theme } from '../../Layout/Theme/Theme';
import { Box, Edge } from './Box';

const meta: Meta<typeof Box> = {
  component: Box,
  args: {
    filled: true,
    background: new Theme({}).colors.content.surface,
    padding: 20,
    paddingRatio: 1,
    margin: 0,
    edgeRadius: 14,
    edgeWidth: 1,
    spacing: 0,
    direction: 'vertical',
    edges: [Edge.Top, Edge.Right, Edge.Bottom, Edge.Left],
    edgeColors: [],
  },
  argTypes: {
    children: {
      table: {
        disable: true,
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

const dummyContent = (
  <>
    <Label category={LabelCategory.heading}>Test Box</Label>
    <Label category={LabelCategory.content}>Lorem ipsum dolor sit amet</Label>
  </>
);

export const regular: StoryObj<typeof Box> = {
  args: {
    children: dummyContent,
  },
};
export const rainbowBorder: StoryObj = {
  args: {
    ...regular.args,
    edgeColors: ['red', 'yellow', 'magenta', 'cyan'],
    edgeWidth: 4,
  },
};

export default meta;
