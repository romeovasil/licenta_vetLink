package com.romeo.VetLink.subscription.domain;



import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SubscriptionJpaRepository extends JpaRepository<Subscription, Integer> {
    List<Subscription> findAllByOwner(Integer owner);

}
