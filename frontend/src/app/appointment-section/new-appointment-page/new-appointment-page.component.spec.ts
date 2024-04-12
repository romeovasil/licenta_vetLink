import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewAppointmentPageComponent } from './new-appointment-page.component';

describe('NewAppointmentPageComponent', () => {
  let component: NewAppointmentPageComponent;
  let fixture: ComponentFixture<NewAppointmentPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NewAppointmentPageComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(NewAppointmentPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
