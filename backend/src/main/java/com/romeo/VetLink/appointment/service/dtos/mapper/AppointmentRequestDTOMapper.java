package com.romeo.VetLink.appointment.service.dtos.mapper;

import com.romeo.VetLink.appointment.domain.Appointment;
import com.romeo.VetLink.appointment.domain.AppointmentRequest;
import com.romeo.VetLink.appointment.service.dtos.AppointmentRequestDTO;
import org.springframework.stereotype.Component;

@Component
public class AppointmentRequestDTOMapper {

    public AppointmentRequest toEntity(AppointmentRequestDTO appointmentRequestDTO) {
        AppointmentRequest appointmentRequest = new AppointmentRequest();

        appointmentRequest.setDetails(appointmentRequestDTO.getDetails());
        appointmentRequest.setClinicId(appointmentRequestDTO.getClinicId());
        appointmentRequest.setCustomerEmail(appointmentRequestDTO.getCustomerEmail());
        appointmentRequest.setCustomerPhoneNumber(appointmentRequestDTO.getCustomerPhoneNumber());
        appointmentRequest.setCustomerId(appointmentRequestDTO.getCustomerId());

        return appointmentRequest;

    }
}
