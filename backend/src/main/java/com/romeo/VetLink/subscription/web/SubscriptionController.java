package com.romeo.VetLink.subscription.web;

import com.romeo.VetLink.shopItem.service.ShopItemService;
import com.romeo.VetLink.shopItem.service.dtos.ShopItemDTO;
import com.romeo.VetLink.subscription.service.SubscriptionService;
import com.romeo.VetLink.subscription.service.dtos.SubscriptionDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials="true")
@RestController
@RequestMapping("api/v1/subscription")
@RequiredArgsConstructor
public class SubscriptionController {

    private final SubscriptionService subscriptionService;

    @PostMapping()
    public ResponseEntity<?> save(
            @RequestBody SubscriptionDTO subscriptionDTO){
        subscriptionService.save(subscriptionDTO);
        return ResponseEntity.ok().build();
    }

    @GetMapping()
    public ResponseEntity<?> getAllByOwner(){
        return ResponseEntity.ok(subscriptionService.getAllByOwner());
    }


}
