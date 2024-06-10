package com.romeo.VetLink.order.service.dtos;


import com.romeo.VetLink.shopItem.service.dtos.ShopItemDTO;
import lombok.Data;

import java.util.List;

@Data
public class OrderDTO {
    private String firstName;
    private String lastName;
    private String phoneNumber;
    private String customerId;
    private String email;
    private String county;
    private String city;
    private String address;
    private String number;
    private Double price;
    private List<ShopItemDTO> itemDTOs;
}
