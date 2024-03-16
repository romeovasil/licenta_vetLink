import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddShopItemPopupComponent } from './add-shop-item-popup.component';

describe('AddShopItemPopupComponent', () => {
  let component: AddShopItemPopupComponent;
  let fixture: ComponentFixture<AddShopItemPopupComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddShopItemPopupComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddShopItemPopupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
