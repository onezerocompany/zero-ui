import { Component, Prop, h, Element } from '@stencil/core';
import { HTMLStencilElement } from '@stencil/core/internal';
import { gradientFor } from '../../../lib/colors/gradients';
import { styleForName } from '../../../lib/text/styles';

@Component({
  tag: 'zero-text',
  styleUrl: 'text.css',
  shadow: true,
})
export class ZeroText {
  @Prop() padding = 0;
  @Prop() paddingRatio = 1;

  @Prop() textStyle?: string;

  @Prop() lightScheme?: string;
  @Prop() darkScheme?: string;

  // Icon Properties
  @Prop() icon?: string;
  @Prop() iconPosition: 'leading' | 'trailing' = 'leading';
  @Prop() spacing = 0.3;

  // Font Properties
  @Prop() color?: string;

  @Prop() family?: string;
  @Prop() size?: number;
  @Prop() weight?: number;

  @Prop() lineHeight?: number;
  @Prop() letterSpacing?: number;

  @Prop() align: 'left' | 'center' | 'right' = 'left';

  // transform
  @Prop() uppercase = false;
  @Prop() lowercase = false;
  @Prop() underline = false;
  @Prop() capitalize = false;

  // gradient effect
  @Prop() gradient?: string;

  @Element() el: HTMLStencilElement;

  get cssVars() {
    let vars = styleForName(this.textStyle ?? 'normal')?.cssVars ?? {};

    if (this.family) vars['--font-family'] = this.family;
    if (this.size) vars['--font-size'] = `${this.size}rem`;
    if (this.weight) vars['--font-weight'] = this.weight.toString();

    if (this.lineHeight) vars['--line-height'] = this.lineHeight.toString();
    if (this.letterSpacing)
      vars['--letter-spacing'] = `${this.letterSpacing}rem`;

    if (this.color?.length > 0) vars['--text-color'] = this.color;

    vars['--icon-left-spacing'] =
      this.iconPosition === 'leading' ? '0' : `${this.spacing}rem`;
    vars['--icon-right-spacing'] =
      this.iconPosition === 'trailing' ? '0' : `${this.spacing}rem`;
    vars['--text-align'] = this.align;

    if (this.gradient) {
      const gradient = gradientFor(this.gradient);
      vars['--background-gradient'] = gradient.cssBackground;
    }

    return vars;
  }

  get classes() {
    return {
      'uppercase': this.uppercase,
      'lowercase': this.lowercase,
      'underline': this.underline,
      'capitalize': this.capitalize,
      'gradient': this.gradient ? true : false,
      'has-text': this.hasText,
    };
  }

  get hasText() {
    return this.el.textContent.length > 0;
  }

  private get hasIcon() {
    return this.icon?.length > 0;
  }

  render() {
    return (
      <zero-container
        lightScheme={this.lightScheme}
        darkScheme={this.darkScheme}
        direction="horizontal"
        spacing={this.spacing}
        class={this.classes}
        padding={this.padding}
        paddingRatio={this.paddingRatio}
        fill={false}
      >
        <p style={this.cssVars}>
          {this.hasIcon && this.iconPosition === 'leading' ? (
            <span style={this.cssVars} class="material-symbols-outlined">
              {this.icon}
            </span>
          ) : null}
          <span class="content">
            <slot></slot>
          </span>
          {this.hasIcon && this.iconPosition === 'trailing' ? (
            <span class="material-symbols-outlined">{this.icon}</span>
          ) : null}
        </p>
      </zero-container>
    );
  }
}
