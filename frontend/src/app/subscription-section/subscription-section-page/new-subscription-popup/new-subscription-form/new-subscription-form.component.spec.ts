import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewSubscriptionFormComponent } from './new-subscription-form.component';

describe('NewSubscriptionFormComponent', () => {
  let component: NewSubscriptionFormComponent;
  let fixture: ComponentFixture<NewSubscriptionFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NewSubscriptionFormComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(NewSubscriptionFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
