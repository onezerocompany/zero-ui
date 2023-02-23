import { TextStyle } from './TextStyle';

export const styles: TextStyle[] = [
  new TextStyle({
    category: 'content',
    name: 'Paragraph',
    fontFamily: 'Vollkorn',
    fontSize: 1.28,
    fontWeight: 500,
    color: 'var(--color-text, #000)',
    lineHeight: 1.3,
    letterSpacing: 0.03,
  }),
  new TextStyle({
    category: 'regular',
    name: 'Footnote',
    fontFamily: 'Vollkorn',
    fontSize: 0.9,
    fontWeight: 600,
    color: 'var(--color-text-secondary, #000)',
    lineHeight: 1,
    letterSpacing: 0.06,
  }),
];

function normalizeStyleName(styleName: string) {
  return styleName.trim().replace(/\s+/g, '-').toLowerCase();
}

export function styleForName(styleName: string) {
  return (
    styles.find(
      (style) =>
        normalizeStyleName(style.name) === normalizeStyleName(styleName),
    ) ?? new TextStyle()
  );
}

// add the heading styles

const subSizeMultiplier: { [key: string]: number } = {
  'Pre-Heading': 0.4,
  'Heading': 1,
  'Sub-Heading': 0.6,
};

const subSizeColor: { [key: string]: string } = {
  'Pre-Heading': 'var(--color-text-tertiary)',
  'Heading': 'var(--color-text-primary)',
  'Sub-Heading': 'var(--color-text-secondary)',
};

for (const size of [1, 2, 3, 4, 5, 6]) {
  for (const subSize of ['Pre-Heading', 'Heading', 'Sub-Heading']) {
    if (
      [5, 6].includes(size) &&
      ['Pre-Heading', 'Sub-Heading'].includes(subSize)
    )
      continue;
    const style = new TextStyle();
    style.category = 'heading';
    style.name = `${subSize} ${size}`;
    style.fontFamily = 'Inter';
    style.fontSize = (3.25 - size * 0.35) * subSizeMultiplier[subSize];
    style.fontWeight = 700;
    style.lineHeight = 1;
    style.letterSpacing = -0.02;
    style.color = subSizeColor[subSize];
    styles.push(style);
  }
}

// add the display styles
for (const size of [1, 2, 3, 4]) {
  const style = new TextStyle();
  style.category = 'display';
  style.name = `Display ${size}`;
  style.fontFamily = 'Inter';
  style.fontSize = 6 - size * 0.5;
  style.fontWeight = 700;
  style.lineHeight = 1;
  style.letterSpacing = -0.02;
  style.color = 'var(--color-text-primary)';
  styles.push(style);
}
