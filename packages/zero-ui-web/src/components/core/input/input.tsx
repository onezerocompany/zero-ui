import { Component, Prop, Event, EventEmitter, h, State } from '@stencil/core';

@Component({
  tag: 'zero-input',
  styleUrl: 'input.css',
  shadow: true,
})
export class ZeroInput {
  @Prop() type: string = 'text';
  @Prop() placeholder: string = `Enter ${this.type} here`;
  @Prop() name = 'input';
  @Prop() label = 'Input';
  @Prop() min = 0;
  @Prop() max = 100;
  @Prop() step = 0.01;
  @Prop() valueTemplate = '{{value}}';
  @Prop() direction: 'horizontal' | 'vertical' | 'auto' = 'auto';

  @Event() valueChanged: EventEmitter<string>;

  @Prop({
    reflect: true,
    mutable: true,
    attribute: 'value',
  })
  value: string;

  @Prop() icon?: string;

  // Container Properties
  @Prop() elevation = 0;
  @Prop() padding = 0.8;
  @Prop() paddingRatio = 1.2;

  @Prop() validate = false;
  @Prop() required = false;
  @Prop() showErrorBeforeType = false;
  @Prop() validator?: (value: string) => boolean | string;

  @State() hasTyped = false;
  @State() error?: string;

  private updateValue(value: string) {
    if (!this.validator) {
      this.error = undefined;
      return;
    }
    const validation = this.validator(this.value);
    if (!this.validate || validation === true) {
      this.error = undefined;
    } else if (typeof validation === 'string') {
      this.error = validation;
    }
    this.error = undefined;
    console.log(this.error);
  }

  private horizontalInputs = ['color', 'checkbox'];
  private get correctDirection() {
    if (this.direction === 'auto') {
      return this.horizontalInputs.includes(this.type)
        ? 'horizontal'
        : 'vertical';
    }
    return this.direction;
  }

  private get spacing() {
    return this.correctDirection === 'vertical' ? 0.4 : 1;
  }

  componentWillLoad() {
    if (this.type === 'range' && !this.value) {
      this.value = `${this.min}`;
    }
    if (!this.validator) {
      if (this.type === 'text') {
        this.validator = (value?: string) => {
          if (!this.validate || (!this.showErrorBeforeType && !this.hasTyped))
            return true;
          if (this.required && !value) return 'This field is required';
          return true;
        };
      }
    }
  }

  render() {
    return (
      <zero-container
        elevation={this.elevation}
        padding={this.padding}
        paddingRatio={this.paddingRatio}
        shadowProminence={0.3}
        roundedCorners={0.5}
        edgeBrightness={0.05}
        edgeThickness={0.1}
        glowAmount={0.05}
        edgeGlow={0.2}
        spacing={0.4}
        background="var(--color-inputs, transparent)"
        background-translucency={0}
        direction="horizontal"
        class={{
          'show-error': this.error?.length > 0,
        }}
      >
        <zero-container spacing={0.3}>
          <zero-container
            spacing={this.spacing}
            direction={this.correctDirection}
          >
            <zero-container direction="horizontal" fill={true} flexFill={false}>
              <zero-text
                size={0.9}
                weight={600}
                icon={this.icon}
                family="Inter"
              >
                {this.label}
              </zero-text>
              {this.type === 'range' ? (
                <p class="value">
                  {this.valueTemplate.replace(
                    '{{value}}',
                    this.value?.toString().trim() ?? '',
                  )}
                </p>
              ) : null}
            </zero-container>
            <input
              name={this.name}
              type={this.type}
              placeholder={this.placeholder}
              min={this.min}
              max={this.max}
              step={this.step}
              value={this.value}
              onInput={(e) => {
                this.hasTyped = true;
                this.value = (e.target as HTMLInputElement).value;
                this.valueChanged.emit(this.value);
                this.updateValue(this.value);
              }}
            />
          </zero-container>
          <zero-text
            lightScheme="red"
            darkScheme="red"
            color="var(--color-primary, #000)"
            size={0.9}
          >
            {this.error}
          </zero-text>
        </zero-container>
      </zero-container>
    );
  }
}
