package com.romeo.VetLink.mobile;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("api/v1/mobile")
@RequiredArgsConstructor
public class MobileController {

    private final MobileService mobileService;
    @GetMapping()
    public ResponseEntity<?> getAllClinics(){
        return ResponseEntity.ok(mobileService.getAllClinics());
    }

    @GetMapping(value = "/shop-items/{clinicUuid}")
    public ResponseEntity<?> getAllShopItemsByOwnerUuid(@PathVariable("clinicUuid") Integer ownerUuid){
        return ResponseEntity.ok(mobileService.getAllShopItemsByOwnerUuid(ownerUuid));
    }

    @GetMapping(value = "/subscriptions/{clinicUuid}")
    public ResponseEntity<?> getAllSubscriptionsByOwnerUuid(@PathVariable("clinicUuid") Integer ownerUuid){
        return ResponseEntity.ok(mobileService.getAllSubscriptionsByOwnerUuid(ownerUuid));
    }


}
