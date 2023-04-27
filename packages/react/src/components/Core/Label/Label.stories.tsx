import type { Meta, StoryObj } from '@storybook/react';
import { Scaffold } from '../../Layout/Scaffold/Scaffold';
import { Box } from '../Box/Box';
import { Theme } from '../../Layout/Theme/Theme';
import type { LabelStyle } from './Label';
import { LabelSize, Label, LabelCategory, labelStyles } from './Label';

function getStyleName(style: LabelStyle): string {
  return (
    style.id
      .split(/(?=[A-Z])/u)
      // Title case
      .map(
        (word) => (word[0] ?? '').toUpperCase() + word.slice(1).toLowerCase(),
      )
      .join(' ')
  );
}

const meta: Meta<typeof Label> = {
  component: Label,
  argTypes: {
    fontSize: {
      control: {
        type: 'range',
        min: 8,
        max: 144,
      },
    },
    fontWeight: {
      control: {
        type: 'range',
        min: 100,
        max: 900,
      },
    },
  },
};

export const component: StoryObj<typeof Label> = {
  args: {
    children: 'This is a test text',
  },
};

export const allStyles: StoryObj<typeof Label> = {
  render: () => (
    <Box
      edge={{
        padding: 40,
      }}
    >
      {labelStyles.map((style) => (
        <Label key={style.id} category={style.category} size={style.size}>
          {getStyleName(style)}
        </Label>
      ))}
    </Box>
  ),
};

export const article: StoryObj<typeof Label> = {
  render: () => (
    <Scaffold>
      <Box
        constraints={{ width: { max: 500 } }}
        itemPadding={28}
        edge={{ padding: 40 }}
      >
        <div>
          <Label category={LabelCategory.displayHeading} size={LabelSize.small}>
            This is an article
          </Label>
          <Label category={LabelCategory.subheading} size={LabelSize.large}>
            This is a subheading
          </Label>
        </div>
        <Label>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras tempus
          metus vel arcu tempus tristique. Vestibulum placerat ex a elit
          pharetra, ac pulvinar orci tincidunt. Praesent tempus urna felis, sed
          euismod est venenatis sed. Duis et fringilla purus, ut molestie
          mauris. Vestibulum nulla augue, rhoncus vitae augue consectetur,
          tristique posuere nunc. Sed auctor, erat ac eleifend euismod, urna sem
          congue purus, nec maximus nunc urna sit amet leo. Nulla lorem urna,
          volutpat in fermentum a, consectetur ac odio. Sed laoreet dignissim
          tincidunt. Mauris convallis nunc ut ipsum scelerisque egestas. Aenean
          porta iaculis lorem sed porttitor. In hac habitasse platea dictumst.
        </Label>
        <Label category={LabelCategory.caption}>1. This is a caption</Label>
      </Box>
    </Scaffold>
  ),
};

export default meta;
