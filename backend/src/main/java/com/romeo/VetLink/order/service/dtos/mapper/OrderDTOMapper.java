package com.romeo.VetLink.order.service.dtos.mapper;

import com.romeo.VetLink.order.domain.Order;
import com.romeo.VetLink.order.service.dtos.OrderDTO;
import com.romeo.VetLink.shopItem.domain.ShopItem;
import com.romeo.VetLink.shopItem.service.dtos.ShopItemDTO;
import com.romeo.VetLink.shopItem.service.dtos.mapper.ShopItemDTOMapper;
import com.romeo.VetLink.vetClinic.domain.VetClinic;
import com.romeo.VetLink.vetClinic.domain.VetClinicJpaRepository;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.List;

@Component
public class OrderDTOMapper {

    private final ShopItemDTOMapper shopItemDTOMapper;
    private final VetClinicJpaRepository vetClinicJpaRepository;

    public OrderDTOMapper(ShopItemDTOMapper shopItemDTOMapper, VetClinicJpaRepository vetClinicJpaRepository) {
        this.shopItemDTOMapper = shopItemDTOMapper;
        this.vetClinicJpaRepository = vetClinicJpaRepository;
    }

    public Order mapDTOToEntity(OrderDTO orderDTO) {
        List<ShopItem> shopItems = orderDTO.getItemDTOs().stream()
                .map(shopItemDTOMapper::mapDtoToEntity)
                .toList();

        VetClinic vetclinic = vetClinicJpaRepository.findById(shopItems.get(0).getOwner()).orElseThrow();

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
        order.setClinicName(vetclinic.getName());
        order.setOrderDate(LocalDate.now());

        return order;
    }

    public OrderDTO mapEntityToDTO(Order order) {
        List<ShopItemDTO> shopItemDTOs = order.getItems().stream()
                .map(shopItemDTOMapper::mapEntityToDTO)
                .toList();
        OrderDTO orderDTO = new OrderDTO();

        orderDTO.setFirstName(order.getFirstName());
        orderDTO.setLastName(order.getLastName());
        orderDTO.setPhoneNumber(order.getPhoneNumber());
        orderDTO.setEmail(order.getEmail());

        orderDTO.setCustomerId(order.getCustomerId());
        orderDTO.setAddress(order.getAddress());
        orderDTO.setCity(order.getCity());
        orderDTO.setNumber(order.getNumber());
        orderDTO.setCounty(order.getCounty());
        orderDTO.setPrice(order.getPrice());
        orderDTO.setOrderDate(order.getOrderDate());
        orderDTO.setClinicName(order.getClinicName());
        orderDTO.setItemDTOs(shopItemDTOs);

        return orderDTO;
    }
}
