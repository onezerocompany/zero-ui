import { Component, Prop, h, State } from '@stencil/core';

@Component({
  tag: 'zero-button',
  styleUrl: 'button.css',
  shadow: true,
})
export class ZeroButton {
  // Button properties
  @Prop() fontFamily = 'Inter';
  @Prop() weight = 500;
  @Prop() label?: string;
  @Prop() size = 1;
  @Prop() icon?: string;

  @Prop() action?: () => void;
  @Prop() targetElement?: string;
  @Prop() link?: string;

  // Basic Layout
  @Prop() padding = 0.7;
  @Prop() paddingRatio = 1.2;
  @Prop() spacing = 0;
  @Prop() fill = false;
  @Prop() flex = true;
  @Prop() direction = 'column';

  // Rounded Corners
  @Prop() roundedCorners = 0.6;

  // Color Schemes
  @Prop() lightScheme?: string;
  @Prop() darkScheme?: string;

  // Shadows
  @Prop() shadowProminence = 0.2;
  @Prop() elevation = 0;
  @Prop() neuness = 0;

  // Glow
  @Prop() glowAmount = 0;

  // Edges
  @Prop() edgeBrightness = 0;
  @Prop() edgeThickness = 0;
  @Prop() edgeGlow = 0;

  @State() internalElevation = 0;

  componentWillLoad() {
    this.internalElevation = this.elevation;
  }

  render() {
    return (
      <div
        class="zero-button"
        onMouseEnter={() => (this.internalElevation = this.elevation * 1.5)}
        onMouseLeave={() => (this.internalElevation = this.elevation)}
        onMouseDown={() => (this.internalElevation = 0)}
        onMouseUp={() => (this.internalElevation = this.elevation * 1.5)}
        style={{
          '--button-size': `${this.size}rem`,
        }}
        onClick={() => {
          if (this.action) {
            this.action();
          }
          if (this.targetElement) {
            document.querySelector(this.targetElement).scrollIntoView({
              behavior: 'smooth',
              inline: 'center',
              block: 'center',
            });
          } else if (this.link) {
            window.open(this.link, '_blank');
          }
        }}
      >
        <zero-container
          roundedCorners={this.roundedCorners}
          lightScheme={this.lightScheme}
          darkScheme={this.darkScheme}
          elevation={this.internalElevation}
          shadowProminence={this.shadowProminence}
          neuness={this.neuness}
        >
          <div class="button-content">
            <div class="background">
              <div class="pulse"></div>
            </div>
            <slot>
              <zero-container
                padding={this.padding}
                paddingRatio={this.paddingRatio}
                spacing={this.spacing}
                direction="horizontal"
                background="transparent"
              >
                <zero-text
                  family={this.fontFamily}
                  weight={this.weight}
                  size={this.size}
                  icon={this.icon}
                >
                  {this.label}
                </zero-text>
              </zero-container>
            </slot>
          </div>
        </zero-container>
      </div>
    );
  }
}
