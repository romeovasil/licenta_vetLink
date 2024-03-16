import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ShopItemCardComponent } from './shop-item-card.component';

describe('ShopItemCardComponent', () => {
  let component: ShopItemCardComponent;
  let fixture: ComponentFixture<ShopItemCardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ShopItemCardComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ShopItemCardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
