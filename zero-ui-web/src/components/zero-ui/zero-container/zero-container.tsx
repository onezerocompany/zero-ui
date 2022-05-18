import { Component, Prop, h, Element } from '@stencil/core';

@Component({
  tag: 'zero-container',
  styleUrl: 'zero-container.css',
  shadow: true,
})
export class ZeroContainer {
  // layout & shape
  @Prop() padding = 0;
  @Prop() spacing = 0.5;
  @Prop() cornerRadius = 0;
  @Prop() direction = 'column';

  // colors
  @Prop() background = 'var(--color-background, #fff)';
  @Prop() backgroundBlur = 0;

  // elevation
  @Prop() elevation = 0;
  @Prop() neu = 0;
  @Prop() shadow = 0.5;

  // glow
  @Prop() edge = 0;
  @Prop() glow = 0;
  @Prop() edgeGlow = 0;

  @Element() el: HTMLElement;

  componentDidLoad() {
    document.addEventListener('mousemove', (event) => {
      const rect = this.el.getBoundingClientRect();
      this.el.style.setProperty('--cursor-x', `${event.clientX - rect.left}px`);
      this.el.style.setProperty('--cursor-y', `${event.clientY - rect.top}px`);
    });
  }

  render() {
    return (
      <div
        class={{
          'neu': this.neu > 0,
          'elevated': this.elevation > 0,
          'zero-container': true,
          'blurred': this.backgroundBlur > 0,
          'glows': this.glow > 0,
        }}
        style={{
          '--elevation': `${this.elevation}px`,
          '--corner-radius': `${this.cornerRadius}rem`,
          '--padding': `${this.padding}rem`,
          '--shadow': this.shadow.toString(),
          '--edge': this.edge.toString(),
          '--neu': this.neu.toString(),
          '--spacing': `${this.spacing}rem`,
          '--glow': this.glow.toString(),
          '--edge-glow': this.edgeGlow.toString(),
          '--background-blur': `${this.backgroundBlur}px`,
          '--background': this.background,
          '--direction': this.direction,
          '--align': this.direction === 'column' ? 'unset' : 'center',
        }}
      >
        <div class="container-content">
          {this.glow > 0 ? <div class="glow"></div> : null}
          <slot />
        </div>
      </div>
    );
  }
}
