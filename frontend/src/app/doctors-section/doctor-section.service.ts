import {inject, Injectable} from '@angular/core';
import {SubscriptionResourceService} from "../utils/resource-service/subscription-resource-service";
import {SubscriptionDto} from "../subscription-section/domain/subscription-dto";
import {Observable} from "rxjs";
import {DoctorResourceService} from "../utils/resource-service/doctor-resource-service";
import {DoctorDto} from "./domain/doctor-dto";

@Injectable({
  providedIn: 'root'
})
export class DoctorSectionService {
  private doctorResourceService = inject(DoctorResourceService)
  constructor() { }
  save(doctorDTO: DoctorDto) : Observable<any> {
    return this.doctorResourceService.save(doctorDTO);
  }

  findAll(): Observable<any>{
    return this.doctorResourceService.findAll();
  }
}
