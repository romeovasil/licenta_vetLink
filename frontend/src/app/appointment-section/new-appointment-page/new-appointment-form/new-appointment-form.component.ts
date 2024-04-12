import {Component, EventEmitter, Input, Output} from '@angular/core';
import {FormsModule, NgForm} from "@angular/forms";
import {ChipsModule} from "primeng/chips";
import {ButtonModule} from "primeng/button";
import {AppointmentDto} from "../../domain/appointment-dto";
import {PatientDto} from "../../../patient-section/domain/patient-dto";
import {JsonPipe} from "@angular/common";
import {DropdownModule} from "primeng/dropdown";
import {FormUtils} from "../../../utils/form-utils";

@Component({
  selector: 'app-new-appointment-form',
  standalone: true,
  imports: [
    FormsModule,
    ChipsModule,
    ButtonModule,
    JsonPipe,
    DropdownModule
  ],
  templateUrl: './new-appointment-form.component.html',
  styleUrl: './new-appointment-form.component.scss'
})
export class NewAppointmentFormComponent {
  appointmentDTO : AppointmentDto = new AppointmentDto();
  @Input() patients : PatientDto[] = [];
  @Output() submitForm : EventEmitter<AppointmentDto> = new EventEmitter();
  durations = [0.5,1,1.5,2,2.5,3]
  onSubmit(appointmentForm: NgForm) {
    FormUtils.markAllAsDirty(appointmentForm.form);
    FormUtils.markAllAsTouched(appointmentForm.form);
    if (appointmentForm.valid) {
      console.log(this.appointmentDTO)
      this.submitForm.emit(this.appointmentDTO)
    }
  }
}
