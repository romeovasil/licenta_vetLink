import {Component, inject, OnInit} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {DropdownModule} from "primeng/dropdown";
import {FormsModule} from "@angular/forms";
import {InputTextModule} from "primeng/inputtext";
import {MultiSelectModule} from "primeng/multiselect";
import {HttpClient} from "@angular/common/http";
import {ActivatedRoute, Router} from "@angular/router";
import {DoctorDto} from "../domain/doctor-dto";
import {DoctorSectionService} from "../doctor-section.service";
import {NewDoctorFormComponent} from "../new-doctor-form/new-doctor-form.component";
import {Subject, takeUntil} from "rxjs";
import {PatientDto} from "../../patient-section/domain/patient-dto";

@Component({
  selector: 'app-edit-doctor-page',
  standalone: true,
  imports: [
    ButtonModule,
    DropdownModule,
    FormsModule,
    InputTextModule,
    MultiSelectModule,
    NewDoctorFormComponent
  ],
  templateUrl: './edit-doctor-page.component.html',
  styleUrl: './edit-doctor-page.component.scss'
})
export class EditDoctorPageComponent implements OnInit{

  doctorDto : DoctorDto = new DoctorDto();


  http = inject(HttpClient);
  router = inject(Router);
  doctorService = inject(DoctorSectionService);


  route = inject(ActivatedRoute);
  destroy$ = new Subject<boolean>();


  ngOnInit() {
    this.route.params
      .pipe(takeUntil(this.destroy$))
      .subscribe(data => {
        this.doctorService.getDetails(data['doctorId']).subscribe(res => {
          this.doctorDto = res;
        })
      })
  }
  ngOnDestroy(): void {
    this.destroy$.next(true);
  }

  saveDoctor($event: DoctorDto) {
      this.doctorService.edit($event).subscribe(
        res=> this.router.navigate(["/doctors"])
      )
  }
}
