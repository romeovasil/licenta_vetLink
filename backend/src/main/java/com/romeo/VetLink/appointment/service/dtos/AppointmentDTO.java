package com.romeo.VetLink.appointment.service.dtos;


import com.romeo.VetLink.patients.service.dtos.PatientDTO;
import lombok.Data;

@Data
public class AppointmentDTO {
    private Integer id;

    private String job;
    private String eventLength;
    private Boolean unscheduled;

    private PatientDTO patientDTO;
    private ConfirmedScheduleDTO confirmedScheduleDTO;
}
