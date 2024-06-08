import {inject, Injectable} from '@angular/core';
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

  delete(id: number) : Observable<any>{
    return this.doctorResourceService.delete(id);
  }

  edit(doctorDto: DoctorDto) : Observable<any>{
    return this.doctorResourceService.edit(doctorDto);
  }

  getDetails(id: number) : Observable<any>{
    return this.doctorResourceService.findById(id);
  }

}
