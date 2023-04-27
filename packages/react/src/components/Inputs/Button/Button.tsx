/* eslint-disable react/jsx-props-no-spreading */
/* eslint-disable react/no-unused-prop-types */
import type { CSSProperties, ReactElement, ReactNode } from 'react';
import { useState } from 'react';
import { RxArrowRight } from 'react-icons/rx';
import type { BoxProps } from '../../../index';
import { Box, Label } from '../../../index';
import { textColorForBackground } from '../../../utils/colors/text';

const gapHoverScale = 2;
const gapRatio = 0.5;
const defaultEdgeRadius = 8;
const defaultPadding = 14;
const defaultEdgeWidth = 1;
const defaultLabelSize = 16;

export interface ButtonProps extends BoxProps {
  children: ReactNode;
  labelSize?: number;
  arrow?: boolean;
  action?: () => void;
  link?: string;
}

// eslint-disable-next-line max-lines-per-function
export function Button(props: ButtonProps): ReactElement {
  const [hover, setHover] = useState(false);
  const [active, setActive] = useState(false);

  // Remove all default button styling
  const resetStyle: CSSProperties = {
    border: 'none',
    background: 'none',
    margin: 0,
    padding: 0,
    cursor: 'pointer',
  };

  const {
    children,
    labelSize,
    arrow,
    action,
    link,
    edgeWidth,
    padding,
    edgeRadius,
    spacing,
  } = props;

  const newProps: BoxProps = {
    ...props,
    edgeWidth: edgeWidth ?? defaultEdgeWidth,
    padding: padding ?? defaultPadding,
    edgeRadius: edgeRadius ?? defaultEdgeRadius,
    spacing:
      (hover ? gapHoverScale : 1) *
      (typeof spacing === 'number' ? spacing : 1) *
      gapRatio,
  };

  const textColor = textColorForBackground(newProps.background ?? '#FFFFFF');

  return (
    <button
      type="button"
      style={resetStyle}
      onMouseEnter={(): void => {
        setHover(true);
      }}
      onMouseLeave={(): void => {
        setHover(false);
      }}
      onMouseDown={(): void => {
        setActive(true);
      }}
      onMouseUp={(): void => {
        setActive(false);
      }}
      onClick={(): void => {
        if (typeof link === 'string') {
          window.open(link, '_blank');
        }
        if (action) {
          action();
        }
      }}
    >
      <Box {...newProps}>
        {typeof children === 'string' ? (
          <Label
            fontSize={labelSize ?? defaultLabelSize}
            color={textColor}
            lineHeight={1}
          >
            {children}
          </Label>
        ) : (
          children
        )}
        {arrow === true && (
          <RxArrowRight size={22} fontWeight={600} color={textColor} />
        )}
      </Box>
    </button>
  );
}
