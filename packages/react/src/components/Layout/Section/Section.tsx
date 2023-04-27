import type { ReactElement } from 'react';
import { Box } from '../../Core/Box/Box';

export interface SectionProps {
  children: ReactElement;
  color: string;
}

export function Section(props: SectionProps): ReactElement {
  const { children, color } = props;
  return (
    <Box filled expanded background={color} padding={80}>
      <Box maxWidth={740}>{children}</Box>
    </Box>
  );
}
