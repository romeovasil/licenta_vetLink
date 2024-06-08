package com.romeo.VetLink.patients.service.dtos.mapper;

import com.romeo.VetLink.doctors.domain.Doctor;
import com.romeo.VetLink.doctors.service.dtos.DoctorDTO;
import com.romeo.VetLink.patients.domain.Patient;
import com.romeo.VetLink.patients.service.dtos.PatientDTO;
import org.springframework.stereotype.Component;

@Component
public class PatientDTOMapper {

    public Patient mapDtoToEntity(PatientDTO patientDTO){

        Patient patient= new Patient();

        patient.setType(patientDTO.getType());
        patient.setRace(patientDTO.getRace());
        patient.setSubRace(patientDTO.getSubRace());
        patient.setName(patientDTO.getName());
        patient.setAge(patientDTO.getAge());
        patient.setAllergy(patientDTO.getAllergy());
        patient.setHealthProblems(patientDTO.getHealthProblems());

        return patient;
    }

    public PatientDTO mapEntityToDTO(Patient patient){

        PatientDTO patientDTO = new PatientDTO();

        patientDTO.setId(patient.getId());
        patientDTO.setType(patient.getType());
        patientDTO.setRace(patient.getRace());
        patientDTO.setSubRace(patient.getSubRace());
        patientDTO.setName(patient.getName());
        patientDTO.setAge(patient.getAge());
        patientDTO.setAllergy(patient.getAllergy());
        patientDTO.setHealthProblems(patient.getHealthProblems());

        return patientDTO;
    }

    public Patient updateEntityFromDTO(Patient patient, PatientDTO patientDTO){


        patient.setId(patientDTO.getId());
        patient.setType(patientDTO.getType());
        patient.setRace(patientDTO.getRace());
        patient.setSubRace(patientDTO.getSubRace());
        patient.setName(patientDTO.getName());
        patient.setAge(patientDTO.getAge());
        patient.setAllergy(patientDTO.getAllergy());
        patient.setHealthProblems(patientDTO.getHealthProblems());

        return patient;
    }
}
