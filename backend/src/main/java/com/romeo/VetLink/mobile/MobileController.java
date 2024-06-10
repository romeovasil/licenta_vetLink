package com.romeo.VetLink.mobile;

import com.romeo.VetLink.order.service.OrderService;
import com.romeo.VetLink.order.service.dtos.OrderDTO;
import com.romeo.VetLink.subscription.service.CustomerSubscriptionService;
import com.romeo.VetLink.subscription.service.dtos.CustomerSubscriptionDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("api/v1/mobile")
@RequiredArgsConstructor
public class MobileController {

    private final MobileService mobileService;
    private final CustomerSubscriptionService customerSubscriptionService;
    private final OrderService orderService;

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

    @PostMapping(value = "/customer-subscription")
    public ResponseEntity<?> saveCustomerSubscription(@RequestBody CustomerSubscriptionDTO customerSubscriptionDTO){

        customerSubscriptionService.save(customerSubscriptionDTO);

        return ResponseEntity.ok().build();
    }

    @GetMapping(value = "/customer-subscription/current/{customerId}")
    public ResponseEntity<?> getCurrentCustomerSubscription(@PathVariable("customerId") String customerId){

        return ResponseEntity.ok(customerSubscriptionService.getCurrentByCustomerId(customerId));
    }

    @PostMapping(value = "/order")
    public ResponseEntity<?> saveOrder(@RequestBody OrderDTO orderDTO){

        orderService.saveOrder(orderDTO);

        return ResponseEntity.ok().build();
    }

    @GetMapping(value = "/order-list/{customerId}")
    public ResponseEntity<?> getOrderListForCustomer(@PathVariable("customerId") String customerId){

        return ResponseEntity.ok(orderService.getAllOrdersByCustomerId(customerId));
    }
}
