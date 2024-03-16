import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SubscriptionSectionPageComponent } from './subscription-section-page.component';

describe('SubscriptionSectionPageComponent', () => {
  let component: SubscriptionSectionPageComponent;
  let fixture: ComponentFixture<SubscriptionSectionPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SubscriptionSectionPageComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(SubscriptionSectionPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
