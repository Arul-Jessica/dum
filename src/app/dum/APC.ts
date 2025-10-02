// src/app/features/user/components/asset-price-chart/asset-price-chart.component.ts
import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AssetPriceService, AssetPriceData } from '../../services/asset-price.service';
import { Subject, interval } from 'rxjs';
import { takeUntil, switchMap } from 'rxjs/operators';

@Component({
  selector: 'app-asset-price-chart',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './asset-price-chart.component.html',
  styleUrls: ['./asset-price-chart.component.scss']
})
export class AssetPriceChartComponent implements OnInit, OnDestroy {
  selectedAssetId: string = 'ASSET-001';
  selectedTimeframe: '7d' | '30d' | '90d' = '30d';
  assetPriceData: AssetPriceData | null = null;
  availableAssets: Array<{id: string, name: string}> = [];
  loading: boolean = false;
  
  private destroy$ = new Subject<void>();

  constructor(private assetPriceService: AssetPriceService) {}

  ngOnInit(): void {
    this.loadAvailableAssets();
    this.loadPriceData();
    this.startRealTimeUpdates();
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  loadAvailableAssets(): void {
    this.assetPriceService.getAvailableAssets()
      .pipe(takeUntil(this.destroy$))
      .subscribe(assets => {
        this.availableAssets = assets;
      });
  }

  loadPriceData(): void {
    this.loading = true;
    const days = this.getTimeframeDays();
    
    this.assetPriceService.getAssetPriceData(this.selectedAssetId, days)
      .pipe(takeUntil(this.destroy$))
      .subscribe(data => {
        this.assetPriceData = data;
        this.loading = false;
      });
  }

  startRealTimeUpdates(): void {
    // Update current price every 5 seconds
    interval(5000)
      .pipe(
        takeUntil(this.destroy$),
        switchMap(() => this.assetPriceService.getRealTimePrice(this.selectedAssetId))
      )
      .subscribe(newPrice => {
        if (this.assetPriceData) {
          this.assetPriceData.currentPrice = newPrice;
          // Update the last history point
          const lastPoint = this.assetPriceData.history[this.assetPriceData.history.length - 1];
          this.assetPriceData.priceChange24h = newPrice - lastPoint.price;
          this.assetPriceData.priceChangePercentage = 
            (this.assetPriceData.priceChange24h / lastPoint.price) * 100;
        }
      });
  }

  onAssetChange(assetId: string): void {
    this.selectedAssetId = assetId;
    this.loadPriceData();
  }

  onTimeframeChange(timeframe: '7d' | '30d' | '90d'): void {
    this.selectedTimeframe = timeframe;
    this.loadPriceData();
  }

  getTimeframeDays(): number {
    switch (this.selectedTimeframe) {
      case '7d': return 7;
      case '30d': return 30;
      case '90d': return 90;
      default: return 30;
    }
  }

  getChartPoints(): string {
    if (!this.assetPriceData) return '';

    const history = this.assetPriceData.history;
    const width = 800;
    const height = 300;
    const padding = 40;

    const prices = history.map(p => p.price);
    const minPrice = Math.min(...prices);
    const maxPrice = Math.max(...prices);
    const priceRange = maxPrice - minPrice;

    const points = history.map((point, index) => {
      const x = padding + (index / (history.length - 1)) * (width - 2 * padding);
      const y = height - padding - ((point.price - minPrice) / priceRange) * (height - 2 * padding);
      return `${x},${y}`;
    }).join(' ');

    return points;
  }

  getGridLines(): number[] {
    return [0, 1, 2, 3, 4];
  }

  formatPrice(price: number): string {
    return `$${price.toFixed(2)}`;
  }

  formatPercentage(percentage: number): string {
    const sign = percentage >= 0 ? '+' : '';
    return `${sign}${percentage.toFixed(2)}%`;
  }

  isPriceUp(): boolean {
    return this.assetPriceData ? this.assetPriceData.priceChange24h >= 0 : false;
  }
}