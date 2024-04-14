import {Component, EventEmitter, Output} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {InputTextModule} from "primeng/inputtext";
import {FormsModule, NgForm, ReactiveFormsModule} from "@angular/forms";
import {UserDTO} from "../../auth/domain/user-dto";
import {FormUtils} from "../../utils/form-utils";
import {DropdownModule} from "primeng/dropdown";


@Component({
  selector: 'app-login-form',
  standalone: true,
  imports: [
    ButtonModule,
    InputTextModule,
    ReactiveFormsModule,
    FormsModule,
    DropdownModule
  ],
  templateUrl: './login-form.component.html',
  styleUrl: './login-form.component.scss'
})
export class LoginFormComponent {

  userDTO: UserDTO = new UserDTO();

  @Output() submitForm: EventEmitter<UserDTO> = new EventEmitter<UserDTO>();


  categories: string[] = ['Mancare','Jucarii','Ingrijire','Accesorii','Tratement'];
  onSubmit(loginForm: NgForm) {
    FormUtils.markAllAsDirty(loginForm);
    FormUtils.markAllAsTouched(loginForm);

    if (loginForm.valid) {
      console.log(this.userDTO)
      this.submitForm.emit(this.userDTO);
    }
  }
}
