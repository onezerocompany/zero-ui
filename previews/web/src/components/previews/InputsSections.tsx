import {
  titleCase,
  ZeroContainer,
  ZeroGrid,
  ZeroInput,
  ZeroSection,
} from "@onezerocompany/zero-ui-react";
import * as React from "react";

class InputsSection extends React.Component {
  private types() {
    return [
      { type: "text", icon: "text_fields" },
      { type: "password", icon: "password" },
      { type: "search", icon: "search" },
      { type: "tel", icon: "phone" },
      { type: "email", icon: "mail" },
      { type: "url", icon: "language" },
      { type: "range", icon: "linear_scale" },
      { type: "number", icon: "pin" },
      { type: "checkbox", icon: "done_all" },
    ];
  }

  render() {
    return (
      <ZeroSection sectionTitle="Inputs">
        <ZeroContainer>
          <ZeroGrid>
            {this.types().map((item) => (
              <ZeroInput
                icon={item.icon}
                type={item.type}
                name={item.type}
                label={titleCase(item.type)}
                validate={true}
                required={true}
              ></ZeroInput>
            ))}
          </ZeroGrid>
        </ZeroContainer>
      </ZeroSection>
    );
  }
}

export default InputsSection;
