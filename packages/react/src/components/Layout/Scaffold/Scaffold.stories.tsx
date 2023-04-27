import type { Meta, StoryObj } from '@storybook/react';
import { Section } from '../Section/Section';
import { Label } from '../../Core/Label/Label';
import { SectionTransition } from '../SectionTransition/SectionTransition';
import { Scaffold } from './Scaffold';

const meta: Meta<typeof Scaffold> = {
  component: Scaffold,
  argTypes: {
    theme: {
      control: false,
    },
  },
  parameters: {
    layout: 'fullscreen',
  },
};

export const component: StoryObj<typeof Scaffold> = {
  args: {
    children: (
      <>
        <Section color="#b7d8c7">
          <Label>Hello</Label>
        </Section>
        <SectionTransition firstColor="#b7d8c7" secondColor="#3a3f7b" />
        <Section color="#3a3f7b">
          <Label>Hello</Label>
        </Section>
        <SectionTransition
          firstColor="#3a3f7b"
          secondColor="#2c8ce4"
          amplitude1={40}
          amplitude2={44}
          frequency1={6}
          frequency2={3}
        />
        <Section color="#2c8ce4">
          <Label>Hello</Label>
        </Section>
      </>
    ),
  },
};

export default meta;
