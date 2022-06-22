import { Component, h, Prop } from '@stencil/core';

@Component({
  tag: 'zero-footer',
  styleUrl: 'zero-footer.css',
  shadow: true,
})
export class ZeroFooter {
  @Prop()
  copyright = `Copyright © ${new Date().getFullYear()} OneZero Company. All rights reserved.`;

  render() {
    return (
      <footer>
        <zero-container padding={2} align="center">
          <zero-text textStyle="copyright">{this.copyright}</zero-text>
        </zero-container>
      </footer>
    );
  }
}
