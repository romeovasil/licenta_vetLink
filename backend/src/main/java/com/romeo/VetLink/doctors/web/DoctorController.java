package com.romeo.VetLink.doctors.web;

import com.romeo.VetLink.doctors.service.DoctorService;
import com.romeo.VetLink.doctors.service.dtos.DoctorDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials="true")
@RestController
@RequestMapping("api/v1/doctor")
@RequiredArgsConstructor
public class DoctorController {

    private final DoctorService doctorService;

    @PostMapping()
    public ResponseEntity<?> save(
            @RequestBody DoctorDTO doctorDTO){
        doctorService.save(doctorDTO);
        return ResponseEntity.ok().build();
    }

    @GetMapping()
    public ResponseEntity<?> getAllByOwner(){
        return ResponseEntity.ok(doctorService.getAllByOwner());
    }

    @DeleteMapping(value = "/{doctorId}")
    public ResponseEntity<?> deleteById(@PathVariable Integer doctorId){
        doctorService.deleteById(doctorId);
        return ResponseEntity.ok().build();
    }
}
