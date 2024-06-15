import {inject, Injectable} from "@angular/core";
import {AppointmentResourceService} from "../../utils/resource-service/appointment-resource-service";
import {Observable} from "rxjs";


@Injectable({
  providedIn: 'root'
})
export class AppointmentRequestSectionService {
  appointmentRequestResourceService  = inject(AppointmentResourceService);

  constructor() { }

  findAllRequests(): Observable<any>{
    return this.appointmentRequestResourceService.getAllRequests();
  }

  deleteRequest(id: number){
    return this.appointmentRequestResourceService.deleteRequest(id);
  }

}
