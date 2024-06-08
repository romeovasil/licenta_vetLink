import {Component, inject, OnInit} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {Router} from "@angular/router";
import {DoctorSectionService} from "./doctor-section.service";
import {DoctorDto} from "./domain/doctor-dto";
import {JsonPipe, NgForOf} from "@angular/common";
import {Notifications} from "@mobiscroll/angular";

@Component({
  selector: 'app-doctors-section',
  standalone: true,
  imports: [
    ButtonModule,
    JsonPipe,
    NgForOf
  ],
  templateUrl: './doctors-section.component.html',
  styleUrl: './doctors-section.component.scss'
})
export class DoctorsSectionComponent implements OnInit{
  router = inject(Router);
  doctorService = inject(DoctorSectionService);
  notify = inject(Notifications);
  doctors: DoctorDto[] = [];
  addDoctor() {
    this.router.navigate(['doctors', 'new']);
  }

  ngOnInit() {
      this.doctorService.findAll().subscribe(res=> this.doctors = res);
  }

  editDoctor(doctor: DoctorDto) {
    this.router.navigate(['doctors', 'edit', doctor.id]);
  }


  deleteDoctor(doctor: DoctorDto) {
    if (doctor.id) {
      this.doctorService.delete(doctor.id).subscribe(
        (res) => {
          this.notify.toast({
            message: "Doctor sters cu succes!"
            , color:"success"
          });
          this.doctorService.findAll().subscribe(
            (res) => {
              this.doctors = res;
            }
          );
        },
        (error) => {
          this.notify.toast({
            message: "Doctorul nu poate fi sters deoarece are programari",
            color:"danger"
          });
        }
      );
    }
  }
}
