package com.romeo.VetLink.appointment.service.dtos;


import com.romeo.VetLink.patients.service.dtos.PatientDTO;
import lombok.Data;

@Data
public class AppointmentRequestDTO {

    private String customerId;
    private String clinicId;
    private String customerEmail;
    private String customerPhoneNumber;
    private String details;
    private PatientDTO patientDTO;



}
