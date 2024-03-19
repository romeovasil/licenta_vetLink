import {Component, inject, OnInit} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {Router} from "@angular/router";
import {DoctorSectionService} from "./doctor-section.service";
import {DoctorDto} from "./domain/doctor-dto";
import {JsonPipe} from "@angular/common";

@Component({
  selector: 'app-doctors-section',
  standalone: true,
  imports: [
    ButtonModule,
    JsonPipe
  ],
  templateUrl: './doctors-section.component.html',
  styleUrl: './doctors-section.component.scss'
})
export class DoctorsSectionComponent implements OnInit{
  router = inject(Router);
  doctorService = inject(DoctorSectionService);
  doctors: DoctorDto[] = [];
  addDoctor() {
    this.router.navigate(['doctors', 'new']);
  }

  ngOnInit() {
      this.doctorService.findAll().subscribe(res=> this.doctors = res);
  }
}
