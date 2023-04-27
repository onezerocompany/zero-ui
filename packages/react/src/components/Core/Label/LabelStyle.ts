enum LabelCategory {
  displayHeading = 'displayHeading',
  heading = 'heading',
  subheading = 'subheading',
  content = 'content',
  caption = 'caption',
}

const categoryTags: Record<LabelCategory, string> = {
  [LabelCategory.displayHeading]: 'h1',
  [LabelCategory.heading]: 'h2',
  [LabelCategory.subheading]: 'h3',
  [LabelCategory.content]: 'p',
  [LabelCategory.caption]: 'p',
};

enum LabelSize {
  large = 'large',
  medium = 'medium',
  small = 'small',
}

interface StyleParameters {
  tag: string;
  fontSize: number;
  fontWeight: number;
  lineHeight: number;
  letterSpacing: number;
}

interface LabelStyle {
  id: string;
  category: LabelCategory;
  size: LabelSize;
  parameters: StyleParameters;
  tag: string;
}

function pointOnCurve({
  index,
  numStyles,
  maxSize,
  minSize,
  exponent,
}: {
  index: number;
  numStyles: number;
  maxSize: number;
  minSize: number;
  exponent: number;
}): number {
  const item = 1 - index / (numStyles - 1);
  const size = minSize + item ** exponent * (maxSize - minSize);
  return size;
}

const smallestSize = 14;
const largestSize = 72;
const maxWeight = 900;
const minWeight = 400;

function parametersFor({
  index,
  total,
}: {
  index: number;
  total: number;
}): StyleParameters {
  const fontSize = pointOnCurve({
    index,
    numStyles: total,
    maxSize: largestSize,
    minSize: smallestSize,
    exponent: 2.8,
  });

  const fontWeight = pointOnCurve({
    index,
    numStyles: total,
    maxSize: maxWeight,
    minSize: minWeight,
    exponent: 2.8,
  });

  const letterSpacing = pointOnCurve({
    index,
    numStyles: total,
    maxSize: 2,
    minSize: 1.2,
    exponent: 1,
  });

  const lineHeight = pointOnCurve({
    index,
    numStyles: total,
    maxSize: 1.1,
    minSize: 1.7,
    exponent: 1,
  });

  return {
    tag: 'p',
    fontSize,
    fontWeight,
    lineHeight,
    letterSpacing,
  };
}

function createStyles(): LabelStyle[] {
  const styles: LabelStyle[] = [];
  const categories = Object.values(LabelCategory);
  const sizes = Object.values(LabelSize);
  const total = categories.length * sizes.length;

  for (const category of categories) {
    for (const size of sizes) {
      const id = `${category}-${size}`;
      const parameters = parametersFor({ index: styles.length, total });
      const tag = categoryTags[category as LabelCategory];
      styles.push({ id, category, size, parameters, tag });
    }
  }

  return styles;
}

const labelStyles = createStyles();

export type { LabelStyle };
export { LabelCategory, LabelSize, labelStyles };
