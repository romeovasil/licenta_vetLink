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
}
