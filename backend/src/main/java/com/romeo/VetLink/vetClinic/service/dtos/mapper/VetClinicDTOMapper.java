package com.romeo.VetLink.vetClinic.service.dtos.mapper;

import com.romeo.VetLink.vetClinic.domain.VetClinic;
import com.romeo.VetLink.vetClinic.service.dtos.VetClinicDTO;
import org.springframework.stereotype.Component;

@Component
public class VetClinicDTOMapper {

    public VetClinic mapDtoToEntity(VetClinicDTO vetClinicDTO){

        VetClinic vetClinic = new VetClinic();

        vetClinic.setName(vetClinicDTO.getName());
        vetClinic.setCity(vetClinicDTO.getCity());
        vetClinic.setCounty(vetClinicDTO.getCounty());
        vetClinic.setStreet(vetClinicDTO.getStreet());
        vetClinic.setPhoneNumber(vetClinicDTO.getPhoneNumber());
        vetClinic.setShortDescription(vetClinicDTO.getShortDescription());

        return vetClinic;
    }

    public VetClinicDTO mapEntityToDto(VetClinic vetClinic){

        VetClinicDTO vetClinicDTO = new VetClinicDTO();

        vetClinicDTO.setId(vetClinic.getId());

        vetClinicDTO.setName(vetClinic.getName());
        vetClinicDTO.setCity(vetClinic.getCity());
        vetClinicDTO.setCounty(vetClinic.getCounty());
        vetClinicDTO.setStreet(vetClinic.getStreet());
        vetClinicDTO.setPhoneNumber(vetClinic.getPhoneNumber());
        vetClinicDTO.setShortDescription(vetClinic.getShortDescription());

        return vetClinicDTO;
    }
}
