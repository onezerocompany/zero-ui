import type { CSSProperties, ReactElement } from 'react';
import { cloneElement } from 'react';
import type { BoxProps } from './Box';

export function applyConstraints({
  box,
  props,
}: {
  box: ReactElement;
  props: BoxProps;
}): ReactElement {
  const { expanded, width, minWidth, maxWidth, height, minHeight, maxHeight } =
    props;
  const { style } = box.props as { style?: CSSProperties | null };
  const newStyle: CSSProperties = { ...style };

  if (expanded === true) {
    newStyle.width = '100%';
    newStyle.height = '100%';
  } else {
    if (typeof width === 'number') {
      newStyle.width = width;
    } else {
      if (typeof minWidth === 'number') {
        newStyle.minWidth = minWidth;
      }

      if (typeof maxWidth === 'number') {
        newStyle.maxWidth = maxWidth;
      }
    }

    if (typeof height === 'number') {
      newStyle.height = height;
    } else {
      if (typeof minHeight === 'number') {
        newStyle.minHeight = minHeight;
      }

      if (typeof maxHeight === 'number') {
        newStyle.maxHeight = maxHeight;
      }
    }
  }

  return cloneElement(box, {
    style: newStyle,
  });
}
