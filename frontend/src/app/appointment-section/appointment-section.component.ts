import {Component, inject, OnInit} from '@angular/core';
import {
  MbscCalendarColor,
  MbscCalendarEvent, MbscEventcalendarModule,
  MbscEventcalendarOptions, MbscEventUpdateEvent, MbscSegmentedModule,
  Notifications,
  setOptions,
} from '@mobiscroll/angular';
import {FormsModule} from "@angular/forms";
import {JsonPipe, NgForOf, NgStyle} from "@angular/common";
import {AppointmentSectionService} from "./appointment-section.service";
import {ButtonModule} from "primeng/button";
import {Router} from "@angular/router";
import {AppointmentDto} from "./domain/appointment-dto";
import {ConfirmedScheduleDto} from "./domain/confirmed-schedule-dto";
import {EventcalendarBase} from "@mobiscroll/angular/dist/js/core/components/eventcalendar/eventcalendar";

setOptions({
  theme: 'ios',
  themeVariant: 'light',

});

type MyEvent = MbscCalendarEvent & { job?: string; unscheduled?: boolean; eventLength?: string };

const now = new Date();
const today = new Date(now.setMinutes(59));
const yesterday = new Date(now.getFullYear(), now.getMonth(), now.getDate() - 1);

@Component({
  selector: 'app-appointment-section',
  standalone: true,
  imports: [
    MbscEventcalendarModule,
    MbscSegmentedModule,
    FormsModule,
    NgStyle,
    NgForOf,
    JsonPipe,
    ButtonModule
  ],
  templateUrl: './appointment-section.component.html',
  styleUrl: './appointment-section.component.scss',
  providers: [Notifications],
})
export class AppointmentSectionComponent implements OnInit {
  appointmentService = inject(AppointmentSectionService);
  router = inject(Router);
  appointmentDTOs : AppointmentDto[] = [];
  constructor(private notify: Notifications) {}

  scheduledAppoints: MyEvent[] = [];

  appointments: MyEvent[] = [];

  myColors: MbscCalendarColor[] = [];
  contBg = '';

  calendarOptions: MbscEventcalendarOptions = {
    view: {
      schedule: {
        type: 'day',
        startTime: '09:00',
        endTime: '18:00',
        allDay: false,
      },
    },
    resources: [],
    invalid: [
      {
        recurring: {
          repeat: 'daily',
          until: yesterday,
        },
      },
      {
        start: yesterday,
        end: today,
      },
    ],
    dragToMove: true,
    dragToCreate: true,
    eventOverlap: false,
    externalDrop: true,
    externalDrag: true,
    extendDefaultEvent: () => ({
      job: 'Tartar removal',
      color: '#a446b5',
    }),
    onEventCreate: (args) => {
      const event: MyEvent = args.event;
      event.unscheduled = false;
      this.myColors = [];
    },
    onEventCreated: (args) => {
      setTimeout(() => {
        this.notify.toast({
          message: args.event.title + ' added',
        });
        let confirmedScheduleDTO : ConfirmedScheduleDto = new ConfirmedScheduleDto();

        confirmedScheduleDTO.start = new Date(args.event.start as any).toISOString().toString();
        confirmedScheduleDTO.end = new Date(args.event.end as any).toISOString().toString();
        confirmedScheduleDTO.doctorNumber = args.event.resource as number;

        this.appointmentService.confirmSchedule(confirmedScheduleDTO,args.event.id as string).subscribe()

        this.appointments = this.appointments.filter((item) => item.id !== args.event.id);
      });
    },
    onEventUpdated: (args: MbscEventUpdateEvent,) => {

      let updatedConfirmedScheduleDTO: ConfirmedScheduleDto = new ConfirmedScheduleDto();

      updatedConfirmedScheduleDTO.start= new Date(args.event.start as any).toISOString().toString();
      updatedConfirmedScheduleDTO.end= new Date(args.event.end as any).toISOString().toString();
      updatedConfirmedScheduleDTO.doctorNumber = args.event.resource as number;
      updatedConfirmedScheduleDTO.id = args.event.id as number;

      this.appointmentService.updateSchedule(updatedConfirmedScheduleDTO).subscribe();
    },

    onEventCreateFailed: (args) => {
      this.notify.toast({
        message: args.event.start! <= today ? "Nu se pot adauga programari in trecut!" : 'Exista deja o programare in perioada respectiva!',
        color:"danger"
      });
    },
    onEventUpdateFailed: (args) => {
      this.notify.toast({
        message: args.event.start! <= today ? "Nu se pot adauga programari in trecut!" : 'Exista deja o programare in perioada respectiva!',
        color:"danger"
      });
    },
    onEventDelete: (args) => {
      this.notify.toast({
        message: args.event.title + ' unscheduled',
      });
    },
    onEventDragEnter: () => {
      this.myColors = [
        {
          background: '#f1fff24d',
          start: '08:00',
          end: '20:00',
          recurring: {
            repeat: 'daily',
          },
        },
      ];
    },
    onEventDragLeave: () => {
      console.log("bbb");

      this.myColors = [];
    },
  };


