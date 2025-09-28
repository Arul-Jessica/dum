import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'abbreviateNumber',
  standalone: true // Modern pipes are standalone
})
export class AbbreviateNumberPipe implements PipeTransform {

  transform(value: number, ...args: unknown[]): string {
    if (value === null || value === undefined) return '';
    if (value < 1000) return value.toString();

    // Logic to convert to K (thousands), M (millions), B (billions)
    const suffixes = ['K', 'M', 'B', 'T'];
    const suffixNum = Math.floor(Math.log10(value) / 3);
    const shortValue = (value / Math.pow(1000, suffixNum)).toFixed(2);
    
    // Remove trailing .00
    return shortValue.replace(/\.00$/, '') + suffixes[suffixNum - 1];
  }
}