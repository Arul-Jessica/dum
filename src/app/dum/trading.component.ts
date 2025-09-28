import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ToastrService } from 'ngx-toastr';
import { PlaceOrderFormComponent } from './components/place-order-form/place-order-form.component';
import { TradingService } from './services/trading.service';
import { AuthService } from '../../core/services/auth.service';
import { PlaceOrderRequest } from './models/trading.model';

@Component({
  selector: 'app-trading',
  standalone: true,
  imports: [CommonModule, PlaceOrderFormComponent],
  templateUrl: './trading.component.html',
  styleUrls: ['./trading.component.scss']
})
export class TradingComponent {

  constructor(
    private tradingService: TradingService,
    private authService: AuthService,
    private toastr: ToastrService
  ) {}

  // This method is the event handler for the child form's 'orderPlaced' event.
  handlePlaceOrder(request: PlaceOrderRequest): void {
    const partyId = this.authService.getUserPartyId();
    if (!partyId) {
      this.toastr.error("Could not place order: User is not properly authenticated.", "Authentication Error");
      return;
    }

    // Replace the placeholder partyId with the real one from the logged-in user.
    request.partyId = partyId;

    this.tradingService.placeOrder(request).subscribe({
      next: (response) => {
        this.toastr.success(`Order placed successfully! Order ID: ${response.id}`, 'Success');
        // In a real app, we would now refresh the user's order history list.
      },
      error: (err) => {
        // We display the actual error message from the backend.
        this.toastr.error(err.error?.message || 'An unknown error occurred.', 'Order Failed');
      }
    });
  }
}