/* eslint-disable max-depth */
// Unflatten an object with keys like 'a.b.c' into {a: {b: {c: ...}}}
export function unflatten(
  object: Record<string, unknown>,
): Record<string, unknown> {
  const result: Record<string, unknown> = {};
  for (const itemKey in object) {
    if (Object.hasOwnProperty.call(object, itemKey)) {
      const keys = itemKey.split('.');
      let ref = result;
      while (keys.length > 1) {
        const key = keys.shift();
        if (!ref[key]) {
          ref[key] = {};
        }
        ref = ref[key];
      }
      ref[keys[0]] = object[itemKey];
    }
  }
  return result;
}
