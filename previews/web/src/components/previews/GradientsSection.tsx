import {
  gradients,
  ZeroContainer,
  ZeroGrid,
  ZeroSection,
  ZeroText,
} from "@onezerocompany/zero-ui-react";
import * as React from "react";

class GradientsSection extends React.Component {
  render() {
    return (
      <ZeroSection sectionTitle="Gradients" icon="palette" gradient="sunrise">
        <ZeroGrid minWidth="350px">
          {gradients.map((gradient) => (
            <ZeroContainer
              roundedCorners={2}
              padding={2}
              background="var(--background-gradient, #fff)"
              backgroundGradient={gradient.name}
              backgroundTranslucency={0}
              spacing={1}
            >
              <ZeroContainer>
                <ZeroText textStyle="pre-heading-2">Gradient</ZeroText>
                <ZeroText textStyle="heading-2">{gradient.name}</ZeroText>
              </ZeroContainer>
              <ZeroGrid spacing={0.4} minWidth="90px">
                {gradient.colors.map((color) => (
                  <ZeroContainer
                    backgroundTranslucency={0}
                    roundedCorners={0.5}
                    padding={0.4}
                    direction="horizontal"
                    lightScheme="light"
                    darkScheme="dark"
                    spacing={0.4}
                    align="space-between"
                    itemAlign="center"
                  >
                    <div
                      style={{
                        display: "block",
                        background: color.hex,
                        height: "18px",
                        width: "18px",
                        borderRadius: "0.3rem",
                        flex: "none",
                      }}
                    ></div>
                    <ZeroText
                      weight={700}
                      color="var(--color-text, #000)"
                      size={0.7}
                      uppercase={true}
                      padding={0}
                      paddingRatio={4}
                    >
                      {color.hex}
                    </ZeroText>
                  </ZeroContainer>
                ))}
              </ZeroGrid>
            </ZeroContainer>
          ))}
        </ZeroGrid>
      </ZeroSection>
    );
  }
}

export default GradientsSection;
