import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { WalletBalanceResponse } from '../models/user-dashboard.model';

@Injectable({
  providedIn: 'root'
})
export class WalletService {
  private apiUrl = `${environment.apiUrl}/api/wallets`;

  constructor(private http: HttpClient) { }

  getBalances(partyId: number): Observable<WalletBalanceResponse> {
    return this.http.get<WalletBalanceResponse>(`${this.apiUrl}/${partyId}/balances`);
  }
}