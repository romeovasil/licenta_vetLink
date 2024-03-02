package com.romeo.VetLink.shopItem.domain;


import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ShopItemJpaRepository extends JpaRepository<ShopItem, Integer> {
    List<ShopItem> findAllByOwner(Integer owner);
}
