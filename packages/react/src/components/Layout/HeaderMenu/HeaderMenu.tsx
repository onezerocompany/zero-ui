/* eslint-disable react/no-unused-prop-types */
import type { ReactElement } from 'react';
import { RxHamburgerMenu } from 'react-icons/rx';
import { Label, LabelCategory } from '../../Core/Label/Label';
import { Box, Button, useTheme } from '../../../index';

export interface HeaderMenuProps {
  onMenuClick: () => void;
}

export function HeaderMenu(props: HeaderMenuProps): ReactElement {
  const { onMenuClick } = props;
  const theme = useTheme();
  return (
    <Box
      expanded
      direction="horizontal"
      padding={14}
      edges={['bottom']}
      edgeWidth={1}
      spacing
    >
      <Box direction="horizontal" spacing={8}>
        <Button paddingRatio={1} action={onMenuClick}>
          <RxHamburgerMenu size={20} />
        </Button>
      </Box>
      <Box>
        <Label category={LabelCategory.subheading}>Project</Label>
      </Box>
      <div>
        <Button background={theme.colors.primary} filled>
          This is a button
        </Button>
      </div>
    </Box>
  );
}
