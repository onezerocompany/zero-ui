import { Component, h, Prop } from '@stencil/core';
import { gradientFor } from '../../../lib/colors/gradients';

@Component({
  tag: 'zero-divider',
  styleUrl: 'divider.css',
  shadow: true,
})
export class ZeroDivider {
  @Prop() thickness: number = 2;
  @Prop() spacing: number = 0.5;
  @Prop() gradient?: string;

  render() {
    return (
      <div
        class="divider"
        style={{
          '--thickness': `${this.thickness}px`,
          '--spacing': `${this.spacing}rem`,
          '--gradient':
            gradientFor(this.gradient ?? '')?.cssBackground ??
            'var(--color-text-primary, #000)',
        }}
      />
    );
  }
}
