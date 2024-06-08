package com.romeo.VetLink.vetClinic.service.dtos;

import com.romeo.VetLink.user.User;
import com.romeo.VetLink.user.UserService;
import com.romeo.VetLink.vetClinic.domain.VetClinic;
import com.romeo.VetLink.vetClinic.domain.VetClinicJpaRepository;
import com.romeo.VetLink.vetClinic.service.dtos.mapper.VetClinicDTOMapper;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class VetClinicService {
    private final VetClinicJpaRepository vetClinicJpaRepository;
    private final VetClinicDTOMapper vetClinicDTOMapper;
    private final UserService userService;
    @Transactional
    public void save (VetClinicDTO vetClinicDTO){
        VetClinic vetClinic = this.vetClinicJpaRepository.save(this.vetClinicDTOMapper.mapDtoToEntity(vetClinicDTO));
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<User> user1 = userService.findById(user.getId());
        user1.ifPresent(value -> value.setClinicId(vetClinic.getId()));

    }

    public VetClinic getExistingVetClinicForCurrentUser() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return this.vetClinicJpaRepository.findByOwner(user.getId());
    }

    @Transactional
    public VetClinicDTO update(VetClinicDTO vetClinicDTO) {
        VetClinic vetClinic = this.vetClinicJpaRepository.findById(vetClinicDTO.getId()).orElseThrow();

        vetClinic = this.vetClinicDTOMapper.updateEntityFromDto(vetClinic, vetClinicDTO);

        this.vetClinicJpaRepository.save(vetClinic);

        return this.vetClinicDTOMapper.mapEntityToDto(vetClinic);
    }
}
