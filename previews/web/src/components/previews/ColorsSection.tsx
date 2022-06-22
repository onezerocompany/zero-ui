import {
  ZeroGrid,
  ZeroSection,
  colorSchemes,
  ZeroContainer,
  ZeroText,
} from "@onezerocompany/zero-ui-react";
import * as React from "react";

class ColorsSection extends React.Component {
  render() {
    return (
      <ZeroSection sectionTitle="Colors" icon="palette" gradient="mango">
        <ZeroGrid minWidth="350px">
          {colorSchemes.map((scheme) => (
            <ZeroContainer
              lightScheme={scheme.name}
              darkScheme={scheme.name}
              roundedCorners={2}
              padding={2}
              background="var(--color-primary, #fff)"
              backgroundTranslucency={0}
              spacing={0.2}
            >
              <ZeroText textStyle="pre-heading-2">Color Scheme</ZeroText>
              <ZeroText textStyle="heading-2">{scheme.name}</ZeroText>
              <ZeroText textStyle="sub-heading-2" uppercase={true}>
                {scheme.color.hex}
              </ZeroText>
            </ZeroContainer>
          ))}
        </ZeroGrid>
      </ZeroSection>
    );
  }
}

export default ColorsSection;
