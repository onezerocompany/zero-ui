function luminance(hexColor: string): number {
  const hexSubstringStart = 1;
  const hexStringLength = 2;
  const maxRgbValue = 255;
  const sRGBThreshold = 0.03928;
  const sRGBDivider = 12.92;
  const sRGBOffset = 0.055;
  const sRGBScale = 1.055;
  const gamma = 2.4;
  const lumR = 0.2126;
  const lumG = 0.7152;
  const lumB = 0.0722;

  const rgb = hexColor
    .substring(hexSubstringStart)
    .match(new RegExp(`.{${hexStringLength}}`, 'gu'))
    ?.map((hex) => parseInt(hex, 16));

  if (!rgb) {
    throw new Error('Invalid hex color');
  }

  const [red, green, blue] = rgb.map((hex) => {
    const value = hex / maxRgbValue;
    return value <= sRGBThreshold
      ? value / sRGBDivider
      : ((value + sRGBOffset) / sRGBScale) ** gamma;
  });

  return lumR * (red ?? 0) + lumG * (green ?? 0) + lumB * (blue ?? 0);
}

function adjustBrightness(hexColor: string, factor: number): string {
  const hexSubstringStart = 1;
  const hexStringLength = 2;
  const maxRgbValue = 255;
  const minRgbValue = 0;

  const rgb = hexColor
    .substring(hexSubstringStart)
    .match(new RegExp(`.{${hexStringLength}}`, 'gu'))
    ?.map((hex) => parseInt(hex, 16));

  if (!rgb) {
    throw new Error('Invalid hex color');
  }

  const [red, green, blue] = rgb.map((characters) => {
    const adjusted = Math.round(characters * factor);
    const radix = 16;
    return Math.min(maxRgbValue, Math.max(minRgbValue, adjusted))
      .toString(radix)
      .padStart(hexStringLength, '0');
  });

  return `#${red ?? '00'}${green ?? '00'}${blue ?? '00'}`;
}

export function textColorForBackground(backgroundColor: string): string {
  const luminanceThreshold = 0.5;
  const darkFactor = 0.3;
  const lightFactor = 18;
  const lum = luminance(backgroundColor);
  const factor = lum > luminanceThreshold ? darkFactor : lightFactor;
  const textColor = adjustBrightness(backgroundColor, factor);

  return textColor;
}
