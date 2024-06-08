import {Component, EventEmitter, Input, Output} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {FormsModule, NgForm, ReactiveFormsModule} from "@angular/forms";
import {InputTextModule} from "primeng/inputtext";
import {VetClinicDto} from "../domain/vet-clinic-dto";
import {FormUtils} from "../../utils/form-utils";
import {JsonPipe} from "@angular/common";

@Component({
  selector: 'app-vet-clinic-form',
  standalone: true,
  imports: [
    ButtonModule,
    FormsModule,
    InputTextModule,
    ReactiveFormsModule,
    JsonPipe
  ],
  templateUrl: './vet-clinic-form.component.html',
  styleUrl: './vet-clinic-form.component.scss'
})
export class VetClinicFormComponent {

  @Input() vetClinic: VetClinicDto = new VetClinicDto();

  @Output() submitVetClinic: EventEmitter<VetClinicDto> = new EventEmitter();

  onSubmit(clinicForm: NgForm) {
    FormUtils.markAllAsDirty(clinicForm);
    FormUtils.markAllAsTouched(clinicForm);
    if (clinicForm.valid) {
      this.submitVetClinic.emit(this.vetClinic)
    }
  }


}
