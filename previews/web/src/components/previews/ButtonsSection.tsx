import {
  ZeroButton,
  ZeroContainer,
  ZeroSection,
} from "@onezerocompany/zero-ui-react";
import * as React from "react";

class ButtonsSection extends React.Component {
  render() {
    return (
      <ZeroSection sectionTitle="Buttons" gradient="red">
        <ZeroContainer
          padding={1}
          direction="horizontal"
          spacing={1}
          fill={false}
        >
          <ZeroButton label="Default Button"></ZeroButton>
          <ZeroButton
            label="Icon Button"
            icon="favorite"
            lightScheme="pink"
          ></ZeroButton>
          <ZeroButton icon="upload" lightScheme="yellow"></ZeroButton>
          <ZeroButton
            icon="check"
            label="Accept"
            lightScheme="green"
          ></ZeroButton>
          <ZeroButton
            icon="close"
            label="Decline"
            lightScheme="red"
          ></ZeroButton>
          <ZeroButton
            icon="arrow_upward"
            label="Back to Top"
            lightScheme="purple"
            targetElement="#header"
          ></ZeroButton>
          <ZeroButton
            icon="delete"
            label="Delete"
            lightScheme="red"
            action={() =>
              alert("We might delete something, but not in this demo.")
            }
          ></ZeroButton>
          <ZeroButton
            icon="travel_explore"
            label="This is a link"
            lightScheme="blue"
            link="https://onezero.company"
          ></ZeroButton>
        </ZeroContainer>
      </ZeroSection>
    );
  }
}

export default ButtonsSection;
