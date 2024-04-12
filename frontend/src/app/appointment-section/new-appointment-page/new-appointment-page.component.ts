import {Component, inject, OnInit} from '@angular/core';
import {NewAppointmentFormComponent} from "./new-appointment-form/new-appointment-form.component";
import {AppointmentSectionService} from "../appointment-section.service";
import {PatientDto} from "../../patient-section/domain/patient-dto";
import {JsonPipe} from "@angular/common";
import {AppointmentDto} from "../domain/appointment-dto";
import {Router} from "@angular/router";

@Component({
  selector: 'app-new-appointment-page',
  standalone: true,
  imports: [
    NewAppointmentFormComponent,
    JsonPipe
  ],
  templateUrl: './new-appointment-page.component.html',
  styleUrl: './new-appointment-page.component.scss'
})
export class NewAppointmentPageComponent implements OnInit{

  appointmentSectionServices = inject(AppointmentSectionService);
  patients : PatientDto[] = [];
  router = inject(Router);

  ngOnInit() {
      this.appointmentSectionServices.findAllPatients().subscribe(
          res => this.patients = res
      )
  }

  saveAppointment($event: AppointmentDto) {
      this.appointmentSectionServices.save($event).subscribe(
      );
      this.router.navigate(['appointments'])

  }
}
