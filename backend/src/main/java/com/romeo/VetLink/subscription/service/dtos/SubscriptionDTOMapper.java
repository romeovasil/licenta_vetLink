package com.romeo.VetLink.subscription.service.dtos;


import com.romeo.VetLink.shopItem.domain.ShopItem;
import com.romeo.VetLink.shopItem.domain.ShopItemJpaRepository;
import com.romeo.VetLink.shopItem.service.dtos.ShopItemDTO;
import com.romeo.VetLink.shopItem.service.dtos.mapper.ShopItemDTOMapper;
import com.romeo.VetLink.subscription.domain.Subscription;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class SubscriptionDTOMapper {
    private final ShopItemJpaRepository shopItemJpaRepository;
    private final ShopItemDTOMapper shopItemDTOMapper;

    public SubscriptionDTOMapper(ShopItemJpaRepository shopItemJpaRepository, ShopItemDTOMapper shopItemDTOMapper) {
        this.shopItemJpaRepository = shopItemJpaRepository;
        this.shopItemDTOMapper = shopItemDTOMapper;
    }

    public Subscription mapDtoToEntity(SubscriptionDTO subscriptionDTO){

        Subscription subscription = new Subscription();


        subscription.setName(subscriptionDTO.getName());
        subscription.setRecurrence(subscriptionDTO.getRecurrence());
        subscription.setPrice(subscriptionDTO.getPrice());
        subscription.setShortDescription(subscriptionDTO.getShortDescription());

        List<ShopItem> shopItemList = new ArrayList<>();
        for (ShopItemDTO shopItemDTO : subscriptionDTO.getShopItemDTOs()) {
            Optional<ShopItem> optionalShopItem = shopItemJpaRepository.findById(shopItemDTO.getId());
            if (optionalShopItem.isPresent()) {
                shopItemList.add(optionalShopItem.get());
            } else {
                throw new IllegalArgumentException("ShopItem with ID " + shopItemDTO.getId() + " not found");
            }
        }
        subscription.setShopItems(shopItemList);

        return subscription;
    }

    public SubscriptionDTO mapEntityToDTO(Subscription subscription){

        SubscriptionDTO subscriptionDTO = new SubscriptionDTO();

        subscriptionDTO.setId(subscription.getId());
        subscriptionDTO.setRecurrence(subscription.getRecurrence());
        subscriptionDTO.setName(subscription.getName());
        subscriptionDTO.setShortDescription(subscription.getShortDescription());
        subscriptionDTO.setPrice(subscription.getPrice());

        subscriptionDTO.setShopItemDTOs(subscription.getShopItems().stream().map(shopItemDTOMapper::mapEntityToDTO).toList());


        return subscriptionDTO;
    }
}
