package com.romeo.VetLink.shopItem.service;

import com.romeo.VetLink.shopItem.domain.ShopItem;
import com.romeo.VetLink.shopItem.domain.ShopItemJpaRepository;
import com.romeo.VetLink.shopItem.service.dtos.ShopItemDTO;
import com.romeo.VetLink.shopItem.service.dtos.mapper.ShopItemDTOMapper;
import com.romeo.VetLink.user.User;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@AllArgsConstructor
public class ShopItemService {
    private final ShopItemJpaRepository shopItemJpaRepository;
    private final ShopItemDTOMapper shopItemDTOMapper;

    @Transactional
    public void save (ShopItemDTO shopItemDTO){
        ShopItem shopItem = this.shopItemJpaRepository.save(this.shopItemDTOMapper.mapDtoToEntity(shopItemDTO));
    }

    public List<ShopItem> getAllByOwner() {
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return this.shopItemJpaRepository.findAllByOwner(user.getClinicId());
    }

    public void deleteById(Integer shopItemId) {
        this.shopItemJpaRepository.deleteById(shopItemId);
    }
}
