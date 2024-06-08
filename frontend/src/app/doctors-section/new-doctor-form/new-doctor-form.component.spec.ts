import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewDoctorFormComponent } from './new-doctor-form.component';

describe('NewDoctorFormComponent', () => {
  let component: NewDoctorFormComponent;
  let fixture: ComponentFixture<NewDoctorFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NewDoctorFormComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(NewDoctorFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
