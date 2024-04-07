package com.romeo.VetLink.appointment.service;

import com.romeo.VetLink.appointment.domain.Appointment;
import com.romeo.VetLink.appointment.domain.AppointmentJpaRepository;
import com.romeo.VetLink.appointment.service.dtos.AppointmentDTOMapper;
import com.romeo.VetLink.appointment.service.dtos.mapper.AppointmentDTO;

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
}
