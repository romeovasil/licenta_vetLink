import {Component, inject, Input, OnInit} from '@angular/core';
import {VetClinicDto} from "../domain/vet-clinic-dto";
import {HttpClient, HttpHeaders} from "@angular/common/http";
import {VetClinicFormComponent} from "../vet-clinic-form/vet-clinic-form.component";
import {Notifications} from "@mobiscroll/angular";
const headers = new HttpHeaders({
  'Content-Type': 'application/json; charset=utf-8',
});
@Component({
  selector: 'app-edit-vet-clinic-page',
  standalone: true,
  imports: [
    VetClinicFormComponent
  ],
  templateUrl: './edit-vet-clinic-page.component.html',
  styleUrl: './edit-vet-clinic-page.component.scss'
})
export class EditVetClinicPageComponent implements OnInit{

  @Input() vetClinic: VetClinicDto = new VetClinicDto();
  http = inject(HttpClient);
  notify = inject(Notifications);


  ngOnInit(): void {
    const token = localStorage.getItem("token");

    const authHeaders = headers.set('Authorization', `Bearer ${token}`);
    this.http.get('http://localhost:8080/api/v1/vet-clinic/existing',{ headers: authHeaders }).subscribe(
      (res: any) => {
        this.vetClinic = res;
      });
  }

  editVetClinic($event: VetClinicDto) {
    const token = localStorage.getItem("token");

    const authHeaders = headers.set('Authorization', `Bearer ${token}`);
    this.http.put('http://localhost:8080/api/v1/vet-clinic',$event,{ headers: authHeaders }).subscribe(
      (res: any) => {
        this.vetClinic = res;
        this.notify.toast({
          message:'Cabinetul a fost actualizat cu succes!', color:"success"
        });
      });
  }
}
