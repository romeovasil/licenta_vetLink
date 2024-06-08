package com.romeo.VetLink.appointment.service;

import com.romeo.VetLink.appointment.domain.Appointment;
import com.romeo.VetLink.appointment.domain.AppointmentJpaRepository;
import com.romeo.VetLink.appointment.domain.ConfirmedSchedule;
import com.romeo.VetLink.appointment.domain.ConfirmedScheduleJpaRepository;
import com.romeo.VetLink.appointment.service.dtos.ConfirmedScheduleDTO;
import com.romeo.VetLink.appointment.service.dtos.mapper.AppointmentDTOMapper;
import com.romeo.VetLink.appointment.service.dtos.AppointmentDTO;

import com.romeo.VetLink.appointment.service.exceptions.AppointmentNotFoundException;
import com.romeo.VetLink.doctors.domain.Doctor;
import com.romeo.VetLink.doctors.domain.DoctorJpaRepository;
import com.romeo.VetLink.doctors.exceptions.DoctorNotFoundException;
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

    @Transactional
    public void save (AppointmentDTO appointmentDTO){
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
}
