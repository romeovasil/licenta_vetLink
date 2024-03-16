package com.romeo.VetLink.subscription.service.dtos;

import com.romeo.VetLink.shopItem.service.dtos.ShopItemDTO;
import lombok.Data;

import java.util.List;

@Data
public class SubscriptionDTO {
    Integer id;
    private String name;
    private String recurrence;
    private String price;
    private String shortDescription;
    private List<ShopItemDTO> shopItemDTOs;
}
