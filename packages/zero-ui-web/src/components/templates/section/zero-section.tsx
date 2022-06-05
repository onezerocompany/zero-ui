import { Component, h, Prop } from '@stencil/core';

@Component({
  tag: 'zero-section',
  styleUrl: 'zero-section.css',
  shadow: true,
})
export class ZeroSectionHeader {
  @Prop() sectionTitle!: string;
  @Prop() icon?: string;
  @Prop() gradient?: string;

  render() {
    return (
      <section class="section">
        <div class="section-header">
          <zero-text
            text-style="display-4"
            gradient={this.gradient}
            icon={this.icon}
          >
            {this.sectionTitle}
          </zero-text>
          <zero-divider thickness={6} gradient={this.gradient}></zero-divider>
        </div>
        <div class="section-content">
          <slot />
        </div>
      </section>
    );
  }
}
