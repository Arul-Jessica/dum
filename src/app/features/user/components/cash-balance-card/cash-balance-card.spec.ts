import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CashBalanceCard } from './cash-balance-card';

describe('CashBalanceCard', () => {
  let component: CashBalanceCard;
  let fixture: ComponentFixture<CashBalanceCard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CashBalanceCard]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CashBalanceCard);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
