package com.romeo.VetLink.shopItem.service.dtos;

import lombok.Data;

@Data
public class ShopItemDTO {
    Integer id;
     String name;
     String category;
     String price;
     String quantity;
     String shortDescription;
    String owner;
}
