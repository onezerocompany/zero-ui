import type { ReactElement, CSSProperties } from 'react';
import { createElement } from 'react';
import { useTheme } from '../../../index';
import { labelStyles, LabelCategory, LabelSize } from './LabelStyle';

export * from './LabelStyle';

export interface LabelProps {
  children: string;
  category?: LabelCategory;
  size?: LabelSize;
  fontWeight?: number;
  fontSize?: number;
  lineHeight?: number;
  fontFamily?: string;
  color?: string;
}

// eslint-disable-next-line @typescript-eslint/no-shadow
export function Label({
  children,
  category = LabelCategory.content,
  size = LabelSize.medium,
  fontWeight,
  fontSize,
  lineHeight,
  fontFamily,
  color,
}: LabelProps): ReactElement {
  const theme = useTheme();
  const labelStyle = labelStyles.find(
    (style) => style.category === category && style.size === size,
  );
  const parameters = labelStyle?.parameters;
  const defaultFontWeight = 400;
  const textStyle: CSSProperties = {
    fontWeight: fontWeight ?? parameters?.fontWeight,
    fontSize: fontSize ?? parameters?.fontSize,
    lineHeight: lineHeight ?? parameters?.lineHeight,
    fontFamily: fontFamily ?? theme.fontFamilies[category],
    fontVariationSettings: `"wght" ${
      fontWeight ?? parameters?.fontWeight ?? defaultFontWeight
    }`,
    letterSpacing: parameters?.letterSpacing,
    color: color ?? theme.colors.content.text.content,
    padding: 0,
    margin: 0,
  };

  return createElement(labelStyle?.tag ?? 'p', { style: textStyle }, children);
}

export default Text;
