import type { CSSProperties, ReactElement } from 'react';
import { cloneElement } from 'react';
import type { Colors } from '../../Layout/Theme/ColorTheme';
import type { BoxProps } from './Box';

enum Edge {
  Top = 'top',
  Right = 'right',
  Bottom = 'bottom',
  Left = 'left',
}

function renderComplexBorder({
  box,
  props,
  edgeStyle,
  style,
  horizontalPadding,
}: {
  box: ReactElement;
  props: BoxProps;
  edgeStyle: CSSProperties;
  style: CSSProperties | null | undefined;
  horizontalPadding: number;
}): ReactElement {
  const {
    padding = 0,
    edges = [Edge.Top, Edge.Right, Edge.Bottom, Edge.Left],
    edgeColors = [],
    edgeWidth = 0,
    edgeRadius = 0,
  } = props;

  const outerStyle: CSSProperties = {
    ...edgeStyle,
    backgroundImage: `conic-gradient(${edgeColors.join(', ')}, ${
      edgeColors[0] ?? ''
    })`,
    padding: 0,
    paddingTop: edges.includes(Edge.Top) ? edgeWidth : 0,
    paddingRight: edges.includes(Edge.Right) ? edgeWidth : 0,
    paddingBottom: edges.includes(Edge.Bottom) ? edgeWidth : 0,
    paddingLeft: edges.includes(Edge.Left) ? edgeWidth : 0,
  };

  const innerStyle: CSSProperties = {
    ...edgeStyle,
    padding: `${padding}px ${horizontalPadding}px`,
    margin: 0,
    borderRadius: edgeRadius - edgeWidth,
  };

  return (
    <div style={outerStyle}>
      {cloneElement(box, {
        style: {
          ...style,
          ...innerStyle,
        },
      })}
    </div>
  );
}

export { Edge };

// eslint-disable-next-line max-lines-per-function, max-statements
export function applyEdges({
  box,
  props,
  levelColors,
}: {
  box: ReactElement;
  props: BoxProps;
  levelColors: Colors;
}): ReactElement {
  const { style } = box.props as { style?: CSSProperties | null };

  const {
    edges = [Edge.Top, Edge.Right, Edge.Bottom, Edge.Left],
    edgeWidth = 0,
    edgeColors = [],
    edgeRadius = 0,
    padding = 0,
    paddingRatio = 1,
    margin = 0,
    filled = false,
    animated = false,
    duration = 300,
  } = props;

  const horizontalPadding = padding * paddingRatio;
  const edgeStyle: CSSProperties = {
    borderRadius: edgeRadius,
    margin,
    padding: `${padding}px ${horizontalPadding}px`,
  };

  if (animated) {
    edgeStyle.transition = `all ${duration}ms ease-in-out`;
    edgeStyle.WebkitTransition = `all ${duration}ms ease-in-out`;
    edgeStyle.MozTransition = `all ${duration}ms ease-in-out`;
  }

  if (edgeWidth === 0) {
    return cloneElement(box, {
      style: {
        ...style,
        ...edgeStyle,
      },
    });
  }

  if (edgeColors.length > 1 && filled) {
    return renderComplexBorder({
      box,
      props,
      style,
      edgeStyle,
      horizontalPadding,
    });
  }

  let [color] = edgeColors;
  if (typeof color !== 'string' || color.length === 0) {
    color = levelColors.border;
  }

  if (edges.includes(Edge.Top)) {
    edgeStyle.borderTopWidth = edgeWidth;
    edgeStyle.borderTopColor = color;
    edgeStyle.borderTopStyle = 'solid';
  }

  if (edges.includes(Edge.Right)) {
    edgeStyle.borderRightWidth = edgeWidth;
    edgeStyle.borderRightColor = color;
    edgeStyle.borderRightStyle = 'solid';
  }

  if (edges.includes(Edge.Bottom)) {
    edgeStyle.borderBottomWidth = edgeWidth;
    edgeStyle.borderBottomColor = color;
    edgeStyle.borderBottomStyle = 'solid';
  }

  if (edges.includes(Edge.Left)) {
    edgeStyle.borderLeftWidth = edgeWidth;
    edgeStyle.borderLeftColor = color;
    edgeStyle.borderLeftStyle = 'solid';
  }

  return cloneElement(box, {
    style: {
      ...style,
      ...edgeStyle,
    },
  });
}
