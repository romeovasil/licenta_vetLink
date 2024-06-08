import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EditVetClinicPageComponent } from './edit-vet-clinic-page.component';

describe('EditVetClinicPageComponent', () => {
  let component: EditVetClinicPageComponent;
  let fixture: ComponentFixture<EditVetClinicPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EditVetClinicPageComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(EditVetClinicPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
