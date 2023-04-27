import type { ReactNode, ReactElement } from 'react';
import { useState } from 'react';
import { Box, HeaderMenu, Label } from '../../../index';
import { Theme, themeContext } from '../Theme/Theme';

const openedEdgeRadius = 14;
const openedPadding = 16;

export interface ScaffoldProps {
  children: ReactNode;
  theme?: Theme;
}

export function Scaffold({
  children,
  theme = new Theme({}),
}: ScaffoldProps): ReactElement {
  // Menu open
  const [menuOpen, setMenuOpen] = useState(false);

  return (
    <themeContext.Provider value={theme}>
      <Box
        animated
        expanded
        filled
        padding={menuOpen ? openedPadding : 0}
        direction="horizontal"
      >
        <Box animated width={menuOpen ? 330 : 0}>
          <Label>Menu</Label>
        </Box>
        <Box
          animated
          expanded
          filled
          edgeRadius={menuOpen ? openedEdgeRadius : 0}
          edgeWidth={menuOpen ? 1 : 0}
        >
          <HeaderMenu
            onMenuClick={(): void => {
              setMenuOpen(!menuOpen);
            }}
          />
          {children}
        </Box>
      </Box>
    </themeContext.Provider>
  );
}
