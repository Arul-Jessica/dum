import { Component, Input } from '@angular/core';
import { CommonModule, DecimalPipe } from '@angular/common'; // Import DecimalPipe
import { TokenBalance } from '../../models/user-dashboard.model';

@Component({
  selector: 'app-token-balance-card',
  standalone: true,
  imports: [CommonModule, DecimalPipe], // Add DecimalPipe
  templateUrl: './token-balance-card.component.html',
  styleUrls: ['./token-balance-card.component.scss']
})
export class TokenBalanceCardComponent {
  @Input() tokenBalances: TokenBalance[] = [];
}