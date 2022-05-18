import { Component, h } from '@stencil/core';

@Component({
  tag: 'inputs-section',
  shadow: true,
})
export class InputsSection {

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
          elevation={10}
          edge={0.5}
          edge-glow={1}
          neu={0}
          corner-radius={2}
          shadow={0.6}
          glow={0.6}
          padding={2}
          spacing={2}
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
