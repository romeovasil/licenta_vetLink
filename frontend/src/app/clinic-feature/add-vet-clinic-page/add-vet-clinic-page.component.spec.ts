import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddVetClinicPageComponent } from './add-vet-clinic-page.component';

describe('AddVetClinicPageComponent', () => {
  let component: AddVetClinicPageComponent;
  let fixture: ComponentFixture<AddVetClinicPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AddVetClinicPageComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AddVetClinicPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
