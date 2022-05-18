import { Component, h } from '@stencil/core';

@Component({
  tag: 'zero-card',
  styleUrl: 'zero-card.css',
  shadow: true,
})
export class ZeroCard {
  render() {
    return <zero-container></zero-container>;
  }
}
