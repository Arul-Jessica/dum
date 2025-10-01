import { AfterViewInit, Component, ElementRef, OnDestroy, ViewChild } from '@angular/core';
import { Chart, ChartConfiguration, registerables } from 'chart.js';
import { Subscription } from 'rxjs';
import { MockTradeService, Tick } from '../../services/mock-trade.service';

Chart.register(...registerables);

@Component({
  selector: 'app-live-price-chart',
  templateUrl: './live-price-chart.component.html'
})
export class LivePriceChartComponent implements AfterViewInit, OnDestroy {
  @ViewChild('lineCanvas', { static: true }) canvas!: ElementRef<HTMLCanvasElement>;
  chart!: Chart;
  sub!: Subscription;
  maxPoints = 120;

  lastTrades: Tick[] = [];
  maxTrades = 20;

  constructor(private mock: MockTradeService) {}

  ngAfterViewInit(): void {
    const ctx = this.canvas.nativeElement.getContext('2d')!;
    const cfg: ChartConfiguration<'line'> = {
      type: 'line',
      data: { labels: [], datasets: [{ label: 'Price', data: [], tension: 0.2, pointRadius: 0 }] },
      options: { animation: false, responsive: true, scales: { x: {}, y: {} }, plugins: { legend: { display: false } } }
    };
    this.chart = new Chart(ctx, cfg);

    // seed initial historical data
    this.mock.history(60, 500).forEach(t => this.pushTick(t));

    // subscribe to live ticks
    this.sub = this.mock.trades$.subscribe(tick => this.onTick(tick));
  }

  onTick(t: Tick) {
    this.pushTick(t);
    this.chart.update('none');

    // update trade tape
    this.lastTrades.unshift(t);
    if (this.lastTrades.length > this.maxTrades) this.lastTrades.pop();
  }

  pushTick(t: Tick) {
    const labels = this.chart.data.labels as any[];
    const ds = this.chart.data.datasets[0].data as any[];
    labels.push(new Date(t.ts).toLocaleTimeString());
    ds.push(t.price);
    if (labels.length > this.maxPoints) { labels.shift(); ds.shift(); }
  }

  ngOnDestroy(): void {
    this.sub?.unsubscribe();
    this.chart?.destroy();
  }
}
