import { Component, h, State } from '@stencil/core';

@Component({
  tag: 'container-section',
  shadow: true,
  styleUrl: 'container-section.css',
})
export class ContainerSection {
  @State() cornerRadius = 1;
  @State() elevation = 10;
  @State() edge = 0.2;
  @State() neu = 0;
  @State() shadow = 0.2;
  @State() glow = 0.1;
  @State() edgeGlow = 0.6;
  @State() backgroundBlur = 0;
  @State() padding = 2;
  @State() spacing = 1;

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
        name: 'Background Blur',
        value: 'backgroundBlur',
        min: 0,
        max: 20,
      },
      {
        name: 'Padding',
        value: 'padding',
        min: 0,
        max: 20,
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
        colors="var(--container-gradient, #000)"
      >
        <zero-container
          elevation={this.elevation}
          edge={this.edge}
          edge-glow={this.edgeGlow}
          neu={this.neu}
          corner-radius={this.cornerRadius}
          shadow={this.shadow}
          glow={this.glow}
          background-blur={this.backgroundBlur}
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
              ></zero-input>
            ))}
          </zero-grid>
        </zero-container>
      </zero-section>
    );
  }
}
