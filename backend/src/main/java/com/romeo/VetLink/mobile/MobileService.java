package com.romeo.VetLink.mobile;

import com.romeo.VetLink.doctors.domain.Doctor;
import com.romeo.VetLink.shopItem.domain.ShopItem;
import com.romeo.VetLink.shopItem.domain.ShopItemJpaRepository;
import com.romeo.VetLink.shopItem.service.dtos.ShopItemDTO;
import com.romeo.VetLink.shopItem.service.dtos.mapper.ShopItemDTOMapper;
import com.romeo.VetLink.vetClinic.domain.VetClinic;
import com.romeo.VetLink.vetClinic.domain.VetClinicJpaRepository;
import com.romeo.VetLink.vetClinic.service.dtos.VetClinicDTO;
import com.romeo.VetLink.vetClinic.service.dtos.mapper.VetClinicDTOMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class MobileService {

    private final VetClinicJpaRepository vetClinicJpaRepository;
    private final ShopItemJpaRepository shopItemJpaRepository;
    private final VetClinicDTOMapper vetClinicDTOMapper;
    private final ShopItemDTOMapper shopItemDTOMapper;

    public List<VetClinicDTO> getAllClinics() {

        List<VetClinic> vetClinic = this.vetClinicJpaRepository.findAll();
        return vetClinic.stream().map(this.vetClinicDTOMapper::mapEntityToDto).toList();
    }

    public List<ShopItemDTO> getAllShopItemsByOwnerUuid(Integer ownerUuid) {

        List<ShopItem> vetClinic = this.shopItemJpaRepository.findAllByOwner(ownerUuid);
        return vetClinic.stream().map(this.shopItemDTOMapper::mapEntityToDTO).toList();
    }
}
