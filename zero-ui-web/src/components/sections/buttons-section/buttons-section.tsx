import { Component, h } from '@stencil/core';

@Component({
  tag: 'buttons-section',
  styleUrl: 'buttons-section.css',
  shadow: true,
})
export class ButtonsSection {
  render() {
    return (
      <zero-section
        sectionTitle="Buttons"
        colors="var(--buttons-gradient, #000)"
      >
        <zero-grid minWidth="150px">
          <zero-button label="Default Button"></zero-button>
          <zero-button label="Icon Button" icon=""></zero-button>
          <zero-button></zero-button>
          <zero-button></zero-button>
          <zero-button></zero-button>
          <zero-button></zero-button>
          <zero-button></zero-button>
          <zero-button></zero-button>
        </zero-grid>
      </zero-section>
    );
  }
}
