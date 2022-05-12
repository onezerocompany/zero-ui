import { Component, h, Prop } from '@stencil/core';

@Component({
  tag: 'zero-section',
  styleUrl: 'zero-section.css',
  shadow: true,
})
export class ZeroSectionHeader {
  @Prop() sectionTitle!: string;
  @Prop() colors: string = '#000, #000';

  render() {
    return (
      <section class="section">
        <div class="section-header">
          <zero-text
            text-style="display-4"
            gradient={true}
            gradient-colors={this.colors}
          >
            {this.sectionTitle}
          </zero-text>
          <zero-divider thickness={6} colors={this.colors}></zero-divider>
        </div>
        <div class="section-content">
          <slot />
        </div>
      </section>
    );
  }
}
