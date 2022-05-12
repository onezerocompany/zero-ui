import { Component, Prop, h } from '@stencil/core';

@Component({
  tag: 'zero-text',
  styleUrl: 'zero-text.css',
  shadow: true,
})
export class ZeroText {
  @Prop() color = 'var(--color-text-primary, #000)';
  @Prop() textStyle: string = 'normal';
  @Prop() uppercase: boolean = false;
  @Prop() gradient: boolean = false;
  @Prop() gradientColors: string =
    'var(--color-primary, #000), var(--color-primary-light, #000)';

  render() {
    return (
      <p
        class={{
          uppercase: this.uppercase,
          gradient: this.gradient,
          [`style-${this.textStyle}`]: true,
        }}
        style={{
          'backgroundImage': this.gradient
            ? `linear-gradient(90deg, ${this.gradientColors})`
            : '',
          '--color': this.color,
        }}
      >
        <slot />
      </p>
    );
  }
}
