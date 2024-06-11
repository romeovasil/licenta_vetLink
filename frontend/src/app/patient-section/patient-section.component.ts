import {Component, inject, OnInit} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {Router} from "@angular/router";
import {PatientService} from "./patient.service";
import {PatientDto} from "./domain/patient-dto";
import {JsonPipe, NgForOf} from "@angular/common";
import {Notifications} from "@mobiscroll/angular";
import {TableModule} from "primeng/table";

@Component({
  selector: 'app-patient-section',
  standalone: true,
  imports: [
    ButtonModule,
    JsonPipe,
    NgForOf,
    TableModule
  ],
  templateUrl: './patient-section.component.html',
  styleUrl: './patient-section.component.scss'
})
export class PatientSectionComponent implements OnInit {
  router = inject(Router);
  patientService = inject(PatientService);
  notify = inject(Notifications);

  patients: PatientDto[] = [];

  addPatient() {
    this.router.navigate(['patients', 'new']);
  }

  ngOnInit() {
    this.patientService.findAll().subscribe(
      res => this.patients = res
    )
  }

  editPatient(patient: PatientDto) {
    this.router.navigate(['patients', 'edit', patient.id]);
  }

  deletePatient(patient: PatientDto) {
    if (patient.id) {
      this.patientService.delete(patient.id).subscribe(
        (res) => {
          this.notify.toast({
            message: "Patient sters cu succes!"
            , color:"success"
          });
          this.patientService.findAll().subscribe(
            (res) => {
              this.patients = res;
            }
          );
        },
        (error) => {
          this.notify.toast({
            message: "Patientul nu poate fi sters deoarece are programari",
            color:"danger"
          });
        }
      );
    }
  }

}
