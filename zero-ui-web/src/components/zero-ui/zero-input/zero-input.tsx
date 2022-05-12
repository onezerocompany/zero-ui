import { Component, Prop, h } from '@stencil/core';

@Component({
  tag: 'zero-input',
  styleUrl: 'zero-input.css',
  shadow: true,
})
export class ZeroInput {
  @Prop() type: string = 'text';
  @Prop() placeholder: string = `Enter ${this.type} here`;
  @Prop() name = 'input';
  @Prop() label = 'Input';
  @Prop() min = 0;
  @Prop() max = 1;
  @Prop() step = 0.01;
  @Prop() valueTemplate = '{{value}}';
  @Prop({
    reflect: true,
    mutable: true,
    attribute: 'value',
  })
  value: string;

  private horizontalInputs = ['color', 'checkbox'];

  render() {
    return (
      <zero-container
        elevation={1}
        padding={0.8}
        spacing={0.2}
        shadow={0.3}
        corner-radius={0.5}
        edge={0.6}
        background="var(--input-background, #fff)"
        direction={this.horizontalInputs.includes(this.type) ? 'row' : 'column'}
        style={{
          '--max-width': this.horizontalInputs.includes(this.type)
            ? '3rem'
            : '100%',
        }}
      >
        <div class="top-row">
          <label htmlFor={this.name}>{this.label}</label>
          {this.type === 'range' ? (
            <p class="value">
              {this.valueTemplate.replace(
                '{{value}}',
                this.value?.toString().trim() ?? '',
              )}
            </p>
          ) : null}
        </div>
        <input
          name={this.name}
          type={this.type}
          value={this.value}
          placeholder={this.placeholder}
          min={this.min}
          max={this.max}
          step={this.step}
          onInput={(e) => (this.value = (e.target as HTMLInputElement).value)}
        />
        {this.type === 'file' ? (
          <zero-text>Insert button to select file</zero-text>
        ) : null}
      </zero-container>
    );
  }
}
