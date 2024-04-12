import {Component, inject} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {FormsModule, NgForm, ReactiveFormsModule} from "@angular/forms";
import {InputTextModule} from "primeng/inputtext";
import {HttpClient, HttpClientModule, HttpHeaders} from "@angular/common/http";
import {Router} from "@angular/router";
import {FormUtils} from "../../utils/form-utils";
import {VetClinicDto} from "../domain/vet-clinic-dto";
import {DropdownModule} from "primeng/dropdown";
import {CommonModule} from "@angular/common";
const headers = new HttpHeaders()
  .set('content-type', 'application/json')
  .set('Access-Control-Allow-Origin', '*');
@Component({
  selector: 'app-add-vet-clinic-page',
  standalone: true,
  imports: [
    ButtonModule,
    FormsModule,
    InputTextModule,
    ReactiveFormsModule,
    HttpClientModule,
    CommonModule,
    DropdownModule
  ],
  templateUrl: './add-vet-clinic-page.component.html',
  styleUrl: './add-vet-clinic-page.component.scss'
})
export class AddVetClinicPageComponent {
  http = inject(HttpClient);
  vetClinicDTO: VetClinicDto = new VetClinicDto();
  router = inject(Router);
  onSubmit(clinicForm: NgForm) {
    FormUtils.markAllAsDirty(clinicForm);
    FormUtils.markAllAsTouched(clinicForm);
    console.log(clinicForm)
    if (clinicForm.valid) {
      const token = localStorage.getItem("token");

      const authHeaders = headers.set('Authorization', `Bearer ${token}`);


      this.http.post('http://localhost:8080/api/v1/vet-clinic',this.vetClinicDTO, {headers:authHeaders}).subscribe(
        (res: any) => {
          console.log('Response:', res);
          this.router.navigate(["/appointments"]);
        },
        (error) => {
          console.error('Error:', error);
        }
      );
    }


  }

  protected readonly VetClinicDto = VetClinicDto;
}
