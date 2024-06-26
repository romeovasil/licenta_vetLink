import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AppointmentRequestPageComponent } from './appointment-request-page.component';

describe('AppointmentRequestPageComponent', () => {
  let component: AppointmentRequestPageComponent;
  let fixture: ComponentFixture<AppointmentRequestPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppointmentRequestPageComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AppointmentRequestPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
