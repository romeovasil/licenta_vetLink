import {Component, EventEmitter, Output} from '@angular/core';
import {DoctorDto} from "../../domain/doctor-dto";
import {FormsModule, NgForm} from "@angular/forms";
import {FormUtils} from "../../../utils/form-utils";
import {ButtonModule} from "primeng/button";
import {InputTextModule} from "primeng/inputtext";

@Component({
  selector: 'app-new-doctor-form',
  standalone: true,
  imports: [
    ButtonModule,
    FormsModule,
    InputTextModule
  ],
  templateUrl: './new-doctor-form.component.html',
  styleUrl: './new-doctor-form.component.scss'
})
export class NewDoctorFormComponent {
  doctorDto : DoctorDto = new DoctorDto();

  @Output() submitForm: EventEmitter<DoctorDto> = new EventEmitter<DoctorDto>();

  onSubmit(subscriptionForm: NgForm) {
    FormUtils.markAllAsDirty(subscriptionForm.form);
    FormUtils.markAllAsTouched(subscriptionForm.form);
    if (subscriptionForm.valid) {
      console.log(this.doctorDto)
      this.submitForm.emit(this.doctorDto)
    }
  }
}
