import { Component, Prop, h } from '@stencil/core';

@Component({
  tag: 'zero-header',
  styleUrl: 'zero-header.css',
  shadow: true,
})
export class ZeroHeader {
  @Prop() backgroundOpacity: number = 0.2;
  @Prop() backgroundImage?: string;
  @Prop() backgroundVideo?: string;

  @Prop() titleText: string = '';
  @Prop() subtitleText: string = '';

  render() {
    return (
      <div class="header">
        <div
          class="background"
          style={{
            opacity: this.backgroundOpacity.toString(),
          }}
        >
          <slot name="background">
            {this.backgroundImage && !this.backgroundVideo ? (
              <img src={this.backgroundImage} alt="header" />
            ) : null}
            {this.backgroundVideo ? (
              <video autoPlay loop muted playsInline>
                <source src={this.backgroundVideo} type="video/mp4" />
              </video>
            ) : null}
          </slot>
        </div>
        <div class="content">
          <slot>
            {this.titleText.length > 0 ? (
              <zero-text
                text-style="display-2"
                color="var(--color-header-text, #fff)"
              >
                {this.titleText}
              </zero-text>
            ) : null}
            {this.subtitleText.length > 0 ? (
              <zero-text
                text-style="heading-4"
                color="var(--color-header-text, #fff)"
              >
                {this.subtitleText}
              </zero-text>
            ) : null}
          </slot>
        </div>
      </div>
    );
  }
}
