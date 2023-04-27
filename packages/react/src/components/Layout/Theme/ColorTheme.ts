export interface TextColors {
  headline: string;
  content: string;
  link: string;
  line: string;
  hint: string;
}

export interface Colors {
  text: TextColors;
  border: string;
  surface: string;
  importantSurface: string;
}

export enum ColorState {
  Normal = 'normal',
  Highlighted = 'highlighted',
  Pressed = 'pressed',
  Disabled = 'disabled',
}

export interface ColorTheme {
  primary: string;
  secondary: string;
  scaffold: Colors;
  content: Colors;
}
