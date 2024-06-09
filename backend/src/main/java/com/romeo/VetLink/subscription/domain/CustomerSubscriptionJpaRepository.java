package com.romeo.VetLink.subscription.domain;



import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface CustomerSubscriptionJpaRepository extends JpaRepository<CustomerSubscription, Integer> {

    @Query("SELECT cs FROM CustomerSubscription cs WHERE cs.customerId = :customerId AND cs.validFrom <= :today AND cs.validTo >= :today")
    Optional<CustomerSubscription> findValidSubscriptionForUser(@Param("customerId") String customerId, @Param("today") LocalDate today);

}
