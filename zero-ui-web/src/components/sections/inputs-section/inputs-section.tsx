import { Component, h, State } from '@stencil/core';

@Component({
  tag: 'inputs-section',
  shadow: true,
})
export class InputsSection {
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

  types() {
    return [
      'text',
      'password',
      'search',
      'tel',
      'email',
      'url',

      'datetime-local',
      'time',
      'date',
      'range',
      'month',
      'week',
      'number',
      'file',
      'color',
      'checkbox',
    ];
  }

  render() {
    return (
      <zero-section sectionTitle="Inputs" colors="var(--inputs-gradient, #000)">
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
            {this.types().map((type) => (
              <zero-input type={type} name={type} label={type}></zero-input>
            ))}
          </zero-grid>
        </zero-container>
      </zero-section>
    );
  }
}
