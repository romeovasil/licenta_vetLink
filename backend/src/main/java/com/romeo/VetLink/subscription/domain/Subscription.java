package com.romeo.VetLink.subscription.domain;

import com.romeo.VetLink.config.OwnedEntity;
import com.romeo.VetLink.shopItem.domain.ShopItem;
import com.romeo.VetLink.user.User;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.List;
import java.util.Set;

@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "subscription")
public class Subscription extends OwnedEntity {
    @Id
    @GeneratedValue
    private Integer id;

    private String name;
    private String recurrence;
    private String price;
    private String shortDescription;
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "subscription_shop_item",
            joinColumns = @JoinColumn(name = "subscription_id"),
            inverseJoinColumns = @JoinColumn(name = "shop_item_id")
    )
    private List<ShopItem> shopItems;

    @Override
    public void prePersist(){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        this.owner = user.getClinicId();
    }

    @Override
    public String toString() {
        return "Subscription{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", recurrence='" + recurrence + '\'' +
                ", price='" + price + '\'' +
                ", shortDescription='" + shortDescription + '\'' +
                '}';
    }

}
