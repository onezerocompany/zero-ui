import type { CSSProperties, ReactElement } from 'react';
import { cloneElement } from 'react';
import type { Colors } from '../../Layout/Theme/ColorTheme';
import type { BoxProps } from './Box';

export function applyContent({
  box,
  props,
  levelColors,
}: {
  box: ReactElement;
  levelColors: Colors;
  props: BoxProps;
}): ReactElement {
  const {
    direction: contentDirection,
    filled,
    background,
    spacing,
    scrollable = false,
  } = props;
  const { style } = box.props as { style?: CSSProperties | null };
  const newStyle: CSSProperties = { ...style };
  const horizontal = contentDirection === 'horizontal';

  newStyle.boxSizing = 'border-box';
  newStyle.display = 'flex';
  if (horizontal) {
    newStyle.alignItems = 'center';
  }
  newStyle.justifyContent = spacing === true ? 'space-between' : 'start';
  newStyle.flexDirection = horizontal ? 'row' : 'column';

  if (scrollable) {
    newStyle.overflow = 'scroll';
  }

  if (typeof spacing === 'number') {
    newStyle.gap = spacing;
  } else {
    newStyle.gap = 0;
  }

  if (filled === true) {
    if (typeof background === 'string') {
      newStyle.background = background;
    } else {
      newStyle.background = levelColors.surface;
    }
  }

  return cloneElement(box, {
    style: newStyle,
  });
}
