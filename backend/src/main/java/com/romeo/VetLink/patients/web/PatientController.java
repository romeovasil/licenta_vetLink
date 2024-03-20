package com.romeo.VetLink.patients.web;


import com.romeo.VetLink.patients.service.PatientService;
import com.romeo.VetLink.patients.service.dtos.PatientDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials="true")
@RestController
@RequestMapping("api/v1/patient")
@RequiredArgsConstructor
public class PatientController {

    private final PatientService patientService;

    @PostMapping()
    public ResponseEntity<?> save(
            @RequestBody PatientDTO patientDTO){
        patientService.save(patientDTO);
        return ResponseEntity.ok().build();
    }

    @GetMapping()
    public ResponseEntity<?> getAllByOwner(){
        return ResponseEntity.ok(patientService.getAllByOwner());
    }

    @DeleteMapping(value = "/{patientId}")
    public ResponseEntity<?> deleteById(@PathVariable Integer patientId){
        patientService.deleteById(patientId);
        return ResponseEntity.ok().build();
    }
}
