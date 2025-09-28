// File: src/app/features/user/models/user-dashboard.model.ts
export interface CashBalance {
  walletId: number;
  currency: string;
  amount: number;
}

export interface TokenBalance {
  walletId: number;
  assetId: number;
  assetSymbol: string;
  quantity: number;
}

export interface WalletBalanceResponse {
  cashBalances: CashBalance[];
  tokenBalances: TokenBalance[];
}
