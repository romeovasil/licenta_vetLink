import {Component, inject, OnInit} from '@angular/core';
import {AppointmentRequestSectionService} from "./appointment-request-section.service";
import {AppointmentRequestDto} from "../domain/appointment-request-dto";
import {AppointmentDto} from "../../appointment-section/domain/appointment-dto";
import {JsonPipe} from "@angular/common";
import {ButtonModule} from "primeng/button";
import {SharedModule} from "primeng/api";
import {TableModule} from "primeng/table";
import {PatientDto} from "../../patient-section/domain/patient-dto";
import {Notifications} from "@mobiscroll/angular";
import {Router} from "@angular/router";

@Component({
  selector: 'app-appointment-request-page',
  standalone: true,
  imports: [
    JsonPipe,
    ButtonModule,
    SharedModule,
    TableModule
  ],
  templateUrl: './appointment-request-page.component.html',
  styleUrl: './appointment-request-page.component.scss'
})
export class AppointmentRequestPageComponent implements OnInit{

  appointmentRequestDtos : AppointmentRequestDto[] = [];

  appointmentRequestSectionService = inject(AppointmentRequestSectionService);

  constructor(private notify: Notifications,
              private router: Router) {}

  ngOnInit(): void {
    this.appointmentRequestSectionService.findAllRequests().subscribe(
      (res) => {
        this.appointmentRequestDtos = res;
        this.appointmentRequestDtos.forEach(request => {
          if(request && request.patientDTO)
          request.patientInfo = `${request.patientDTO.type} ${request.patientDTO.race} ${request.patientDTO.subRace} (${request.patientDTO.name})`;
        });
      }
    )
  }


  deleteRequest(appointmentRequestDto: AppointmentRequestDto) {
    console.log(appointmentRequestDto)
    if (appointmentRequestDto.id) {
      this.appointmentRequestSectionService.deleteRequest(appointmentRequestDto.id).subscribe(
        (res) => {
          this.notify.toast({
            message: "Cerere stearsa cu succes!"
            , color:"success"
          });
          this.appointmentRequestSectionService.findAllRequests().subscribe(
            (res) => {
              this.appointmentRequestDtos = res;
            }
          );
        },
      );
    }
  }

  saveRequest(request: any) {
    const patientInfo = request.patientDTO;

    this.router.navigate(['/appointments/new'], { state: { patient: patientInfo, ownerEmail: request.customerEmail, requestId: request.id } });
  }
}
