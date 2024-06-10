package com.romeo.VetLink.order.domain;


import com.romeo.VetLink.config.IdentifiableEntity;
import com.romeo.VetLink.config.OwnedEntity;
import com.romeo.VetLink.shopItem.domain.ShopItem;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.List;


@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "shop_order")
public class Order extends IdentifiableEntity {

    private String customerId;

    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    private String county;
    private String city;
    private String address;
    private String number;
    private Integer price;
    private String clinicName;
    private LocalDate orderDate;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "order_shop_item",
            joinColumns = @JoinColumn(name = "order_id"),
            inverseJoinColumns = @JoinColumn(name = "shop_item_id")
    )
    private List<ShopItem> items;


}
