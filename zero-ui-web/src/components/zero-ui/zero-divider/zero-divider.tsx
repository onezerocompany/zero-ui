import { Component, h, Prop } from '@stencil/core';

@Component({
  tag: 'zero-divider',
  styleUrl: 'zero-divider.css',
  shadow: true,
})
export class ZeroDivider {
  @Prop() thickness: number = 2;
  @Prop() colors: string = '#000, #000';
  @Prop() spacing: number = 1;
  @Prop() opacity: number = 1;

  render() {
    return (
      <div
        class="divider"
        style={{
          '--thickness': `${this.thickness}px`,
          '--colors': this.colors,
          '--spacing': `${this.spacing}rem`,
          '--opacity': this.opacity.toString(),
        }}
      />
    );
  }
}
