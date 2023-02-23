import { Color } from './Color';

export class ColorScheme {
  name: string;
  color: Color;
  background: Color;
  scaffold: Color;

  public get cssVars() {
    return {
      '--color-primary': this.color.hex,
      '--color-text': this.color.blend(this.color.textColor, 0.7).hex,
      '--color-text-primary': this.color.blend(this.color.textColor, 0.95).hex,
      '--color-text-secondary': this.color.blend(this.color.textColor, 0.5).hex,
      '--color-text-tertiary': this.color.blend(this.color.textColor, 0.35).hex,
      '--color-shadows-light': this.scaffold.blend(Color.white, 0.5).rgb,
      '--color-shadows-dark': this.scaffold.blend(Color.black, 0.5).rgb,
      '--color-background': this.background.hex,
      '--color-inputs': this.background.blend(
        Color.white,
        this.color.inputBlend,
      ).hex,
      '--color-scaffold': this.scaffold.hex,
    };
  }

  constructor(metadata: {
    name: string;
    color: Color;
    background?: Color;
    scaffold?: Color;
  }) {
    this.name = metadata.name;
    this.color = metadata.color;
    if (metadata.scaffold) {
      this.scaffold = metadata.scaffold;
    } else {
      this.scaffold = this.color.blend(
        Color.offBlack,
        this.color.scaffoldBlend,
      );
    }
    if (metadata.background) {
      this.background = metadata.background;
    } else {
      this.background = this.scaffold.blend(this.color, 0.5);
    }
  }
}
