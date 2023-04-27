/* eslint-disable react/no-unused-prop-types */
/* eslint-disable max-lines-per-function */
import type { ReactNode, ReactElement } from 'react';
import { useTheme } from '../../Layout/Theme/Theme';
import { applyConstraints } from './BoxConstraints';
import { applyEdges } from './BoxEdge';
import { levelContext, useLevel } from './LevelProvider';
import { applyContent } from './BoxContent';
import type { Colors } from 'components/Layout/Theme/ColorTheme';

export * from './BoxConstraints';
export * from './BoxEdge';
export * from './BoxContent';

export interface BoxProps {
  children?: ReactNode;
  animated?: boolean;
  duration?: number;

  // Content
  direction?: 'horizontal' | 'vertical';
  filled?: boolean;
  background?: string;
  scrollable?: boolean;

  // Edges
  edges?: Array<'bottom' | 'left' | 'right' | 'top'>;
  edgeColors?: string[];
  edgeWidth?: number;
  edgeRadius?: number;

  // Spacing
  paddingRatio?: number;
  padding?: number;
  margin?: number;
  spacing?: boolean | number;

  // Constraints
  expanded?: boolean;
  width?: number;
  minWidth?: number;
  maxWidth?: number;
  height?: number;
  minHeight?: number;
  maxHeight?: number;
}

/**
 * Box component, containing other content to encapsulate its purpose in a visual manner.
 *
 * @param {BoxProps} props - Component props.
 * @returns {ReactElement} - Rendered Box component.
 */
export function Box(props: BoxProps): ReactElement {
  const { children } = props;
  const level = useLevel();
  const levelColors: Colors = useTheme().colorsForLevel(level);
  let box = <div>{children}</div>;

  box = applyContent({
    box,
    props,
    levelColors,
  });

  box = applyEdges({
    box,
    props,
    levelColors,
  });

  box = applyConstraints({ box, props });

  return <levelContext.Provider value={level + 1}>{box}</levelContext.Provider>;
}

export default Box;
