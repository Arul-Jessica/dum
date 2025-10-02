// src/app/features/user/services/asset-price.service.ts
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { delay } from 'rxjs/operators';

export interface PricePoint {
  timestamp: Date;
  price: number;
  volume?: number;
}

export interface AssetPriceData {
  assetId: string;
  assetName: string;
  currentPrice: number;
  priceChange24h: number;
  priceChangePercentage: number;
  history: PricePoint[];
}

@Injectable({
  providedIn: 'root'
})
export class AssetPriceService {
  
  private readonly ASSETS = [
    { id: 'ASSET-001', name: 'Gold Token', basePrice: 1850 },
    { id: 'ASSET-002', name: 'Silver Token', basePrice: 24 },
    { id: 'ASSET-003', name: 'Real Estate Token', basePrice: 5000 },
    { id: 'ASSET-004', name: 'Art Token', basePrice: 12500 }
  ];

  constructor() {}

  /**
   * Generate mock historical price data for an asset
   */
  private generatePriceHistory(
    basePrice: number, 
    days: number = 30
  ): PricePoint[] {
    const history: PricePoint[] = [];
    const now = new Date();
    let currentPrice = basePrice * 0.95; // Start 5% lower

    for (let i = days; i >= 0; i--) {
      const timestamp = new Date(now);
      timestamp.setDate(timestamp.getDate() - i);
      
      // Random walk with slight upward bias
      const change = (Math.random() - 0.48) * basePrice * 0.02;
      currentPrice = Math.max(currentPrice + change, basePrice * 0.8);
      
      const volume = Math.floor(Math.random() * 1000) + 100;

      history.push({
        timestamp,
        price: parseFloat(currentPrice.toFixed(2)),
        volume
      });
    }

    return history;
  }

  /**
   * Get price data for a specific asset
   */
  getAssetPriceData(assetId: string, days: number = 30): Observable<AssetPriceData> {
    const asset = this.ASSETS.find(a => a.id === assetId);
    
    if (!asset) {
      throw new Error(`Asset ${assetId} not found`);
    }

    const history = this.generatePriceHistory(asset.basePrice, days);
    const currentPrice = history[history.length - 1].price;
    const previousPrice = history[history.length - 2].price;
    const priceChange24h = currentPrice - previousPrice;
    const priceChangePercentage = (priceChange24h / previousPrice) * 100;

    const priceData: AssetPriceData = {
      assetId: asset.id,
      assetName: asset.name,
      currentPrice,
      priceChange24h,
      priceChangePercentage,
      history
    };

    return of(priceData).pipe(delay(500)); // Simulate API delay
  }

  /**
   * Get price data for all assets
   */
  getAllAssetsPriceData(days: number = 30): Observable<AssetPriceData[]> {
    const allData = this.ASSETS.map(asset => {
      const history = this.generatePriceHistory(asset.basePrice, days);
      const currentPrice = history[history.length - 1].price;
      const previousPrice = history[history.length - 2].price;
      const priceChange24h = currentPrice - previousPrice;
      const priceChangePercentage = (priceChange24h / previousPrice) * 100;

      return {
        assetId: asset.id,
        assetName: asset.name,
        currentPrice,
        priceChange24h,
        priceChangePercentage,
        history
      };
    });

    return of(allData).pipe(delay(500));
  }

  /**
   * Get available assets list
   */
  getAvailableAssets(): Observable<Array<{id: string, name: string}>> {
    return of(this.ASSETS.map(a => ({ id: a.id, name: a.name })));
  }

  /**
   * Get real-time price (simulated)
   */
  getRealTimePrice(assetId: string): Observable<number> {
    const asset = this.ASSETS.find(a => a.id === assetId);
    if (!asset) {
      throw new Error(`Asset ${assetId} not found`);
    }

    // Simulate price fluctuation
    const variation = (Math.random() - 0.5) * asset.basePrice * 0.01;
    const price = asset.basePrice + variation;
    
    return of(parseFloat(price.toFixed(2))).pipe(delay(100));
  }
}