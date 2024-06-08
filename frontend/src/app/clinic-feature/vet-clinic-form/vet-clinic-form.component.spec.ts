import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VetClinicFormComponent } from './vet-clinic-form.component';

describe('VetClinicFormComponent', () => {
  let component: VetClinicFormComponent;
  let fixture: ComponentFixture<VetClinicFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [VetClinicFormComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(VetClinicFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
