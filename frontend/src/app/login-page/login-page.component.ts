import {Component, inject} from '@angular/core';
import {FormsModule} from "@angular/forms";
import {InputTextModule} from "primeng/inputtext";
import {ButtonModule} from "primeng/button";
import {HttpClient, HttpClientModule, HttpHeaders} from "@angular/common/http";
import {Router} from "@angular/router";
import {VetClinicDto} from "../auth/domain/vet-clinic-dto";
import {LoginFormComponent} from "./login-form/login-form.component";
import {UserDTO} from "../auth/domain/user-dto";
import {RegisterSuggestionPanelComponent} from "./register-suggestion-panel/register-suggestion-panel.component";
const headers = new HttpHeaders()
  .set('content-type', 'application/json')
  .set('Access-Control-Allow-Origin', '*');
@Component({
  selector: 'app-login-page',
  standalone: true,
  imports: [
    FormsModule,
    InputTextModule,
    ButtonModule,
    HttpClientModule,
    LoginFormComponent,
    RegisterSuggestionPanelComponent
  ],

  templateUrl: './login-page.component.html',
  styleUrl: './login-page.component.scss'
})

export class LoginPageComponent {

  value: string | null = null;
  password: string | null = null;
  http = inject(HttpClient);
  router = inject(Router);


  register() {
    this.router.navigate(['/register']);
  }
  // login() {
  //   this.http.post('http://localhost:8080/api/v1/auth/authenticate',{email:this.value,password: this.password}, {headers:headers}).subscribe(
  //     (res: any)=> {
  //       localStorage.setItem("token", res.token);
  //
  //       const token = localStorage.getItem("token");
  //
  //       const authHeaders = headers.set('Authorization', `Bearer ${token}`);
  //
  //       // Make the GET request with the updated headers
  //       this.http.get('http://localhost:8080/api/v1/vet-clinic/existing',{ headers: authHeaders }).subscribe(
  //         (res: any) => {
  //           console.log(res);
  //           if (res.length < 1) {
  //             this.router.navigate(['/add-vet-clinic'])
  //           }else{
  //             this.router.navigate(['/home'])
  //           }
  //         }
  //       );
  //
  //     }
  //   )
  // }
  info() {

    const token = localStorage.getItem("token");
    let vetClinicDto = new VetClinicDto();
    vetClinicDto.name = "nume";

      const authHeaders = headers.set('Authorization', `Bearer ${token}`);


      this.http.post('http://localhost:8080/api/v1/vet-clinic', {vetClinicDto: vetClinicDto},{ headers: authHeaders }).subscribe(
        res => console.log(res)
      );

  }

  onSubmit($event: UserDTO) {

    this.http.post('http://localhost:8080/api/v1/auth/authenticate',$event, {headers:headers}).subscribe(
      (res: any)=> {
        localStorage.setItem("token", res.token);

        const token = localStorage.getItem("token");

        const authHeaders = headers.set('Authorization', `Bearer ${token}`);

        // Make the GET request with the updated headers
        this.http.get('http://localhost:8080/api/v1/vet-clinic/existing',{ headers: authHeaders }).subscribe(
          (res: any) => {
            console.log(res);
            if (res.length < 1) {
              this.router.navigate(['/add-vet-clinic'])
            }else{
              this.router.navigate(['/home'])
            }
          }
        );

      }
    )
  }
}
