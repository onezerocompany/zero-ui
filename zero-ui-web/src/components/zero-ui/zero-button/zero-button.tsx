import { Component, Prop, State, h } from '@stencil/core';

@Component({
  tag: 'zero-button',
  styleUrl: 'zero-button.css',
  shadow: true,
})
export class ZeroButton {
  @Prop() label = 'Button';

  @State() elevation = 2;

  render() {
    return (
      <div
        class="zero-button"
        onMouseEnter={() => (this.elevation = 4)}
        onMouseLeave={() => (this.elevation = 2)}
        onMouseDown={() => (this.elevation = 1)}
        onMouseUp={() => (this.elevation = 4)}
      >
        <zero-container
          elevation={this.elevation}
          shadow={0.2}
          glow={0.2}
          corner-radius={1}
          padding={1}
          neu={0}
        >
          <slot>
            <zero-text>{this.label}</zero-text>
          </slot>
        </zero-container>
      </div>
    );
  }
}
