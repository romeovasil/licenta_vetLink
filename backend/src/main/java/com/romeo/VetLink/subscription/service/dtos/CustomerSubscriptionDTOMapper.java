package com.romeo.VetLink.subscription.service.dtos;

import com.romeo.VetLink.subscription.domain.CustomerSubscription;
import com.romeo.VetLink.subscription.domain.Subscription;
import com.romeo.VetLink.subscription.domain.SubscriptionJpaRepository;
import org.springframework.stereotype.Component;

import java.time.LocalDate;


@Component
public class CustomerSubscriptionDTOMapper {
    private final SubscriptionJpaRepository subscriptionJpaRepository;
    private final SubscriptionDTOMapper subscriptionDTOMapper;


    public CustomerSubscriptionDTOMapper(SubscriptionJpaRepository subscriptionJpaRepository, SubscriptionDTOMapper subscriptionDTOMapper) {
        this.subscriptionJpaRepository = subscriptionJpaRepository;
        this.subscriptionDTOMapper = subscriptionDTOMapper;
    }

    public CustomerSubscription mapDtoToEntity(CustomerSubscriptionDTO customerSubscriptionDTO){
        Subscription subscription = subscriptionJpaRepository.findById(customerSubscriptionDTO.getSubscriptionDTO().getId()).orElseThrow();

        CustomerSubscription customerSubscription = new CustomerSubscription();

        customerSubscription.setSubscription(subscription);
        customerSubscription.setCustomerId(customerSubscriptionDTO.getCustomerId());
        customerSubscription.setValidFrom(LocalDate.now());

        LocalDate validTo ;
        if (subscription.getRecurrence().equals("Saptamanal")) {
            validTo = LocalDate.now().plusWeeks(1);
        } else if (subscription.getRecurrence().equals("Lunar")) {
            validTo = LocalDate.now().plusMonths(1);
        } else {
            validTo = LocalDate.now().plusYears(1);
        }
        customerSubscription.setValidTo(validTo);

        return customerSubscription;
    }

    public CustomerSubscriptionDTO mapEntityToDto(CustomerSubscription customerSubscription){
        CustomerSubscriptionDTO customerSubscriptionDTO = new CustomerSubscriptionDTO();

        customerSubscriptionDTO.setId(customerSubscription.getId());

        customerSubscriptionDTO.setCustomerId(customerSubscription.getCustomerId());
        customerSubscriptionDTO.setSubscriptionDTO(subscriptionDTOMapper.mapEntityToDTO(customerSubscription.getSubscription()));
        customerSubscriptionDTO.setId(customerSubscription.getId());
        customerSubscriptionDTO.setValidFrom(customerSubscription.getValidFrom());
        customerSubscriptionDTO.setValidUntil(customerSubscription.getValidTo());

        return customerSubscriptionDTO;

    }
}
