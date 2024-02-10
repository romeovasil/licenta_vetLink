import {Component, inject} from '@angular/core';
import {InputTextModule} from "primeng/inputtext";
import {PaginatorModule} from "primeng/paginator";
import {HttpClient, HttpClientModule, HttpHeaders} from "@angular/common/http";
import {UserDTO} from "../auth/domain/user-dto";
import {ButtonModule} from "primeng/button";
import {NgForm} from "@angular/forms";
import {FormUtils} from "../utils/form-utils";
import {Router} from "@angular/router";
const headers = new HttpHeaders()
  .set('content-type', 'application/json')
  .set('Access-Control-Allow-Origin', '*');
@Component({
  selector: 'app-register-page',
  standalone: true,
  imports: [
    InputTextModule,
    PaginatorModule,
    HttpClientModule,
    ButtonModule
  ],
  templateUrl: './register-page.component.html',
  styleUrl: './register-page.component.scss'
})
export class RegisterPageComponent {

  http = inject(HttpClient);
  userDTO : UserDTO = new UserDTO();
  errorMessage: string | null = null;
  router = inject(Router);
  onSubmit(registerForm: NgForm) {
    console.log("aici")
    FormUtils.markAllAsDirty(registerForm);
    FormUtils.markAllAsTouched(registerForm);
    console.log(registerForm)
    if (registerForm.valid) {
      this.http.post('http://localhost:8080/api/v1/auth/register',this.userDTO, {headers:headers}).subscribe(
        (res: any) => {
          console.log('Response:', res);
          localStorage.setItem('token', res.token);
          this.errorMessage = null
          this.router.navigate(["/add-vet-clinic"]);
        },
        (error) => {
          console.error('Error:', error);
          this.errorMessage = error.error.errors[0].code;
        }
      );
    }
  }

  backToLogin() {
    this.router.navigate([''])
  }
}
