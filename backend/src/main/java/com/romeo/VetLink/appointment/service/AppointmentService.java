package com.romeo.VetLink.appointment.service;

import com.romeo.VetLink.appointment.domain.*;
import com.romeo.VetLink.appointment.service.dtos.AppointmentRequestDTO;
import com.romeo.VetLink.appointment.service.dtos.ConfirmedScheduleDTO;
import com.romeo.VetLink.appointment.service.dtos.mapper.AppointmentDTOMapper;
import com.romeo.VetLink.appointment.service.dtos.AppointmentDTO;

import com.romeo.VetLink.appointment.service.dtos.mapper.AppointmentRequestDTOMapper;
import com.romeo.VetLink.appointment.service.exceptions.AppointmentNotFoundException;
import com.romeo.VetLink.doctors.domain.Doctor;
import com.romeo.VetLink.doctors.domain.DoctorJpaRepository;
import com.romeo.VetLink.doctors.exceptions.DoctorNotFoundException;
import com.romeo.VetLink.patients.domain.Patient;
import com.romeo.VetLink.patients.domain.PatientJpaRepository;
import com.romeo.VetLink.patients.service.dtos.mapper.PatientDTOMapper;
import com.romeo.VetLink.user.User;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class AppointmentService {
    private final AppointmentJpaRepository appointmentJpaRepository;
    private final ConfirmedScheduleJpaRepository confirmedScheduleJpaRepository;
    private final DoctorJpaRepository doctorJpaRepository;
    private final AppointmentDTOMapper appointmentDTOMapper;
    private final PatientDTOMapper patientDTOMapper;
    private final PatientJpaRepository patientJpaRepository;
    private final AppointmentRequestDTOMapper appointmentRequestDTOMapper;
    private final AppointmentRequestJpaRepository appointmentRequestJpaRepository;

    @Transactional
    public void save (AppointmentDTO appointmentDTO){
        if(appointmentDTO.getRequestId() != null){
            deleteAppointmentRequestById(appointmentDTO.getRequestId());
        }
        Appointment appointment = this.appointmentJpaRepository.save(this.appointmentDTOMapper.mapDtoToEntity(appointmentDTO));
    }

    public List<AppointmentDTO> getAllByOwner() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Appointment> appointments = this.appointmentJpaRepository.findAllByOwner(user.getClinicId());
        return appointments.stream().map(this.appointmentDTOMapper::mapEntityToDTO).toList();
    }

    @Transactional
    public void deleteById(Integer appointmentId) {
        this.appointmentJpaRepository.deleteById(appointmentId);
    }

    @Transactional(readOnly = true)
    public void getById(Integer appointmentId) {
        this.appointmentJpaRepository.findById(appointmentId);
    }
    @Transactional
    public void confirmScheduleForAppointment(Integer appointmentId, ConfirmedScheduleDTO confirmedScheduleDTO) {
        Appointment appointment = this.appointmentJpaRepository.findById(appointmentId).orElseThrow(AppointmentNotFoundException::new);
        Doctor doctor = this.doctorJpaRepository.findById(confirmedScheduleDTO.getDoctorNumber()).orElseThrow(DoctorNotFoundException::new);

        ConfirmedSchedule confirmedSchedule = new ConfirmedSchedule();
        confirmedSchedule.setStart(confirmedScheduleDTO.getStart());
        confirmedSchedule.setEndTime(confirmedScheduleDTO.getEnd());
        confirmedSchedule.setDoctor(doctor);

        this.confirmedScheduleJpaRepository.save(confirmedSchedule);

        appointment.setConfirmedSchedule(confirmedSchedule);
        appointment.setUnscheduled(false);
        this.appointmentJpaRepository.save(appointment);
    }

    @Transactional
    public void updateSchedule(ConfirmedScheduleDTO updatedScheduleDTO) {

        ConfirmedSchedule confirmedSchedule = this.confirmedScheduleJpaRepository.findById(updatedScheduleDTO.getId()).orElseThrow();
        Doctor doctor = this.doctorJpaRepository.findById(updatedScheduleDTO.getDoctorNumber()).orElseThrow(DoctorNotFoundException::new);

        confirmedSchedule.setDoctor(doctor);
        confirmedSchedule.setStart(updatedScheduleDTO.getStart());
        confirmedSchedule.setEndTime(updatedScheduleDTO.getEnd());

        this.confirmedScheduleJpaRepository.save(confirmedSchedule);
    }

    @Transactional
    public AppointmentRequest saveAppointmentRequest(AppointmentRequestDTO appointmentRequestDTO){
        Patient patient = patientDTOMapper.mapDtoToEntity(appointmentRequestDTO.getPatientDTO());
        patient.setOwner(Integer.valueOf(appointmentRequestDTO.getClinicId()));

        patientJpaRepository.save(patient);

        AppointmentRequest appointmentRequest = appointmentRequestDTOMapper.toEntity(appointmentRequestDTO);
        appointmentRequest.setPatient(patient);

        appointmentRequestJpaRepository.save(appointmentRequest);

        return appointmentRequest;
    }
    @Transactional(readOnly = true)
    public List<AppointmentRequestDTO> getAllAppointmentRequestsByOwner() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<AppointmentRequest> appointmentRequests = this.appointmentRequestJpaRepository.findAllByOwner(user.getClinicId());
        return appointmentRequests.stream().map(this.appointmentRequestDTOMapper::toDTO).toList();
    }

    @Transactional
    public void deleteAppointmentRequestById(Integer appointmentRequestId) {
        appointmentRequestJpaRepository.deleteById(appointmentRequestId);
    }
}
