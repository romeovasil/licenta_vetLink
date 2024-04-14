package com.romeo.VetLink.appointment.service.dtos.mapper;

import com.romeo.VetLink.appointment.domain.Appointment;
import com.romeo.VetLink.appointment.service.dtos.AppointmentDTO;
import com.romeo.VetLink.appointment.service.dtos.ConfirmedScheduleDTO;
import com.romeo.VetLink.patients.domain.Patient;
import com.romeo.VetLink.patients.domain.PatientJpaRepository;
import com.romeo.VetLink.patients.service.dtos.PatientDTO;
import com.romeo.VetLink.patients.service.dtos.mapper.PatientDTOMapper;
import com.romeo.VetLink.patients.service.exceptions.PatientNotFoundException;
import org.springframework.stereotype.Component;

@Component
public class AppointmentDTOMapper {
    private final PatientJpaRepository patientJpaRepository;
    private final PatientDTOMapper patientDTOMapper;

    public AppointmentDTOMapper(PatientJpaRepository patientJpaRepository, PatientDTOMapper patientDTOMapper) {
        this.patientJpaRepository = patientJpaRepository;
        this.patientDTOMapper = patientDTOMapper;
    }

    public Appointment mapDtoToEntity(AppointmentDTO appointmentDTO){

        Patient patient = patientJpaRepository.findById(appointmentDTO.getPatientDTO().getId()).orElseThrow(PatientNotFoundException::new);
        Appointment appointment = new Appointment();

        appointment.setPatient(patient);
        appointment.setJob(appointmentDTO.getJob());
        appointment.setEventLength(appointmentDTO.getEventLength());

        return appointment;
    }

    public AppointmentDTO mapEntityToDTO(Appointment appointment){
        PatientDTO patientDTO = patientDTOMapper.mapEntityToDTO(appointment.getPatient());

        AppointmentDTO appointmentDTO = new AppointmentDTO();

        appointmentDTO.setId(appointment.getId());
        appointmentDTO.setPatientDTO(patientDTO);
        appointmentDTO.setJob(appointment.getJob());
        appointmentDTO.setEventLength(appointment.getEventLength());
        appointmentDTO.setUnscheduled(appointment.getUnscheduled());

        if(appointment.getConfirmedSchedule() != null){
            ConfirmedScheduleDTO confirmedScheduleDTO = new ConfirmedScheduleDTO();

            confirmedScheduleDTO.setId(appointment.getConfirmedSchedule().getId());
            confirmedScheduleDTO.setEnd(appointment.getConfirmedSchedule().getEndTime());
            confirmedScheduleDTO.setStart(appointment.getConfirmedSchedule().getStart());
            confirmedScheduleDTO.setDoctorNumber(appointment.getConfirmedSchedule().getDoctorNumber());

            appointmentDTO.setConfirmedScheduleDTO(confirmedScheduleDTO);
        }



        return appointmentDTO;
    }
}
