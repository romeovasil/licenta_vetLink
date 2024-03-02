package com.romeo.VetLink.shopItem.web;


import com.romeo.VetLink.shopItem.service.ShopItemService;
import com.romeo.VetLink.shopItem.service.dtos.ShopItemDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials="true")
@RestController
@RequestMapping("api/v1/shop-item")
@RequiredArgsConstructor
public class ShopItemController {
    private final ShopItemService shopItemService;

    @PostMapping()
    public ResponseEntity<?> save(
            @RequestBody ShopItemDTO shopItemDTO){
        shopItemService.save(shopItemDTO);
        return ResponseEntity.ok().build();
    }

    @GetMapping()
    public ResponseEntity<?> getAllByOwner(){
        return ResponseEntity.ok(shopItemService.getAllByOwner());
    }

    @DeleteMapping(value = "/{shopItemId}")
    public ResponseEntity<?> deleteById(@PathVariable Integer shopItemId){
        shopItemService.deleteById(shopItemId);
        return ResponseEntity.ok().build();
    }

}
