import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewSubscriptionPopupComponent } from './new-subscription-popup.component';

describe('NewSubscriptionPopupComponent', () => {
  let component: NewSubscriptionPopupComponent;
  let fixture: ComponentFixture<NewSubscriptionPopupComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NewSubscriptionPopupComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(NewSubscriptionPopupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
