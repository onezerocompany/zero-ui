import { Component, Prop, Event, EventEmitter, h, State } from '@stencil/core';
import { validateMail } from '../../../lib/validators/mail';
import { validatePassword } from '../../../lib/validators/password';
import { validatePhone } from '../../../lib/validators/phone';
import { validateUrl } from '../../../lib/validators/url';

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
  value: string | number;

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
  @State() errorLabel = '';

  private errorValue() {
    if (!this.validator) {
      return undefined;
    }
    const validation = this.validator(this.value as string);
    if (!this.validate || validation === true) {
      return undefined;
    } else if (typeof validation === 'string') {
      this.errorLabel = validation;
      return validation;
    }
    return undefined;
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
      if (this.type === 'password') {
        this.validator = (value?: string) => {
          if (
            !validatePassword(value) ||
            (!this.showErrorBeforeType && !this.hasTyped)
          ) {
            return 'Password should be at least 8 characters, contain a number and a symbol.';
          }
          return true;
        };
      }
      if (this.type === 'email') {
        this.validator = (value?: string) => {
          if (
            !validateMail(value) ||
            (!this.showErrorBeforeType && !this.hasTyped)
          )
            return 'Please enter a valid email address';
        };
      }
      if (this.type === 'tel') {
        this.validator = (value?: string) => {
          if (
            !validatePhone(value) ||
            (!this.showErrorBeforeType && !this.hasTyped)
          )
            return 'Please enter a valid phone number';
        };
      }
      if (this.type === 'url') {
        this.validator = (value?: string) => {
          if (
            !validateUrl(value) ||
            (!this.showErrorBeforeType && !this.hasTyped)
          )
            return 'Please enter a valid URL';
        };
      }
    }
    this.error = this.errorValue();
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
                this.error = this.errorValue();
              }}
            />
          </zero-container>
          <div class="error">
            <zero-text
              lightScheme="red"
              darkScheme="red"
              color="var(--color-primary, #000)"
              size={0.9}
            >
              {this.errorLabel}
            </zero-text>
          </div>
        </zero-container>
      </zero-container>
    );
  }
}
