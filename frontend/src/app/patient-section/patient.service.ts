import {inject, Injectable} from '@angular/core';
import {Observable} from "rxjs";
import {PatientResourceService} from "../utils/resource-service/patient-resource-service";
import {PatientDto} from "./domain/patient-dto";

@Injectable({
  providedIn: 'root'
})
export class PatientService {
  private patientResourceService = inject(PatientResourceService)
  constructor() { }
  save(patientDto: PatientDto) : Observable<any> {
    return this.patientResourceService.save(patientDto);
  }

  findAll() : Observable<any>{
    return this.patientResourceService.findAll();
  }

}
