import { Component, h } from '@stencil/core';

@Component({
  tag: 'buttons-section',
  shadow: true,
})
export class ButtonsSection {
  render() {
    return (
      <zero-section sectionTitle="Buttons" gradient="red">
        <zero-container
          padding={1}
          direction="horizontal"
          spacing={1}
          fill={false}
        >
          <zero-button label="Default Button"></zero-button>
          <zero-button
            label="Icon Button"
            icon="favorite"
            lightScheme="pink"
          ></zero-button>
          <zero-button icon="upload" lightScheme="yellow"></zero-button>
          <zero-button
            icon="check"
            label="Accept"
            lightScheme="green"
          ></zero-button>
          <zero-button
            icon="close"
            label="Decline"
            lightScheme="red"
          ></zero-button>
          <zero-button
            icon="arrow_upward"
            label="Back to Top"
            lightScheme="purple"
            targetElement="#header"
          ></zero-button>
          <zero-button
            icon="delete"
            label="Delete"
            lightScheme="red"
            action={() =>
              alert('We might delete something, but not in this demo.')
            }
          ></zero-button>
          <zero-button
            icon="travel_explore"
            label="This is a link"
            lightScheme="blue"
            link="https://onezero.company"
          ></zero-button>
        </zero-container>
      </zero-section>
    );
  }
}
