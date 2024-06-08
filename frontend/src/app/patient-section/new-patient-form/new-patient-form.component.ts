import {Component, EventEmitter, Input, Output} from '@angular/core';
import {FormsModule, NgForm} from "@angular/forms";
import {ButtonModule} from "primeng/button";
import {InputTextModule} from "primeng/inputtext";
import {PaginatorModule} from "primeng/paginator";
import {InputTextareaModule} from "primeng/inputtextarea";
import {PatientDto} from "../domain/patient-dto";
import {FormUtils} from "../../utils/form-utils";

@Component({
  selector: 'app-new-patient-form',
  standalone: true,
  imports: [
    ButtonModule,
    FormsModule,
    InputTextModule,
    PaginatorModule,
    InputTextareaModule
  ],
  templateUrl: './new-patient-form.component.html',
  styleUrl: './new-patient-form.component.scss'
})
export class NewPatientFormComponent {
  @Input() patientDto : PatientDto = new PatientDto();
  animalTypes=['Pisica','Caine','Cal','Peste','Sarpe','Vaca','Papagal']

  @Output() submitForm: EventEmitter<PatientDto> = new EventEmitter<PatientDto>();

  onSubmit(subscriptionForm: NgForm) {
    FormUtils.markAllAsDirty(subscriptionForm.form);
    FormUtils.markAllAsTouched(subscriptionForm.form);
    if (subscriptionForm.valid) {
      console.log(this.patientDto)
      this.submitForm.emit(this.patientDto)
      console.log("s-a emis")
    }
  }

}
