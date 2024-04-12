import {Component, inject} from '@angular/core';
import {NewPatientFormComponent} from "./new-patient-form/new-patient-form.component";
import {PatientDto} from "../domain/patient-dto";
import {PatientService} from "../patient.service";
import {Router} from "@angular/router";
import {
  NewSubscriptionFormComponent
} from "../../subscription-section/subscription-section-page/new-subscription-popup/new-subscription-form/new-subscription-form.component";

@Component({
  selector: 'app-new-patient-page',
  standalone: true,
  imports: [
    NewPatientFormComponent

  ],
  templateUrl: './new-patient-page.component.html',
  styleUrl: './new-patient-page.component.scss'
})
export class NewPatientPageComponent {
  patientService = inject(PatientService);
  router = inject(Router);

  submitForm($event: PatientDto) {
        this.patientService.save($event).subscribe(
          () =>this.router.navigate(['patients'])
        );

  }


}
