// eslint-disable-next-line @typescript-eslint/no-shadow
import React, { createContext } from 'react';
import { LabelCategory } from '../../../index';
import type { ColorTheme, Colors } from './ColorTheme';
import { lightColors as defaultLightColors } from './defaultColors';

export class Theme {
  public light: ColorTheme;
  public fontFamilies: Record<LabelCategory, string>;

  public constructor({
    light = defaultLightColors,
    fontFamily = 'sans-serif',
    fontFamilies,
  }: {
    dark?: ColorTheme;
    light?: ColorTheme;
    fontFamily?: string;
    fontFamilies?: Record<LabelCategory, string>;
  }) {
    this.light = light;
    this.fontFamilies = fontFamilies ?? {
      [LabelCategory.displayHeading]: fontFamily,
      [LabelCategory.heading]: fontFamily,
      [LabelCategory.subheading]: fontFamily,
      [LabelCategory.content]: fontFamily,
      [LabelCategory.caption]: fontFamily,
    };
  }

  public get colors(): ColorTheme {
    return this.light;
  }

  public colorsForLevel(level: number): Colors {
    switch (level) {
      case 0:
        return this.colors.scaffold;
      case 1:
        return this.colors.content;
      default:
        return this.colors.content;
    }
  }
}

export const themeContext = createContext<Theme>(new Theme({}));

export function useTheme(): Theme {
  return React.useContext(themeContext);
}
