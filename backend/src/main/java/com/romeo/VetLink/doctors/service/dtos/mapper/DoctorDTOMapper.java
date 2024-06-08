package com.romeo.VetLink.doctors.service.dtos.mapper;

import com.romeo.VetLink.doctors.domain.Doctor;
import com.romeo.VetLink.doctors.service.dtos.DoctorDTO;
import org.springframework.stereotype.Component;

@Component
public class DoctorDTOMapper {

    public Doctor mapDtoToEntity(DoctorDTO doctorDTO){

        Doctor doctor = new Doctor();

        doctor.setFirstName(doctorDTO.getFirstName());
        doctor.setLastName(doctorDTO.getLastName());
        doctor.setSpeciality(doctorDTO.getSpeciality());

        return doctor;
    }

    public DoctorDTO mapEntityToDTO(Doctor doctor){

        DoctorDTO doctorDTO = new DoctorDTO();

        doctorDTO.setId(doctor.getId());
        doctorDTO.setFirstName(doctor.getFirstName());
        doctorDTO.setLastName(doctor.getLastName());
        doctorDTO.setSpeciality(doctor.getSpeciality());

        return doctorDTO;
    }

    public Doctor updateEntityFromDTO(Doctor doctor, DoctorDTO doctorDTO) {

        doctor.setId(doctor.getId());

        doctor.setFirstName(doctorDTO.getFirstName());
        doctor.setLastName(doctorDTO.getLastName());
        doctor.setSpeciality(doctorDTO.getSpeciality());

        return doctor;
    }
}
