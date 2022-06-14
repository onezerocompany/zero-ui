import * as React from "react";
import {
  ZeroContainer,
  ZeroInput,
  ZeroSection,
  ZeroText,
  ZeroGrid,
} from "@onezerocompany/zero-ui-react";

const variables = [
  {
    name: "Corner Radius",
    value: "cornerRadius",
    min: 0,
    max: 3,
  },
  {
    name: "Elevation",
    value: "elevation",
    min: 0,
    max: 20,
  },
  {
    name: "Shadow",
    value: "shadow",
    min: 0,
    max: 1,
  },
  {
    name: "Edge Thickness",
    value: "edgeThickness",
    min: 0,
    max: 1,
  },
  {
    name: "Edge",
    value: "edge",
    min: 0,
    max: 1,
  },
  {
    name: "Neu",
    value: "neu",
    min: 0,
    max: 1,
  },
  {
    name: "Glow",
    value: "glow",
    min: 0,
    max: 1,
  },
  {
    name: "Edge Glow",
    value: "edgeGlow",
    min: 0,
    max: 1,
  },
  {
    name: "Background Translucency",
    value: "backgroundTranslucency",
    min: 0,
    max: 1,
  },
  {
    name: "Spacing",
    value: "spacing",
    min: 0,
    max: 20,
  },
];

class ContainerSection extends React.Component {
  state: { [key: string]: number } = {
    cornerRadius: 1,
    elevation: 10,
    edge: 0.1,
    neu: 0,
    shadow: 0.2,
    glow: 0.05,
    edgeGlow: 0.4,
    backgroundTranslucency: 0,
    padding: 2,
    spacing: 1,
    edgeThickness: 0.1,
  };

  render(): React.ReactNode {
    return (
      <ZeroSection
        sectionTitle="Containers"
        icon="select_all"
        gradient="sunset"
      >
        <ZeroGrid spacing={2} minWidth="400px">
          <ZeroContainer
            elevation={this.state.elevation}
            edgeBrightness={this.state.edge}
            edgeThickness={this.state.edgeThickness}
            edgeGlow={this.state.edgeGlow}
            neuness={this.state.neu}
            roundedCorners={this.state.cornerRadius}
            shadowProminence={this.state.shadow}
            glowAmount={this.state.glow}
            backgroundTranslucency={this.state.backgroundTranslucency}
            padding={this.state.padding}
            spacing={this.state.spacing}
            align="center"
          >
            <ZeroText
              textStyle="heading-3"
              color="var(--color-text-tertiary, #000)"
              align="center"
            >
              Preview Container
            </ZeroText>
            <ZeroText
              textStyle="sub-heading-3"
              color="var(--color-text-tertiary, #000)"
              align="center"
            >
              Use the sliders to change the appearance
            </ZeroText>
          </ZeroContainer>
          <ZeroContainer spacing={0.5}>
            {variables.map((variable) => (
              <ZeroInput
                type="range"
                label={variable.name}
                name={variable.value}
                min={variable.min}
                max={variable.max}
                value={this.state[variable.value]}
                onValueChanged={(e) => {
                  const value = Number(e.detail);
                  this.setState({
                    [variable.value]: value,
                  });
                }}
              />
            ))}
          </ZeroContainer>
        </ZeroGrid>
      </ZeroSection>
    );
  }
}

export default ContainerSection;
