package com.romeo.VetLink.vetClinic.web;


import com.romeo.VetLink.vetClinic.service.dtos.VetClinicDTO;
import com.romeo.VetLink.vetClinic.service.dtos.VetClinicService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials="true")
@RestController
@RequestMapping("api/v1/vet-clinic")
@RequiredArgsConstructor
public class VetClinicController {
    private final VetClinicService vetClinicService;

    @PostMapping()
    public ResponseEntity<?> save(
            @RequestBody VetClinicDTO vetClinicDTO){
        vetClinicService.save(vetClinicDTO);
        return ResponseEntity.ok().build();
    }
    @GetMapping("existing")
    public ResponseEntity<?> getExistingVetClinicForCurrentUser(){
        return  ResponseEntity.ok(vetClinicService.getExistingVetClinicForCurrentUser());
    }
}
