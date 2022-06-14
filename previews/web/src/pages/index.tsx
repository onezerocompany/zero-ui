import * as React from "react";
import {
  ZeroBar,
  ZeroButton,
  ZeroContainer,
  ZeroHeader,
  ZeroScaffold,
  ZeroText,
} from "@onezerocompany/zero-ui-react";
import ContainerSection from "../components/preview-sections/ContainerSection";

// markup
const IndexPage = () => {
  return (
    <ZeroScaffold>
      <div id="header" slot="header">
        <ZeroBar titleText="ZeroUI for the Web">
          <ZeroContainer
            slot="rightside"
            direction="horizontal"
            spacing={1}
            align="end"
          >
            <ZeroButton
              label="GitHub"
              icon="code"
              lightScheme="purple"
              darkScheme="purple"
            ></ZeroButton>
          </ZeroContainer>
        </ZeroBar>
        <ZeroHeader backgroundVideo="https://www.pexels.com/video/3571264/download/?h=1080&w=1920">
          <div slot="card-content">
            <ZeroText textStyle="display-2">Welcome to ZeroUI</ZeroText>
            <ZeroText textStyle="heading-4">
              a modern design system for the web and Flutter
            </ZeroText>
          </div>
        </ZeroHeader>
      </div>
      <ZeroContainer spacing={10} slot="content">
        <ContainerSection />
      </ZeroContainer>
    </ZeroScaffold>
  );
};

export default IndexPage;
