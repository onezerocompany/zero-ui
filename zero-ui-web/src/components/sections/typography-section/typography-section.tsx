import { Component, h } from '@stencil/core';

@Component({
  tag: 'typography-section',
  styleUrl: 'typography-section.css',
  shadow: true,
})
export class TypographySection {
  render() {
    return (
      <zero-section
        sectionTitle="Typography"
        colors="var(--typography-gradient, #000)"
      >
        <zero-grid spacing={3} minWidth="350px">
          <div>
            <zero-text text-style="heading-4">Regular Text</zero-text>
            <zero-divider thickness={3}></zero-divider>
            <zero-container>
              <zero-text text-style="normal">Normal Text</zero-text>
              <zero-text text-style="bar-title">Bar Title</zero-text>
            </zero-container>
          </div>
          <div>
            <zero-text text-style="heading-4">Headings</zero-text>
            <zero-divider thickness={3}></zero-divider>
            <zero-text text-style="heading-1">Heading 1</zero-text>
            <zero-text text-style="heading-2">Heading 2</zero-text>
            <zero-text text-style="heading-3">Heading 3</zero-text>
            <zero-text text-style="heading-4">Heading 4</zero-text>
            <zero-text text-style="heading-5">Heading 5</zero-text>
            <zero-text text-style="heading-6">Heading 6</zero-text>
          </div>
          <div>
            <zero-text text-style="heading-4">Display Headings</zero-text>
            <zero-divider thickness={3}></zero-divider>
            <zero-text text-style="display-1">Display 1</zero-text>
            <zero-text text-style="display-2">Display 2</zero-text>
            <zero-text text-style="display-3">Display 3</zero-text>
            <zero-text text-style="display-4">Display 4</zero-text>
          </div>
        </zero-grid>
      </zero-section>
    );
  }
}
