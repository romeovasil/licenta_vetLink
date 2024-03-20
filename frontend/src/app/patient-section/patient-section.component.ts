import {Component, inject, OnInit} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {Router} from "@angular/router";
import {PatientService} from "./patient.service";
import {PatientDto} from "./domain/patient-dto";
import {JsonPipe} from "@angular/common";

@Component({
  selector: 'app-patient-section',
  standalone: true,
  imports: [
    ButtonModule,
    JsonPipe
  ],
  templateUrl: './patient-section.component.html',
  styleUrl: './patient-section.component.scss'
})
export class PatientSectionComponent implements OnInit{
  router = inject(Router);
  patientService = inject(PatientService);

  patients : PatientDto[] = [];
  addPatient() {
    this.router.navigate(['patients', 'new']);
  }

  ngOnInit() {
    this.patientService.findAll().subscribe(
      res => this.patients = res
    )
  }
}
