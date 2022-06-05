import { Component, h } from '@stencil/core';
import { gradients } from '../../../lib/colors/gradients';

@Component({
  tag: 'gradients-section',
  shadow: true,
  styleUrl: 'gradients-section.css',
})
export class GradientsSection {
  render() {
    return (
      <zero-section sectionTitle="Gradients" icon="palette" gradient="sunrise">
        <zero-grid minWidth="350px">
          {gradients.map((gradient) => (
            <zero-container
              roundedCorners={2}
              padding={2}
              background="var(--background-gradient, #fff)"
              backgroundGradient={gradient.name}
              backgroundTranslucency={0}
              spacing={1}
            >
              <zero-container>
                <zero-text textStyle="pre-heading-2">Gradient</zero-text>
                <zero-text textStyle="heading-2">{gradient.name}</zero-text>
              </zero-container>
              <zero-grid spacing={0.4} minWidth="90px">
                {gradient.colors.map((color) => (
                  <zero-container
                    backgroundTranslucency={0}
                    roundedCorners={0.5}
                    padding={0.4}
                    direction="horizontal"
                    lightScheme="light"
                    darkScheme="dark"
                    spacing={0}
                    align="space-between"
                  >
                    <div
                      class="color-preview"
                      style={{ background: color.hex }}
                    ></div>
                    <zero-text
                      weight={700}
                      color="var(--color-text, #000)"
                      size={0.7}
                      uppercase={true}
                      padding={0.1}
                      paddingRatio={4}
                    >
                      {color.hex}
                    </zero-text>
                  </zero-container>
                ))}
              </zero-grid>
            </zero-container>
          ))}
        </zero-grid>
      </zero-section>
    );
  }
}
