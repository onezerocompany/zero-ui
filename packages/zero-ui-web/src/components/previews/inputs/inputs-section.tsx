import { Component, h } from '@stencil/core';
import { titleCase } from '../../../lib/text/capitalize';

@Component({
  tag: 'inputs-section',
  shadow: true,
})
export class InputsSection {
  types() {
    return [
      { type: 'text', icon: 'text_fields' },
      { type: 'password', icon: 'password' },
      { type: 'search', icon: 'search' },
      { type: 'tel', icon: 'phone' },
      { type: 'email', icon: 'mail' },
      { type: 'url', icon: 'language' },
      { type: 'range', icon: 'linear_scale' },
      { type: 'number', icon: 'pin' },
      { type: 'checkbox', icon: 'done_all' },
    ];
  }

  render() {
    return (
      <zero-section sectionTitle="Inputs">
        <zero-container>
          <zero-grid>
            {this.types().map((item) => (
              <zero-input
                icon={item.icon}
                type={item.type}
                name={item.type}
                label={titleCase(item.type)}
                validate={true}
                required={true}
              ></zero-input>
            ))}
          </zero-grid>
        </zero-container>
      </zero-section>
    );
  }
}
