import { TestBed } from '@angular/core/testing';

import { AppointmentSectionService } from './appointment-section.service';

describe('AppointmentSectionService', () => {
  let service: AppointmentSectionService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AppointmentSectionService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
