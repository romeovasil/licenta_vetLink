import { TestBed } from '@angular/core/testing';

import { DoctorSectionService } from './doctor-section.service';

describe('DoctorSectionService', () => {
  let service: DoctorSectionService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DoctorSectionService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
