import { Component, h, State } from '@stencil/core';

@Component({
  tag: 'container-section',
  shadow: true,
})
export class ContainerSection {
  @State() cornerRadius = 1;
  @State() elevation = 10;
  @State() edge = 0.1;
  @State() neu = 0;
  @State() shadow = 0.2;
  @State() glow = 0.05;
  @State() edgeGlow = 0.4;
  @State() backgroundBlur = 0;
  @State() backgroundTranslucency = 0;
  @State() padding = 2;
  @State() spacing = 1;
  @State() edgeThickness = 0.1;

  variables() {
    return [
      {
        name: 'Corner Radius',
        value: 'cornerRadius',
        min: 0,
        max: 3,
      },
      {
        name: 'Elevation',
        value: 'elevation',
        min: 0,
        max: 20,
      },
      {
        name: 'Shadow',
        value: 'shadow',
        min: 0,
        max: 1,
      },
      {
        name: 'Edge Thickness',
        value: 'edgeThickness',
        min: 0,
        max: 1,
      },
      {
        name: 'Edge',
        value: 'edge',
        min: 0,
        max: 1,
      },
      {
        name: 'Neu',
        value: 'neu',
        min: 0,
        max: 1,
      },
      {
        name: 'Glow',
        value: 'glow',
        min: 0,
        max: 1,
      },
      {
        name: 'Edge Glow',
        value: 'edgeGlow',
        min: 0,
        max: 1,
      },
      {
        name: 'Background Translucency',
        value: 'backgroundTranslucency',
        min: 0,
        max: 1,
      },
      {
        name: 'Spacing',
        value: 'spacing',
        min: 0,
        max: 20,
      },
    ];
  }

  render() {
    return (
      <zero-section
        sectionTitle="Containers"
        icon="select_all"
        gradient="sunset"
      >
        <zero-container
          elevation={this.elevation}
          edgeBrightness={this.edge}
          edgeThickness={this.edgeThickness}
          edgeGlow={this.edgeGlow}
          neuness={this.neu}
          roundedCorners={this.cornerRadius}
          shadowProminence={this.shadow}
          glowAmount={this.glow}
          backgroundTranslucency={this.backgroundTranslucency}
          padding={this.padding}
          spacing={this.spacing}
        >
          <zero-grid>
            {this.variables().map((variable) => (
              <zero-input
                type="range"
                label={variable.name}
                name={variable.value}
                min={variable.min}
                max={variable.max}
                value={this[variable.value]}
                onValueChanged={(e) => {
                  this[variable.value] = e.detail;
                }}
              ></zero-input>
            ))}
          </zero-grid>
        </zero-container>
      </zero-section>
    );
  }
}
