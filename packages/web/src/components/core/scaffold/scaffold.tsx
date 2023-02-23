import { Component, h, Prop, State, Element } from '@stencil/core';

@Component({
  tag: 'zero-scaffold',
  styleUrl: 'scaffold.css',
  shadow: false,
  scoped: false,
})
export class ZeroScaffold {
  @Prop() lightScheme = 'light';
  @Prop() darkScheme = 'dark';
  @Prop() font = 'Inter';

  // Internal state
  @State() scrolled = false;
  @Element() el: HTMLElement;

  componentWillLoad() {
    document.addEventListener('scroll', () => {
      const position =
        document.documentElement.scrollTop || document.body.scrollTop;
      const scrolled = position > 20;
      if (this.scrolled !== scrolled) {
        this.scrolled = scrolled;
        document.dispatchEvent(
          new CustomEvent('zero-scrolled', {
            detail: {
              scrolled: this.scrolled,
            },
          }),
        );
      }
    });
  }

  render() {
    return (
      <div
        id="scaffold"
        style={{
          '--font': this.font,
        }}
        class={{
          'not-scrolled': !this.scrolled,
        }}
      >
        <zero-container
          lightScheme={this.lightScheme}
          darkScheme={this.darkScheme}
          flex={false}
          background="var(--color-scaffold, transparent)"
          backgroundTranslucency={0}
        >
          <div>
            <slot name="header" />
          </div>
          <div class="scaffold-content">
            <slot name="content" />
          </div>
          <div>
            <slot name="footer" />
          </div>
        </zero-container>
      </div>
    );
  }
}
