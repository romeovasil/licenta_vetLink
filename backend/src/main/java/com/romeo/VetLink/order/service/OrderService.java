package com.romeo.VetLink.order.service;

import com.romeo.VetLink.order.domain.Order;
import com.romeo.VetLink.order.domain.OrderJpaRepository;
import com.romeo.VetLink.order.service.dtos.OrderDTO;
import com.romeo.VetLink.order.service.dtos.mapper.OrderDTOMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class OrderService {

    private final OrderJpaRepository orderJpaRepository;
    private final OrderDTOMapper orderDTOMapper;

    @Transactional
    public void saveOrder(OrderDTO orderDTO){
        Order order = orderDTOMapper.mapDTOToEntity(orderDTO);

        orderJpaRepository.save(order);
    }

    @Transactional(readOnly = true)
    public List<OrderDTO> getAllOrdersByCustomerId(String customerId){
        List<Order> orders = orderJpaRepository.findAllByCustomerId(customerId);

        return orders.stream().map(orderDTOMapper::mapEntityToDTO).toList();
    }
}
