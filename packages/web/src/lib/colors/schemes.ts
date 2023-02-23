import { Color } from './Color';
import { ColorScheme } from './ColorScheme';

export const colorSchemes: ColorScheme[] = [
  new ColorScheme({
    name: 'Light',
    color: new Color({ hex: '#fafafa' }),
    scaffold: new Color({ hex: '#f2efef' }),
  }),
  new ColorScheme({
    name: 'Dark',
    color: new Color({ hex: '#1d1c1c' }),
    scaffold: new Color({ hex: '#000' }),
  }),
  new ColorScheme({
    name: 'Grey',
    color: new Color({ hex: '#46475c' }),
  }),
  new ColorScheme({
    name: 'Blue',
    color: new Color({ hex: '#0066ff' }),
  }),
  new ColorScheme({
    name: 'Teal',
    color: new Color({ hex: '#00bcd4' }),
  }),
  new ColorScheme({
    name: 'Green',
    color: new Color({ hex: '#00ce59' }),
  }),
  new ColorScheme({
    name: 'Orange',
    color: new Color({ hex: '#ff9f1a' }),
  }),
  new ColorScheme({
    name: 'Yellow',
    color: new Color({ hex: '#ffd207' }),
  }),
  new ColorScheme({
    name: 'Purple',
    color: new Color({ hex: '#9b51e0' }),
  }),
  new ColorScheme({
    name: 'Red',
    color: new Color({ hex: '#ff2d55' }),
  }),
  new ColorScheme({
    name: 'Pink',
    color: new Color({ hex: '#ff2d73' }),
  }),
  new ColorScheme({
    name: 'Brown',
    color: new Color({ hex: '#71534a' }),
  }),
];

function normalizeName(name: string) {
  return name.toLowerCase().replace(/\s/g, '').trim();
}

export function colorSchemeFor(nameOrColor: string): ColorScheme {
  if (nameOrColor.startsWith('#')) {
    return new ColorScheme({
      name: 'Custom',
      color: new Color({ hex: nameOrColor }),
    });
  } else {
    return (
      colorSchemes.find(
        (scheme) => normalizeName(scheme.name) === normalizeName(nameOrColor),
      ) ??
      new ColorScheme({
        name: 'Fallback',
        color: new Color({ hex: '#fafafa' }),
        scaffold: new Color({ hex: '#f2efef' }),
      })
    );
  }
}
