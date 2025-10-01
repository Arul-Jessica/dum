import { Injectable } from '@angular/core';
import { BehaviorSubject, interval, Observable } from 'rxjs';
import { map } from 'rxjs/operators';

export interface Tick {
  ts: number;
  price: number;
  size: number;
  side?: 'buy' | 'sell';
}

@Injectable({ providedIn: 'root' })
export class MockTradeService {
  private basePrice = 100;
  private tick$ = new BehaviorSubject<Tick>(this.makeTick());

  // observable for components to subscribe
  trades$: Observable<Tick> = this.tick$.asObservable();

  constructor() {
    // generate a new tick every 500ms
    interval(500)
      .pipe(map(() => this.makeTick()))
      .subscribe(t => this.tick$.next(t));
  }

  private makeTick(): Tick {
    const change = (Math.random() - 0.5) * 0.4; // random walk
    this.basePrice = Math.max(0.1, this.basePrice + change);
    return {
      ts: Date.now(),
      price: Math.round(this.basePrice * 100) / 100,
      size: Math.round(Math.random() * 100 + 1),
      side: Math.random() > 0.5 ? 'buy' : 'sell',
    };
  }

  // optional: generate initial historical ticks for chart
  history(count = 60, intervalMs = 500): Tick[] {
    let p = this.basePrice;
    const arr: Tick[] = [];
    for (let i = 0; i < count; i++) {
      const change = (Math.random() - 0.5) * 0.4;
      p = Math.max(0.1, p + change);
      arr.push({
        ts: Date.now() - (count - i) * intervalMs,
        price: Math.round(p * 100) / 100,
        size: Math.round(Math.random() * 100) + 1,
        side: Math.random() > 0.5 ? 'buy' : 'sell',
      });
    }
    return arr;
  }
}
