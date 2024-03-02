package com.romeo.VetLink.shopItem.domain;

import com.romeo.VetLink.config.OwnedEntity;
import com.romeo.VetLink.user.User;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.context.SecurityContextHolder;

@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "shop_item")
public class ShopItem extends OwnedEntity {
    @Id
    @GeneratedValue
    private Integer id;

    private String name;
    private String category;
    private String price;
    private String quantity;
    private String shortDescription;

    @Override
    public void prePersist(){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        this.owner = user.getClinicId();
    }


}
