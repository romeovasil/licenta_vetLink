import {Component, EventEmitter, Output} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {InputTextModule} from "primeng/inputtext";
import {FormsModule, NgForm, ReactiveFormsModule} from "@angular/forms";
import {UserDTO} from "../../auth/domain/user-dto";
import {FormUtils} from "../../utils/form-utils";

@Component({
  selector: 'app-login-form',
  standalone: true,
  imports: [
    ButtonModule,
    InputTextModule,
    ReactiveFormsModule,
    FormsModule
  ],
  templateUrl: './login-form.component.html',
  styleUrl: './login-form.component.scss'
})
export class LoginFormComponent {

  userDTO: UserDTO = new UserDTO();

  @Output() submitForm: EventEmitter<UserDTO> = new EventEmitter<UserDTO>();



  onSubmit(loginForm: NgForm) {
    FormUtils.markAllAsDirty(loginForm);
    FormUtils.markAllAsTouched(loginForm);

    if (loginForm.valid) {
      console.log(this.userDTO)
      this.submitForm.emit(this.userDTO);
    }
  }
}
