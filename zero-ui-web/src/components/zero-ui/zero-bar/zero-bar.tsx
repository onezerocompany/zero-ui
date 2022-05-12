import { Component, h, Prop, State } from '@stencil/core';

@Component({
  tag: 'zero-bar',
  styleUrl: 'zero-bar.css',
  shadow: true,
})
export class ZeroBar {
  @Prop() elevation = 0;
  @Prop() titleText?: string;

  @State() scrolled = false;

  componentDidLoad() {
    document.addEventListener('zero-scrolled', (event: any) => {
      this.scrolled = event.detail.scrolled;
    });
  }

  render() {
    return (
      <div class="bar">
        <zero-container
          elevation={this.elevation}
          corner-radius={this.scrolled ? 0 : 0.6}
          background="var(--color-bar-background, #fff)"
          padding={1.4}
          edge={0.1}
          edge-glow={0.15}
          glow={0}
          background-blur={8}
        >
          <div class="bar-content">
            <slot name="title">
              {this.titleText ? (
                <zero-text text-style="bar-title">{this.titleText}</zero-text>
              ) : null}
            </slot>
            <slot name="buttons" />
          </div>
        </zero-container>
      </div>
    );
  }
}
