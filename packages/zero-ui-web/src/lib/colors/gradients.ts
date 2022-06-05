import { Color } from './Color';
import { Gradient } from './Gradient';

export const gradients: Gradient[] = [
  new Gradient({
    name: 'Sunset',
    type: 'linear',
    colors: [new Color({ hex: '#ff0066' }), new Color({ hex: '#f28c1e' })],
  }),
  new Gradient({
    name: 'Sunrise',
    type: 'linear',
    colors: [new Color({ hex: '#6b37ed' }), new Color({ hex: '#db5be4' })],
  }),
  new Gradient({
    name: 'Blue',
    type: 'linear',
    colors: [new Color({ hex: '#0066ff' }), new Color({ hex: '#00bcd4' })],
  }),
  new Gradient({
    name: 'Mango',
    type: 'linear',
    colors: [new Color({ hex: '#ff9f1a' }), new Color({ hex: '#ffd207' })],
  }),
  new Gradient({
    name: 'Purple',
    type: 'linear',
    colors: [new Color({ hex: '#9b51e0' }), new Color({ hex: '#652dff' })],
  }),
  new Gradient({
    name: 'Red',
    type: 'linear',
    colors: [new Color({ hex: '#ff2d55' }), new Color({ hex: '#b312f2' })],
  }),
  new Gradient({
    name: 'Pink',
    type: 'linear',
    colors: [new Color({ hex: '#ff2d73' }), new Color({ hex: '#ff2d2d' })],
  }),
  new Gradient({
    name: 'Minty',
    type: 'linear',
    colors: [new Color({ hex: '#00ce59' }), new Color({ hex: '#00bcd4' })],
  }),
  new Gradient({
    name: 'Lime',
    type: 'linear',
    colors: [new Color({ hex: '#00ce59' }), new Color({ hex: '#ebe834' })],
  }),
  new Gradient({
    name: 'Meshy',
    type: 'mesh',
    colors: [
      new Color({ hex: '#ff0066' }),
      new Color({ hex: '#1aecad' }),
      new Color({ hex: '#6b37ed' }),
      new Color({ hex: '#db5be4' }),
      new Color({ hex: '#8400ff' }),
      new Color({ hex: '#9fb1ec' }),
      new Color({ hex: '#aa9b9b' }),
      new Color({ hex: '#4d5054' }),
      new Color({ hex: '#50dc88' }),
    ],
  }),
  new Gradient({
    name: 'Redish',
    type: 'mesh',
    colors: [
      new Color({ hex: '#ff2d55' }),
      new Color({ hex: '#b312f2' }),
      new Color({ hex: '#ff2d73' }),
      new Color({ hex: '#ff2d2d' }),
      new Color({ hex: '#ff8b2d' }),
      new Color({ hex: '#ff2d99' }),
      new Color({ hex: '#b92657' }),
      new Color({ hex: '#e78dab' }),
      new Color({ hex: '#d3a555' }),
    ],
  }),
];

function normalizeName(name: string) {
  return name.toLowerCase().replace(/\s/g, '').trim();
}

export function gradientFor(nameOrColors: string): Gradient {
  if (nameOrColors.startsWith('#')) {
    return new Gradient({
      name: 'Custom',
      type: 'linear',
      colors: nameOrColors.split(',').map((hex) => new Color({ hex })),
    });
  } else {
    return gradients.find(
      (scheme) => normalizeName(scheme.name) === normalizeName(nameOrColors),
    );
  }
}
