import { Component, h } from '@stencil/core';
import { colorSchemes } from '../../../lib/colors/schemes';

@Component({
  tag: 'colors-section',
  shadow: true,
})
export class ColorsSection {
  render() {
    return (
      <zero-section sectionTitle="Colors" icon="palette" gradient="mango">
        <zero-grid minWidth="350px">
          {colorSchemes.map((colorScheme) => (
            <zero-container
              lightScheme={colorScheme.name}
              darkScheme={colorScheme.name}
              roundedCorners={2}
              padding={2}
              background="var(--color-primary, #fff)"
              backgroundTranslucency={0}
              spacing={0.2}
            >
              <zero-text textStyle="pre-heading-2">Color Scheme</zero-text>
              <zero-text textStyle="heading-2">{colorScheme.name}</zero-text>
              <zero-text textStyle="sub-heading-2" uppercase={true}>
                {colorScheme.color.hex}
              </zero-text>
            </zero-container>
          ))}
        </zero-grid>
      </zero-section>
    );
  }
}
