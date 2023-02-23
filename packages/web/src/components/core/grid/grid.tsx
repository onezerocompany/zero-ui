import { Component, Prop, h } from '@stencil/core';

@Component({
  tag: 'zero-grid',
  styleUrl: 'grid.css',
  shadow: true,
})
export class ZeroGrid {
  @Prop() spacing = 1;
  @Prop() minWidth = '300px';

  render() {
    return (
      <div
        class="zero-grid"
        style={{
          '--spacing': `${this.spacing}rem`,
          '--min-width': this.minWidth,
        }}
      >
        <slot />
      </div>
    );
  }
}
