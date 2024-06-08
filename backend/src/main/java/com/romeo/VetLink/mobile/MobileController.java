package com.romeo.VetLink.mobile;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:55365", maxAge = 3600, allowCredentials="true")
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


}
