import { Component, h } from '@stencil/core';

@Component({
  tag: 'typography-section',
  shadow: true,
})
export class TypographySection {
  render() {
    return (
      <zero-section
        sectionTitle="Typography"
        icon="font_download"
        gradient="lime"
      >
        <zero-grid spacing={2} minWidth="460px">
          <zero-container
            backgroundTranslucency={0}
            padding={2.5}
            roundedCorners={2}
            spacing={1.5}
            followAmount={10}
            edgeGlow={0.3}
            edgeThickness={0.1}
            elevation={5}
            shadowProminence={0.15}
          >
            <zero-text textStyle="heading-4" icon="format_size">
              Headings.
            </zero-text>
            <zero-divider
              spacing={1}
              gradient="var(--color-text-tertiary, #000), transparent"
            ></zero-divider>
            <zero-container spacing={0.7}>
              <zero-text textStyle="pre-heading-1">Pre-Heading 1</zero-text>
              <zero-text textStyle="heading-1">Heading 1</zero-text>
              <zero-text textStyle="sub-heading-1">Sub-Heading 1</zero-text>
            </zero-container>
            <zero-container spacing={0.7}>
              <zero-text textStyle="pre-heading-2">Pre-Heading 2</zero-text>
              <zero-text textStyle="heading-2">Heading 2</zero-text>
              <zero-text textStyle="sub-heading-2">Sub-Heading 2</zero-text>
            </zero-container>
            <zero-container spacing={0.7}>
              <zero-text textStyle="pre-heading-3">Pre-Heading 3</zero-text>
              <zero-text textStyle="heading-3">Heading 3</zero-text>
              <zero-text textStyle="sub-heading-3">Sub-Heading 3</zero-text>
            </zero-container>
            <zero-container spacing={0.7}>
              <zero-text textStyle="pre-heading-4">Pre-Heading 4</zero-text>
              <zero-text textStyle="heading-4">Heading 4</zero-text>
              <zero-text textStyle="sub-heading-4">Sub-Heading 4</zero-text>
            </zero-container>
            <zero-text textStyle="heading-5">Heading 5</zero-text>
            <zero-text textStyle="heading-6">Heading 6</zero-text>
          </zero-container>
          <zero-container spacing={2}>
            <zero-container
              backgroundTranslucency={0}
              padding={2.5}
              roundedCorners={2}
              spacing={1}
              followAmount={10}
              edgeGlow={0.3}
              edgeThickness={0.1}
              elevation={5}
              shadowProminence={0.15}
            >
              <zero-text textStyle="sub-heading-4">
                Some preview content.
              </zero-text>
              <zero-text textStyle="heading-5">Regular Paragraph</zero-text>
              <zero-text textStyle="paragraph">
                Deserunt ad cupidatat irure eiusmod et incididunt dolore. Duis
                eiusmod deserunt est pariatur officia proident et pariatur velit
                dolor. Do fugiat cupidatat sint in officia. Amet labore tempor
                anim sunt cillum in sit.
              </zero-text>
              <zero-text textStyle="footnote">- THIS IS A FOOTNOTE -</zero-text>
            </zero-container>
            <zero-container
              backgroundTranslucency={0}
              padding={2.5}
              roundedCorners={2}
              spacing={1}
              followAmount={10}
              edgeGlow={0.3}
              edgeThickness={0.1}
              elevation={5}
              shadowProminence={0.15}
            >
              <zero-text textStyle="display-1">Display 1</zero-text>
              <zero-text textStyle="display-2">Display 2</zero-text>
              <zero-text textStyle="display-3">Display 3</zero-text>
              <zero-text textStyle="display-4">Display 4</zero-text>
            </zero-container>
          </zero-container>
        </zero-grid>
      </zero-section>
    );
  }
}
