// make sure the value only contains numbers, space or +
export function validatePhone(value?: string): boolean {
  const regex = /^[0-9\s+]*$/;
  return regex.test(value);
}
