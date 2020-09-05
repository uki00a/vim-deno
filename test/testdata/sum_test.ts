import { sum } from "./sum.ts";

Deno.test({
  name: "sum()",
  fn() {
    const expected = 7;
    const actual = sum(1, 2, 4);
    if (expected !== actual) {
      throw new Error(`${expected} expected, but got ${actual}`);
    }
  }
});
