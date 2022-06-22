import * as React from "react";
import {
  ZeroContainer,
  ZeroDivider,
  ZeroGrid,
  ZeroSection,
  ZeroText,
} from "@onezerocompany/zero-ui-react";

class TypographySection extends React.Component {
  render() {
    return (
      <ZeroSection
        sectionTitle="Typography"
        icon="font_download"
        gradient="lime"
      >
        <ZeroGrid spacing={2} minWidth="460px">
          <ZeroContainer
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
            <ZeroText textStyle="heading-4" icon="format_size">
              Headings.
            </ZeroText>
            <ZeroDivider
              spacing={1}
              gradient="var(--color-text-tertiary, #000), transparent"
            ></ZeroDivider>
            <ZeroContainer spacing={0.7}>
              <ZeroText textStyle="pre-heading-1">Pre-Heading 1</ZeroText>
              <ZeroText textStyle="heading-1">Heading 1</ZeroText>
              <ZeroText textStyle="sub-heading-1">Sub-Heading 1</ZeroText>
            </ZeroContainer>
            <ZeroContainer spacing={0.7}>
              <ZeroText textStyle="pre-heading-2">Pre-Heading 2</ZeroText>
              <ZeroText textStyle="heading-2">Heading 2</ZeroText>
              <ZeroText textStyle="sub-heading-2">Sub-Heading 2</ZeroText>
            </ZeroContainer>
            <ZeroContainer spacing={0.7}>
              <ZeroText textStyle="pre-heading-3">Pre-Heading 3</ZeroText>
              <ZeroText textStyle="heading-3">Heading 3</ZeroText>
              <ZeroText textStyle="sub-heading-3">Sub-Heading 3</ZeroText>
            </ZeroContainer>
            <ZeroContainer spacing={0.7}>
              <ZeroText textStyle="pre-heading-4">Pre-Heading 4</ZeroText>
              <ZeroText textStyle="heading-4">Heading 4</ZeroText>
              <ZeroText textStyle="sub-heading-4">Sub-Heading 4</ZeroText>
            </ZeroContainer>
            <ZeroText textStyle="heading-5">Heading 5</ZeroText>
            <ZeroText textStyle="heading-6">Heading 6</ZeroText>
          </ZeroContainer>
          <ZeroContainer spacing={2}>
            <ZeroContainer
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
              <ZeroText textStyle="sub-heading-4">
                Some preview content.
              </ZeroText>
              <ZeroText textStyle="heading-5">Regular Paragraph</ZeroText>
              <ZeroText textStyle="paragraph">
                Deserunt ad cupidatat irure eiusmod et incididunt dolore. Duis
                eiusmod deserunt est pariatur officia proident et pariatur velit
                dolor. Do fugiat cupidatat sint in officia. Amet labore tempor
                anim sunt cillum in sit.
              </ZeroText>
              <ZeroText textStyle="footnote">- THIS IS A FOOTNOTE -</ZeroText>
            </ZeroContainer>
            <ZeroContainer
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
              <ZeroText textStyle="display-1">Display 1</ZeroText>
              <ZeroText textStyle="display-2">Display 2</ZeroText>
              <ZeroText textStyle="display-3">Display 3</ZeroText>
              <ZeroText textStyle="display-4">Display 4</ZeroText>
            </ZeroContainer>
          </ZeroContainer>
        </ZeroGrid>
      </ZeroSection>
    );
  }
}

export default TypographySection;
