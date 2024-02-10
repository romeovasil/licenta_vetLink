package com.romeo.VetLink.vetClinic.service.dtos;

import com.romeo.VetLink.user.User;
import com.romeo.VetLink.vetClinic.domain.VetClinic;
import com.romeo.VetLink.vetClinic.domain.VetClinicJpaRepository;
import com.romeo.VetLink.vetClinic.service.dtos.mapper.VetClinicDTOMapper;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class VetClinicService {
    private final VetClinicJpaRepository vetClinicJpaRepository;
    private final VetClinicDTOMapper vetClinicDTOMapper;
    public void save (VetClinicDTO vetClinicDTO){
        this.vetClinicJpaRepository.save(this.vetClinicDTOMapper.mapDtoToEntity(vetClinicDTO));

    }

    public List<VetClinic> getExistingVetClinicForCurrentUser() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return this.vetClinicJpaRepository.findAllByOwner(String.valueOf(user.getId()));
    }
}
