import { Color } from './Color';

const locations = [
  '0% 0%',
  '100% 0%',
  '0% 100%',
  '100% 100%',
  '40% 40%',
  '60% 10%',
  '32% 40%',
  '60% 120%',
  '44% 80%',
];

export class Gradient {
  public readonly name: string;
  public readonly type: 'linear' | 'mesh';
  public readonly colors: Color[];

  public get cssBackground() {
    if (this.type === 'linear') {
      return `linear-gradient(to right, ${this.colors
        .map((c) => c.hex)
        .join(', ')})`;
    } else {
      return this.colors
        .map((color, index) => {
          return `radial-gradient(circle at ${locations[index]}, ${color.hex} 0px, transparent 50%)`;
        })
        .join(', ');
    }
  }

  constructor(metadata: {
    type: 'linear' | 'mesh';
    name: string;
    colors: Color[];
  }) {
    this.type = metadata.type;
    this.name = metadata.name;
    this.colors = metadata.colors;
  }
}
