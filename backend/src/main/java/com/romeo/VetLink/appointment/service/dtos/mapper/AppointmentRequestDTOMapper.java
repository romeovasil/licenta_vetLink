package com.romeo.VetLink.appointment.service.dtos.mapper;


import com.romeo.VetLink.appointment.domain.AppointmentRequest;
import com.romeo.VetLink.appointment.service.dtos.AppointmentRequestDTO;
import com.romeo.VetLink.patients.service.dtos.PatientDTO;
import com.romeo.VetLink.patients.service.dtos.mapper.PatientDTOMapper;
import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
public class AppointmentRequestDTOMapper {
    private final PatientDTOMapper patientDTOMapper;

    public AppointmentRequestDTOMapper(PatientDTOMapper patientDTOMapper) {
        this.patientDTOMapper = patientDTOMapper;
    }

    public AppointmentRequest toEntity(AppointmentRequestDTO appointmentRequestDTO) {
        AppointmentRequest appointmentRequest = new AppointmentRequest();

        appointmentRequest.setDetails(appointmentRequestDTO.getDetails());
        appointmentRequest.setClinicId(appointmentRequestDTO.getClinicId());
        appointmentRequest.setCustomerEmail(appointmentRequestDTO.getCustomerEmail());
        appointmentRequest.setCustomerPhoneNumber(appointmentRequestDTO.getCustomerPhoneNumber());
        appointmentRequest.setCustomerId(appointmentRequestDTO.getCustomerId());
        appointmentRequest.setDate(LocalDate.now());

        return appointmentRequest;

    }

    public AppointmentRequestDTO toDTO(AppointmentRequest appointmentRequest) {
        PatientDTO patientDTO = patientDTOMapper.mapEntityToDTO(appointmentRequest.getPatient());
        AppointmentRequestDTO appointmentRequestDTO = new AppointmentRequestDTO();

        appointmentRequestDTO.setId(appointmentRequest.getId());
        appointmentRequestDTO.setDetails(appointmentRequest.getDetails());
        appointmentRequestDTO.setClinicId(appointmentRequest.getClinicId());
        appointmentRequestDTO.setCustomerEmail(appointmentRequest.getCustomerEmail());
        appointmentRequestDTO.setCustomerPhoneNumber(appointmentRequest.getCustomerPhoneNumber());
        appointmentRequestDTO.setCustomerId(appointmentRequest.getCustomerId());
        appointmentRequestDTO.setPatientDTO(patientDTO);
        appointmentRequestDTO.setDate(appointmentRequest.getDate());

        return appointmentRequestDTO;

    }
}
