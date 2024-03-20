package com.romeo.VetLink.patients.service;


import com.romeo.VetLink.patients.domain.Patient;
import com.romeo.VetLink.patients.domain.PatientJpaRepository;
import com.romeo.VetLink.patients.service.dtos.PatientDTO;
import com.romeo.VetLink.patients.service.dtos.mapper.PatientDTOMapper;
import com.romeo.VetLink.user.User;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class PatientService {
    private final PatientJpaRepository patientJpaRepository;
    private final PatientDTOMapper patientDTOMapper;

    @Transactional
    public void save (PatientDTO patientDTO){
        Patient patient = this.patientJpaRepository.save(this.patientDTOMapper.mapDtoToEntity(patientDTO));
    }

    public List<PatientDTO> getAllByOwner() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Patient> patients = this.patientJpaRepository.findAllByOwner(user.getClinicId());
        return patients.stream().map(this.patientDTOMapper::mapEntityToDTO).toList();
    }
    @Transactional
    public void deleteById(Integer patientId) {
        this.patientJpaRepository.deleteById(patientId);
    }
}
