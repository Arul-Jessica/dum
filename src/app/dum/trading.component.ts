// In trading.component.ts
import { TransferFormComponent } from './components/transfer-form/transfer-form.component';
import { TransferRequest } from './models/trading.model';

@Component({
  //...
  imports: [CommonModule, PlaceOrderFormComponent, OpenOrdersTableComponent, TransferFormComponent], // <-- Add TransferFormComponent
})
export class TradingComponent implements OnInit {
  //... (existing properties and methods)

  // Event handler for the new transfer form
  handleTransfer(request: Omit<TransferRequest, 'fromPartyId'>): void {
    const fromPartyId = this.authService.getUserPartyId();
    if (!fromPartyId) {
      this.toastr.error("Cannot perform transfer: User not authenticated.", "Error");
      return;
    }

    // Complete the request object with the sender's ID
    const fullRequest: TransferRequest = { ...request, fromPartyId };

    this.tradingService.transferTokens(fullRequest).subscribe({
      next: () => {
        this.toastr.success('Tokens transferred successfully!', 'Success');
        // We should refresh the main dashboard data after a transfer
        // We'll add this later if we create a shared data service.
      },
      error: (err) => {
        this.toastr.error(err.error?.message || 'Transfer failed.', 'Error');
      }
    });
  }
}