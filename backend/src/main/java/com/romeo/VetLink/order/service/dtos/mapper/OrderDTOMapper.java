package com.romeo.VetLink.order.service.dtos.mapper;

import com.romeo.VetLink.order.domain.Order;
import com.romeo.VetLink.order.service.dtos.OrderDTO;
import com.romeo.VetLink.shopItem.domain.ShopItem;
import com.romeo.VetLink.shopItem.service.dtos.mapper.ShopItemDTOMapper;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class OrderDTOMapper {

    private final ShopItemDTOMapper shopItemDTOMapper;

    public OrderDTOMapper(ShopItemDTOMapper shopItemDTOMapper) {
        this.shopItemDTOMapper = shopItemDTOMapper;
    }

    public Order mapDTOToEntity(OrderDTO orderDTO) {
        List<ShopItem> shopItems = orderDTO.getItemDTOs().stream()
                .map(shopItemDTOMapper::mapDtoToEntity)
                .toList();

        Order order = new Order();

        order.setFirstName(orderDTO.getFirstName());
        order.setLastName(orderDTO.getLastName());
        order.setPhoneNumber(orderDTO.getPhoneNumber());
        order.setEmail(orderDTO.getEmail());

        order.setCustomerId(orderDTO.getCustomerId());
        order.setAddress(orderDTO.getAddress());
        order.setCity(orderDTO.getCity());
        order.setNumber(orderDTO.getNumber());
        order.setCounty(orderDTO.getCounty());
        order.setPrice(orderDTO.getPrice());
        order.setItems(shopItems);

        return order;
    }
}
