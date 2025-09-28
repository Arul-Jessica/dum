import { Directive, ElementRef, Input, OnChanges, Renderer2, SimpleChanges } from '@angular/core';

@Directive({
  selector: '[appHighlightOnValue]', // This is how we'll use it in our HTML
  standalone: true,
})
export class HighlightOnValueDirective implements OnChanges {
  // This allows us to pass a number to the directive, e.g., [appHighlightOnValue]="balance.amount"
  @Input('appHighlightOnValue') value: number = 0;

  constructor(private el: ElementRef, private renderer: Renderer2) {}

  // This lifecycle hook runs whenever an @Input property changes.
  ngOnChanges(changes: SimpleChanges): void {
    if (changes['value']) {
      this.updateColor();
    }
  }

  private updateColor(): void {
    // Remove any existing color classes to avoid conflicts
    this.renderer.removeClass(this.el.nativeElement, 'text-success');
    this.renderer.removeClass(this.el.nativeElement, 'text-danger');
    this.renderer.removeClass(this.el.nativeElement, 'text-muted');

    // Apply the new color class based on the value
    if (this.value > 0) {
      this.renderer.addClass(this.el.nativeElement, 'text-success'); // Bootstrap's green text class
    } else if (this.value < 0) {
      this.renderer.addClass(this.el.nativeElement, 'text-danger'); // Bootstrap's red text class
    } else {
      this.renderer.addClass(this.el.nativeElement, 'text-muted'); // Bootstrap's grey text class
    }
  }
}
