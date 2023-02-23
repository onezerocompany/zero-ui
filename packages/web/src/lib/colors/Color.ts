export class Color {
  public readonly red: number;
  public readonly green: number;
  public readonly blue: number;

  static black = new Color({ hex: '#000000' });
  static offBlack = new Color({ hex: '#0e0e0e' });
  static white = new Color({ hex: '#ffffff' });

  public get brightness(): number {
    return (this.red * 299 + this.green * 587 + this.blue * 114) / 1000;
  }

  public get textColor(): Color {
    return this.brightness > 175 ? Color.black : Color.white;
  }

  public get inputBlend(): number {
    return this.brightness > 200 ? 0.7 : 0.05;
  }

  public get scaffoldBlend(): number {
    return Math.max(0, Math.min(1, 1 - this.brightness / 255));
  }

  // merge two colors by morphing one color into another at a given ratio
  public blend(color: Color, amount: number): Color {
    return new Color({
      red: this.red + (color.red - this.red) * amount,
      green: this.green + (color.green - this.green) * amount,
      blue: this.blue + (color.blue - this.blue) * amount,
    });
  }

  public get hex(): string {
    let red = this.red.toString(16).padStart(2, '0');
    let green = this.green.toString(16).padStart(2, '0');
    let blue = this.blue.toString(16).padStart(2, '0');
    return `#${red}${green}${blue}`;
  }

  public get rgb(): string {
    return `${this.red}, ${this.green}, ${this.blue}`;
  }

  private static colorFromHex(hex: string): Color {
    const hexWithoutHash = hex.replace('#', '').trim();
    if (hexWithoutHash.length === 6) {
      const regex = /^([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/i;
      return new Color({
        red: parseInt(hexWithoutHash.match(regex)[1], 16),
        green: parseInt(hexWithoutHash.match(regex)[2], 16),
        blue: parseInt(hexWithoutHash.match(regex)[3], 16),
      });
    } else if (hexWithoutHash.length === 3) {
      const regex = /^([0-9a-f])([0-9a-f])([0-9a-f])$/i;
      return new Color({
        red: parseInt(hexWithoutHash.match(regex)[1], 16) * 17,
        green: parseInt(hexWithoutHash.match(regex)[2], 16) * 17,
        blue: parseInt(hexWithoutHash.match(regex)[3], 16) * 17,
      });
    }
    throw new Error(`Invalid color hex: ${hex}`);
  }

  private static clamp(value: number) {
    return Math.round(Math.max(0, Math.min(255, value)));
  }

  public constructor(input: {
    hex?: string;
    red?: number;
    green?: number;
    blue?: number;
  }) {
    if (input.hex) {
      const color = Color.colorFromHex(input.hex);
      this.red = color.red;
      this.green = color.green;
      this.blue = color.blue;
    } else {
      this.red = Color.clamp(input.red ?? 0);
      this.green = Color.clamp(input.green ?? 0);
      this.blue = Color.clamp(input.blue ?? 0);
    }
  }
}
