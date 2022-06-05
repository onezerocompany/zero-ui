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
      const scrollTop =
        document.documentElement.scrollTop || document.body.scrollTop;
      this.el.style.setProperty('--scroll-position', `${scrollTop}px`);
      if (scrollTop > 10 !== this.scrolled) {
        this.scrolled = scrollTop > 10;
        document.dispatchEvent(
          new CustomEvent('zero-scrolled', {
            detail: {
              scrolled: this.scrolled,
            },
            bubbles: true,
            cancelable: true,
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
