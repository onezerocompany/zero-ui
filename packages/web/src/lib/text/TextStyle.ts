export class TextStyle {
  category: string;
  name: string;

  fontFamily: string;
  fontSize: number;
  fontWeight: number;
  color: string;

  lineHeight: number;
  letterSpacing: number;

  get cssVars() {
    return {
      '--font-family': this.fontFamily,
      '--font-size': `${this.fontSize}rem`,
      '--font-weight': `${this.fontWeight}`,
      '--line-height': `${this.lineHeight}`,
      '--letter-spacing': `${this.letterSpacing}rem`,
      '--text-color': this.color,
    };
  }

  constructor(
    metadata = {
      category: 'regular',
      name: 'Default',
      fontFamily: 'Inter',
      fontSize: 1,
      fontWeight: 500,
      color: 'var(--color-text-primary, #000)',
      lineHeight: 1,
      letterSpacing: 0,
    },
  ) {
    this.category = metadata.category;
    this.name = metadata.name;
    this.fontFamily = metadata.fontFamily;
    this.fontSize = metadata.fontSize;
    this.fontWeight = metadata.fontWeight;
    this.color = metadata.color;
    this.lineHeight = metadata.lineHeight;
    this.letterSpacing = metadata.letterSpacing;
  }
}
