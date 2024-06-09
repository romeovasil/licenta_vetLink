package com.romeo.VetLink.subscription.domain;

import com.romeo.VetLink.config.IdentifiableEntity;
import com.romeo.VetLink.config.OwnedEntity;
import com.romeo.VetLink.shopItem.domain.ShopItem;
import com.romeo.VetLink.user.User;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.context.SecurityContextHolder;

import java.time.LocalDate;
import java.util.List;
import java.util.Set;

@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "customer_subscription")
public class CustomerSubscription extends IdentifiableEntity {

    private String customerId;
    private Boolean canceled;
    private LocalDate validFrom;
    private LocalDate validTo;

    @ManyToOne
    private Subscription subscription;



}
