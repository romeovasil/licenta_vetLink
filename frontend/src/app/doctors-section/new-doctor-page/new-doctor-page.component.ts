import {Component, inject, OnInit} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {DropdownModule} from "primeng/dropdown";
import {FormsModule} from "@angular/forms";
import {InputTextModule} from "primeng/inputtext";
import {MultiSelectModule} from "primeng/multiselect";
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {DoctorDto} from "../domain/doctor-dto";
import {NewDoctorFormComponent} from "./new-doctor-form/new-doctor-form.component";
import {DoctorSectionService} from "../doctor-section.service";

@Component({
  selector: 'app-new-doctor-page',
  standalone: true,
  imports: [
    ButtonModule,
    DropdownModule,
    FormsModule,
    InputTextModule,
    MultiSelectModule,
    NewDoctorFormComponent
  ],
  templateUrl: './new-doctor-page.component.html',
  styleUrl: './new-doctor-page.component.scss'
})
export class NewDoctorPageComponent implements OnInit{
  http = inject(HttpClient);
  router = inject(Router);
  doctorService = inject(DoctorSectionService);


  ngOnInit(): void {

  }

  saveDoctor($event: DoctorDto) {
      this.doctorService.save($event).subscribe(
        res=> this.router.navigate(["/doctors"])
      )
  }
}
