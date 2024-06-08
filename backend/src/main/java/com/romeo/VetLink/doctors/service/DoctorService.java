package com.romeo.VetLink.doctors.service;

import com.romeo.VetLink.doctors.domain.Doctor;
import com.romeo.VetLink.doctors.domain.DoctorJpaRepository;
import com.romeo.VetLink.doctors.exceptions.DoctorNotFoundException;
import com.romeo.VetLink.doctors.service.dtos.DoctorDTO;
import com.romeo.VetLink.doctors.service.dtos.mapper.DoctorDTOMapper;
import com.romeo.VetLink.patients.domain.Patient;
import com.romeo.VetLink.patients.service.dtos.PatientDTO;
import com.romeo.VetLink.patients.service.exceptions.PatientNotFoundException;
import com.romeo.VetLink.user.User;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.print.Doc;
import java.util.List;

@Service
@AllArgsConstructor
public class DoctorService {
    private final DoctorJpaRepository doctorJpaRepository;
    private final DoctorDTOMapper doctorDTOMapper;

    @Transactional
    public void save (DoctorDTO doctorDTO){
        Doctor doctor = this.doctorJpaRepository.save(this.doctorDTOMapper.mapDtoToEntity(doctorDTO));
    }

    public List<DoctorDTO> getAllByOwner() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Doctor> doctors = this.doctorJpaRepository.findAllByOwner(user.getClinicId());
        return doctors.stream().map(this.doctorDTOMapper::mapEntityToDTO).toList();
    }
    @Transactional
    public void deleteById(Integer doctorUuid) {
        this.doctorJpaRepository.deleteById(doctorUuid);
    }


    @Transactional
    public void update(DoctorDTO doctorDTO) {
        Doctor doctor = this.doctorJpaRepository.findById(doctorDTO.getId())
                .orElseThrow(DoctorNotFoundException::new);

        doctor = this.doctorDTOMapper.updateEntityFromDTO(doctor,doctorDTO);

        this.doctorJpaRepository.save(doctor);
    }

    public DoctorDTO getDetails(Integer doctorId) {
        Doctor doctor = this.doctorJpaRepository.findById(doctorId).orElseThrow(DoctorNotFoundException::new);

        return this.doctorDTOMapper.mapEntityToDTO(doctor);
    }
}
