package com.romeo.VetLink.subscription.service.dtos;

import lombok.Data;

import java.time.LocalDate;

@Data
public class CustomerSubscriptionDTO {
    Integer id;
    private String customerId;
    private LocalDate validFrom;
    private LocalDate validUntil;
    private Boolean canceled;
    private SubscriptionDTO subscriptionDTO;
}
