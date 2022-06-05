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
          roundedCorners={this.scrolled ? 0 : 0.6}
          background="var(--color-background, #fff)"
          backgroundTranslucency={0.2}
          backgroundBlur={8}
          padding={0.8}
          edgeBrightness={0.1}
          edgeGlow={0.15}
          glowAmount={0}
          fill={true}
        >
          <div class="bar-content">
            <slot name="leftside">
              <div class="left-content">
                {this.titleText ? (
                  <zero-text weight={600} size={1.25} letterSpacing={-0.02}>
                    {this.titleText}
                  </zero-text>
                ) : null}
              </div>
            </slot>
            <slot name="rightside" />
          </div>
        </zero-container>
      </div>
    );
  }
}
