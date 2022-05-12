import { Component, h } from '@stencil/core';

@Component({
  tag: 'zero-scaffold',
  styleUrl: 'zero-scaffold.css',
  shadow: true,
})
export class ZeroScaffold {
  render() {
    return (
      <div class="scaffold">
        <div class="top-bar" role="banner">
          <slot name="top-bar" />
        </div>
        <slot name="header" />
        <div class="content">
          <slot />
        </div>
        <div class="footer">
          <slot name="footer" />
        </div>
      </div>
    );
  }
}
