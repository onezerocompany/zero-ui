import * as React from "react";
import {
  ZeroBar,
  ZeroButton,
  ZeroContainer,
  ZeroFooter,
  ZeroHeader,
  ZeroScaffold,
  ZeroText,
} from "@onezerocompany/zero-ui-react";
import ContainerSection from "../components/previews/ContainerSection";
import ColorsSection from "../components/previews/ColorsSection";
import GradientsSection from "../components/previews/GradientsSection";
import TypographySection from "../components/previews/TypographySection";
import ButtonsSection from "../components/previews/ButtonsSection";
import InputsSection from "../components/previews/InputsSections";

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
              link="https://github.com/onezerocompany/zero-ui"
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
        <ColorsSection />
        <GradientsSection />
        <TypographySection />
        <ButtonsSection />
        <InputsSection />
      </ZeroContainer>
      <ZeroFooter slot="footer" />
    </ZeroScaffold>
  );
};

export default IndexPage;
