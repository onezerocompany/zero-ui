import { Component, Prop, h, Element, State } from '@stencil/core';
import { gradientFor } from '../../../lib/colors/gradients';
import { colorSchemeFor } from '../../../lib/colors/schemes';

@Component({
  tag: 'zero-container',
  styleUrl: 'container.css',
  shadow: true,
})
export class ZeroContainer {
  // Basic Layout
  @Prop() padding = 0;
  @Prop() paddingRatio = 1;
  @Prop() spacing = 0;
  @Prop() fill = true;
  @Prop() flex: boolean | string = true;
  @Prop() flexFill = true;
  @Prop() direction: 'vertical' | 'horizontal' = 'vertical';
  @Prop() align = 'space-between';
  @Prop() itemAlign = 'unset';

  // Size
  @Prop() width = 'auto';
  @Prop() height = 'auto';
  @Prop() minWidth = 'unset';
  @Prop() maxWidth = '100%';
  @Prop() minHeight = 'unset';
  @Prop() maxHeight = '100%';
  @Prop() overflow = 'visible';

  // Rounded Corners
  @Prop() roundedCorners = 0;

  // Color Schemes
  @Prop() lightScheme?: string;
  @Prop() darkScheme?: string;

  // Background
  @Prop() background = 'var(--color-background, transparent)';
  @Prop() backgroundBlur = 0;
  @Prop() backgroundTranslucency = 1;
  @Prop() backgroundGradient?: string;

  // Shadows
  @Prop() shadowProminence = 0.5;
  @Prop() elevation = 0;
  @Prop() neuness = 0;

  // Glow
  @Prop() glowAmount = 0;

  // Edges
  @Prop() edgeBrightness = 0;
  @Prop() edgeThickness = 0;
  @Prop() edgeGlow = 0;

  // Mouse Follow
  @Prop() followAmount = 0;

  // Internal state
  @State() dark = false;
  @State() mouseInside = false;
  @Element() el: HTMLElement;

  private get followsMouse() {
    return this.followAmount > 0;
  }

  private get glows() {
    if (this.glowAmount <= 0) return false;
    if (this.backgroundTranslucency > 0) return false;
    return true;
  }

  private get hasEdge() {
    if (this.edgeThickness <= 0) return false;
    if (this.backgroundTranslucency > 0) return false;
    return true;
  }

  private get isNeu() {
    return this.shadowProminence > 0 && this.elevation > 0 && this.neuness > 0;
  }

  private get hasShadow() {
    return this.shadowProminence > 0;
  }

  private get hasBlur() {
    return this.backgroundBlur > 0;
  }

  private get classes() {
    return {
      'zero-container': true,
      'has-shadow': this.hasShadow,
      'is-neu': this.isNeu,
      'has-edge': this.hasEdge,
      'glows': this.glows,
      'follows-mouse': this.followsMouse,
      'mouse-inside': this.mouseInside,
      'blurred': this.hasBlur,
    };
  }

  private get cssVars() {
    let vars = {
      // basic layout
      '--flex-fill': this.flexFill ? '1' : '0',
      '--padding-vertical': `${this.padding}rem`,
      '--padding-horizontal': `${this.padding * this.paddingRatio}rem`,
      '--spacing': `${this.spacing}rem`,
      '--display': this.fill ? 'block' : 'unset',
      '--flex':
        typeof this.flex === 'string'
          ? this.flex
          : this.flex === true
          ? 'flex'
          : 'block',
      '--flex-direction': this.direction === 'horizontal' ? 'row' : 'column',
      '--flex-align': this.align,
      '--flex-item-align': this.itemAlign,
      '--overflow': this.overflow,

      // rounded corners
      '--rounded-corners': `${this.roundedCorners}rem`,

      // Size
      '--width': this.width,
      '--height': this.height,
      '--max-width': this.maxWidth,
      '--max-height': this.maxHeight,
      '--min-width': this.minWidth,
      '--min-height': this.minHeight,

      // background
      '--background': this.background,
      '--background-blur': `${this.backgroundBlur}px`,
      '--background-opacity': `${1 - this.backgroundTranslucency}`,

      // Edges
      '--edge-brightness': this.edgeBrightness.toString(),
      '--edge-thickness': this.edgeThickness.toString(),
      '--edge-glow': this.edgeGlow.toString(),

      // shadows
      '--elevation': `${this.elevation}px`,
      '--shadow-prominence': `${this.shadowProminence}`,
      '--shadow-neuness': `${this.neuness}`,

      // glow
      '--glow-amount': `${this.glowAmount}`,
      '--glow-size': `${this.el.offsetWidth * 0.6}px`,
    };
    if (this.lightScheme || this.darkScheme) {
      const scheme = colorSchemeFor(
        (this.dark ? this.darkScheme ?? this.lightScheme : this.lightScheme) ??
          'light',
      );
      if (scheme) Object.assign(vars, scheme.cssVars);
    }
    if (this.backgroundGradient) {
      const gradient = gradientFor(this.backgroundGradient);
      vars['--background'] = 'var(--background-gradient, transparent)';
      vars['--background-gradient'] = gradient.cssBackground;
      vars['--color-text'] = '#fff';
      vars['--color-text-primary'] = '#fff';
      vars['--color-text-secondary'] = 'rgba(255, 255, 255, 0.7)';
      vars['--color-text-tertiary'] = 'rgba(255, 255, 255, 0.4)';
      vars['--color-inputs'] = 'rgba(255, 255, 255, 0.2)';
    }
    return vars;
  }

  render() {
    return (
      <div class={this.classes} style={this.cssVars}>
        {this.hasEdge ? <div class="edge-background"></div> : null}
        {this.hasEdge ? <div class="edge"></div> : null}
        <div class="container">
          <div class="background"></div>
          {this.glows ? <div class="glow"></div> : null}
          <div class="content">
            <slot />
          </div>
        </div>
      </div>
    );
  }

  componentWillLoad() {
    if (this.glows || this.followsMouse) {
      document.addEventListener('mousemove', (event) => {
        const rect = this.el.getBoundingClientRect();

        const x = event.clientX - rect.left;
        const y = event.clientY - rect.top;

        this.el.style.setProperty('--cursor-x', `${x}px`);
        this.el.style.setProperty('--cursor-y', `${y}px`);

        this.mouseInside =
          x >= -20 && y >= -20 && x < rect.width + 40 && y < rect.height + 40;

        // update mouse follow effect
        if (this.followsMouse) {
          const xFromCenter = x - rect.width / 2;
          const yFromCenter = y - rect.height / 2;

          const degrees = 10;
          const xDegreeStep = degrees / (rect.width / 2);
          const yDegreeStep = degrees / (rect.height / 2);

          const xDegree = xDegreeStep * xFromCenter;
          const yDegree = yDegreeStep * -yFromCenter;

          this.el.style.setProperty('--cursor-x-rotate', `${xDegree}deg`);
          this.el.style.setProperty('--cursor-y-rotate', `${yDegree}deg`);
        }
      });
    }

    // detect dark mode
    this.dark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    window
      .matchMedia('(prefers-color-scheme: dark)')
      .addEventListener('change', (event) => {
        this.dark = event.matches;
      });
  }
}
