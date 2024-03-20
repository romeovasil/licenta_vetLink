import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewPatientPageComponent } from './new-patient-page.component';

describe('NewPatientPageComponent', () => {
  let component: NewPatientPageComponent;
  let fixture: ComponentFixture<NewPatientPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NewPatientPageComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(NewPatientPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
