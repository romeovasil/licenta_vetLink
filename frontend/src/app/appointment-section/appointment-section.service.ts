import {inject, Injectable} from '@angular/core';
import {DoctorResourceService} from "../utils/resource-service/doctor-resource-service";
import {PatientResourceService} from "../utils/resource-service/patient-resource-service";
import {Observable} from "rxjs";
import {AppointmentDto} from "./domain/appointment-dto";
import {AppointmentResourceService} from "../utils/resource-service/appointment-resource-service";
import {ConfirmedScheduleDto} from "./domain/confirmed-schedule-dto";

@Injectable({
  providedIn: 'root'
})
export class AppointmentSectionService {
  doctorResourceService  = inject(DoctorResourceService);
  patientResourceService  = inject(PatientResourceService);
  appointmentResourceService = inject(AppointmentResourceService);
  constructor() { }

  findAllDoctors(){
    return this.doctorResourceService.findAll();
  }

  findAllPatients() :  Observable<any>{
    return this.patientResourceService.findAll();
  }

  save(appointmentDTO: AppointmentDto) : Observable<any>{
    return this.appointmentResourceService.save(appointmentDTO);
  }

  findAll() : Observable<any>{
    return this.appointmentResourceService.findAll();
  }

  confirmSchedule(confirmedScheduleDto: ConfirmedScheduleDto, appointmentId: string) : Observable<any>{
    return this.appointmentResourceService.confirmSchedule(confirmedScheduleDto, appointmentId);
  }
}
