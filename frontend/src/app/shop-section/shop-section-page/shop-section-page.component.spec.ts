import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ShopSectionPageComponent } from './shop-section-page.component';

describe('ShopSectionPageComponent', () => {
  let component: ShopSectionPageComponent;
  let fixture: ComponentFixture<ShopSectionPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ShopSectionPageComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ShopSectionPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
