export function sum(...numbers: number[]): number {
  return numbers.reduce((sum, x) => sum + x, 0);
}
