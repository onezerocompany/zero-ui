import { createContext, useContext } from 'react';

export const levelContext = createContext<number>(0);

export function useLevel(): number {
  return useContext(levelContext);
}