  onItemDrop(args: any): void {
    console.log("aaa");
    if (args.data) {
      const event: MyEvent = args.data;
      event.unscheduled = true;
      this.appointments = [...this.appointments, event];
    }
    this.contBg = '';
  }

  onItemDragEnter(args: any): void {
    const event: MyEvent = args.data;
    console.log("ccc");
    if (!(event && event.unscheduled)) {
      this.contBg = '#d0e7d2cc';
    }
  }

  onItemDragLeave(): void {
    console.log("dd");
    this.contBg = '';
  }

  ngOnInit(): void {
    for (const event of this.scheduledAppoints) {
      event.start = event.start ? new Date(event.start as string) : event.start;
      event.end = event.end ? new Date(event.end as string) : event.end;
      event.editable = !!(event.start && today < event.start);
    }


    this.appointmentService.findAllDoctors().subscribe(
      (response: any) => {
        this.calendarOptions = {
          ...this.calendarOptions,
          resources:  response.map((doctor: any) => ({
            id: doctor.id,
            name: "Dr. " + doctor.firstName + " " +  doctor.lastName,
            depth: 0,
            isParent: false}))
        };
      },
    )


    this.appointmentService.findAll().subscribe(
      (response: any) => {
        this.appointmentDTOs = response;
        this.appointments = this.appointmentDTOs
          .filter((appointment:any) => appointment.unscheduled === true)
          .map((appointment: any) => {
          return {
            id: appointment.id,
            title: appointment.patientDTO.name,
            start: new Date('2024-03-19T14:00'),
            end: new Date(new Date('2024-03-19T14:00') .getTime() + appointment.eventLength * 60 * 60 * 1000),
            eventLength: appointment.eventLength,
            color: this.getRandomColor(),
            job: appointment.job,
            unscheduled: appointment.unscheduled
          };
        });

        this.scheduledAppoints = this.appointmentDTOs
          .filter((appointment:any) => appointment.unscheduled === false)
          .map((appointment: any) => {
            console.log(appointment.confirmedScheduleDTO.start,appointment.confirmedScheduleDTO.end)
            const startDate = new Date(appointment.confirmedScheduleDTO.start);
            const endDate = new Date(appointment.confirmedScheduleDTO.end);

            startDate.setHours(startDate.getHours() + 6);
            endDate.setHours(endDate.getHours() + 6);

            const startFormatted = startDate.toISOString().substring(0, 16);
            const endFormatted = endDate.toISOString().substring(0, 16);

            return {
              id: appointment.id,
              title: appointment.patientDTO.name + " - " + appointment.job,
              start: startFormatted,
              end: endFormatted,
              resource: appointment.confirmedScheduleDTO.doctorNumber,
              eventLength: appointment.eventLength,
              color: this.getRandomColor(),
              job: appointment.job,
              unscheduled: appointment.unscheduled
            };
          });
      },
    )
  }

  addAppointment() {
      this.router.navigate(['appointments','new']);
  }

  getRandomColor(): string {
    const colors = ['#d1891f', '#334ab9', '#a446b5']; // Example colors
    const randomIndex = Math.floor(Math.random() * colors.length);
    return colors[randomIndex];
  }

}








