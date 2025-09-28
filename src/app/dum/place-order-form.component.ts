import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { CommonModule } from '@angular/common';
// Import the necessary modules for Reactive Forms
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { PlaceOrderRequest } from '../../models/trading.model';

@Component({
  selector: 'app-place-order-form',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule], // Add ReactiveFormsModule here
  templateUrl: './place-order-form.component.html',
  styleUrls: ['./place-order-form.component.scss']
})
export class PlaceOrderFormComponent implements OnInit {
  // @Output is how a child component sends data UP to its parent.
  // We are creating an event named 'orderPlaced'.
  @Output() orderPlaced = new EventEmitter<PlaceOrderRequest>();

  orderForm!: FormGroup; // The '!' tells TypeScript it will be initialized in ngOnInit.
  isSubmitting = false;

  // We inject FormBuilder, a helper service for creating forms.
  constructor(private fb: FormBuilder) { }

  ngOnInit(): void {
    // We define the form's controls and their validation rules here.
    this.orderForm = this.fb.group({
      assetId: [1, Validators.required], // Hardcoded to Asset ID 1 for now.
      orderType: ['BUY', Validators.required],
      quantity: [null, [Validators.required, Validators.min(0.000001)]],
      price: [null, [Validators.required, Validators.min(0.01)]]
    });
  }

  // A helper "getter" to make accessing form controls in our HTML template easier.
  get formControls() {
    return this.orderForm.controls;
  }

  onSubmit(): void {
    // If the form is invalid, we mark all fields as "touched" to show the user the errors.
    if (this.orderForm.invalid) {
      this.orderForm.markAllAsTouched();
      return;
    }

    this.isSubmitting = true;
    
    // We get the raw value from the form.
    const formValue = this.orderForm.value;
    
    // We build the request object. The partyId is a placeholder
    // because the parent component is responsible for knowing the current user.
    const request: PlaceOrderRequest = {
      partyId: 0, // Placeholder - parent will fill this in!
      assetId: formValue.assetId,
      orderType: formValue.orderType,
      quantity: formValue.quantity,
      price: formValue.price
    };
    
    // We emit the 'orderPlaced' event, sending the request object as the payload.
    this.orderPlaced.emit(request);

    // After emitting, we can reset the form.
    // In a real app, we might wait for a success signal from the parent.
    this.orderForm.reset({ assetId: 1, orderType: 'BUY' });
    this.isSubmitting = false;
  }
}