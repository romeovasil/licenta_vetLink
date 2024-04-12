import { Injectable} from "@angular/core";
import {AbstractResourceService} from "./abstract-resource-service";
import {HttpClient} from "@angular/common/http";
import {AppointmentDto} from "../../appointment-section/domain/appointment-dto";
import {ConfirmedScheduleDto} from "../../appointment-section/domain/confirmed-schedule-dto";

@Injectable({
  providedIn: 'root',
})
export class AppointmentResourceService extends AbstractResourceService<AppointmentDto> {

  constructor(httpClient: HttpClient) {
    super(
      httpClient,
      "appointment"
    );
  }

  confirmSchedule(confirmedScheduleDTO: ConfirmedScheduleDto, appointmentId: string) {
    const token = localStorage.getItem("token");
    const authHeaders = this.headers.set('Authorization', `Bearer ${token}`);
    return this.httpClient.post(`http://localhost:8080/api/v1/${this.url}/${appointmentId}/confirm-schedule`, confirmedScheduleDTO,{headers:authHeaders})
  }



}
