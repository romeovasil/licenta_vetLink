package com.romeo.VetLink.subscription.service;
import com.romeo.VetLink.subscription.domain.CustomerSubscription;
import com.romeo.VetLink.subscription.domain.CustomerSubscriptionJpaRepository;
import com.romeo.VetLink.subscription.domain.Subscription;
import com.romeo.VetLink.subscription.domain.SubscriptionJpaRepository;
import com.romeo.VetLink.subscription.service.dtos.CustomerSubscriptionDTO;
import com.romeo.VetLink.subscription.service.dtos.CustomerSubscriptionDTOMapper;
import com.romeo.VetLink.subscription.service.dtos.SubscriptionDTO;
import com.romeo.VetLink.subscription.service.dtos.SubscriptionDTOMapper;
import com.romeo.VetLink.user.User;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class CustomerSubscriptionService {
    private final CustomerSubscriptionJpaRepository customerSubscriptionJpaRepository;
    private final CustomerSubscriptionDTOMapper customerSubscriptionDTOMapper;

    @Transactional
    public void save (CustomerSubscriptionDTO customerSubscriptionDTO){

        Optional<CustomerSubscription> existingValidCustomerSubscription = customerSubscriptionJpaRepository.findValidSubscriptionForUser(customerSubscriptionDTO.getCustomerId(), LocalDate.now());

        if(existingValidCustomerSubscription.isEmpty()){
            CustomerSubscription customerSubscription = this.customerSubscriptionJpaRepository.save(
                    this.customerSubscriptionDTOMapper.mapDtoToEntity(customerSubscriptionDTO));

            customerSubscriptionJpaRepository.save(customerSubscription);
        }
        else {
            throw new RuntimeException();
        }

    }

    public CustomerSubscriptionDTO getCurrentByCustomerId(String customerId) {
        Optional<CustomerSubscription> existingValidCustomerSubscription = customerSubscriptionJpaRepository.findValidSubscriptionForUser(customerId, LocalDate.now());

        return existingValidCustomerSubscription.map(this.customerSubscriptionDTOMapper::mapEntityToDto).orElse(null);

    }
}
