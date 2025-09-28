import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TokenBalanceCard } from './token-balance-card';

describe('TokenBalanceCard', () => {
  let component: TokenBalanceCard;
  let fixture: ComponentFixture<TokenBalanceCard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TokenBalanceCard]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TokenBalanceCard);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
