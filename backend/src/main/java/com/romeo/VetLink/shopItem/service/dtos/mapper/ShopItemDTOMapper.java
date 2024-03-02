package com.romeo.VetLink.shopItem.service.dtos.mapper;

import com.romeo.VetLink.shopItem.domain.ShopItem;
import com.romeo.VetLink.shopItem.service.dtos.ShopItemDTO;
import org.springframework.stereotype.Component;

@Component
public class ShopItemDTOMapper {

    public ShopItem mapDtoToEntity(ShopItemDTO shopItemDTO){

        ShopItem shopItem = new ShopItem();

        shopItem.setName(shopItemDTO.getName());
        shopItem.setCategory(shopItemDTO.getCategory());
        shopItem.setPrice(shopItemDTO.getPrice());
        shopItem.setShortDescription(shopItemDTO.getShortDescription());
        shopItem.setQuantity(shopItemDTO.getQuantity());

        return shopItem;
    }

    public ShopItemDTO mapEntityToDTO(ShopItem shopItem){

        ShopItemDTO shopItemDTO = new ShopItemDTO();

        shopItemDTO.setName(shopItem.getName());
        shopItemDTO.setCategory(shopItem.getCategory());
        shopItemDTO.setPrice(shopItem.getPrice());
        shopItemDTO.setShortDescription(shopItem.getShortDescription());
        shopItemDTO.setQuantity(shopItem.getQuantity());

        return shopItemDTO;
    }
}
