import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { WalletService } from '../../services/wallet.service';
import { WalletBalanceResponse } from '../../models/user-dashboard.model';
import { AuthService } from '../../../../core/services/auth.service';
import { CashBalanceCardComponent } from '../../components/cash-balance-card/cash-balance-card.component';
import { TokenBalanceCardComponent } from '../../components/token-balance-card/token-balance-card.component';

@Component({
  selector: 'app-user-dashboard',
  standalone: true,
  imports: [CommonModule, CashBalanceCardComponent, TokenBalanceCardComponent],
  templateUrl: './user-dashboard.component.html',
  styleUrls: ['./user-dashboard.component.scss']
})
export class UserDashboardComponent implements OnInit {
  
  balances?: WalletBalanceResponse;
  isLoading = true;
  errorMessage = '';
  currentUserName: string | null = '';

  constructor(
    private walletService: WalletService,
    public authService: AuthService
  ) { }

  ngOnInit(): void {
    this.currentUserName = this.authService.getUserName();
    // The claim in your JWT is 'userId', which we will use as the partyId.
    const partyId = this.authService.getUserPartyId();

    if (partyId) {
      this.loadBalances(partyId);
    } else {
      this.errorMessage = "Could not identify user from authentication token.";
      this.isLoading = false;
    }
  }

  loadBalances(partyId: number): void {
    this.isLoading = true;
    this.walletService.getBalances(partyId).subscribe({
      next: (data) => {
        this.balances = data;
        this.isLoading = false;
      },
      error: (err) => {
        console.error('Failed to fetch balances', err);
        this.errorMessage = 'Could not load wallet balances from the server.';
        this.isLoading = false;
      }
    });
  }
}