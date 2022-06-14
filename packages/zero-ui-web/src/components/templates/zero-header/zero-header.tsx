import { Component, Prop, h } from '@stencil/core';

@Component({
  tag: 'zero-header',
  styleUrl: 'zero-header.css',
  shadow: true,
})
export class ZeroHeader {
  @Prop() backgroundOpacity: number = 0.9;
  @Prop() backgroundImage?: string;
  @Prop() backgroundVideo?: string;

  render() {
    return (
      <div class="zero-header">
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
          <slot name="content">
            <zero-container
              class="header-card"
              backgroundBlur={15}
              padding={4}
              paddingRatio={1.3}
              roundedCorners={1}
              backgroundTranslucency={0.7}
              lightScheme="dark"
              followAmount={10}
              fill={false}
              flex={false}
              flexFill={false}
            >
              <div class="card-content">
                <slot name="card-content" />
              </div>
            </zero-container>
          </slot>
        </div>
        <div class="fadeout"></div>
      </div>
    );
  }
}
