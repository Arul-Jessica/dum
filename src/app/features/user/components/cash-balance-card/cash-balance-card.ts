import { Component, Input } from '@angular/core';
import { CommonModule, CurrencyPipe } from '@angular/common'; // Import CurrencyPipe
import { CashBalance } from '../../models/user-dashboard.model';

@Component({
  selector: 'app-cash-balance-card',
  standalone: true,
  imports: [CommonModule, CurrencyPipe], // Add CurrencyPipe
  templateUrl: './cash-balance-card.component.html',
  styleUrls: ['./cash-balance-card.component.scss']
})
export class CashBalanceCardComponent {
  @Input() cashBalances: CashBalance[] = [];
}