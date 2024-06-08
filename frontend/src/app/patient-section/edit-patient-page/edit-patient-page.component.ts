import {Component, inject, OnDestroy, OnInit} from '@angular/core';
import {PatientDto} from "../domain/patient-dto";
import {PatientService} from "../patient.service";
import {ActivatedRoute, Router} from "@angular/router";
import {NewPatientFormComponent} from "../new-patient-form/new-patient-form.component";
import {Subject, takeUntil} from "rxjs";
import {JsonPipe} from "@angular/common";

@Component({
  selector: 'app-edit-patient-page',
  standalone: true,
  imports: [
    NewPatientFormComponent,
    JsonPipe


  ],
  templateUrl: './edit-patient-page.component.html',
  styleUrl: './edit-patient-page.component.scss'
})
export class EditPatientPageComponent implements OnInit, OnDestroy {
  patientService = inject(PatientService);
  patientDTO: PatientDto | null = null;
  router = inject(Router);
  route = inject(ActivatedRoute);
  destroy$ = new Subject<boolean>();


  ngOnInit() {
    this.route.params
      .pipe(takeUntil(this.destroy$))
      .subscribe(data => {
        this.patientService.getDetails(data['patientId']).subscribe(res => {
          this.patientDTO = res;
        })
      })
  }
  submitForm($event: PatientDto) {
        this.patientService.edit($event).subscribe(
          () =>this.router.navigate(['patients'])
        );

  }

  ngOnDestroy(): void {
    this.destroy$.next(true);
  }


}
