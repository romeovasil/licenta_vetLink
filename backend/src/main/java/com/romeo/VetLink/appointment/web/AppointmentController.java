package com.romeo.VetLink.appointment.web;

import com.romeo.VetLink.appointment.service.AppointmentService;
import com.romeo.VetLink.appointment.service.dtos.AppointmentDTO;
import com.romeo.VetLink.appointment.service.dtos.ConfirmedScheduleDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600, allowCredentials="true")
@RestController
@RequestMapping("api/v1/appointment")
@RequiredArgsConstructor
public class AppointmentController {

    private final AppointmentService appointmentService;

    @PostMapping()
    public ResponseEntity<?> save(
            @RequestBody AppointmentDTO appointmentDTO){
        appointmentService.save(appointmentDTO);
        return ResponseEntity.ok().build();
    }

    @GetMapping()
    public ResponseEntity<?> getAllByOwner(){
        return ResponseEntity.ok(appointmentService.getAllByOwner());
    }

    @DeleteMapping(value = "/{appointmentId}")
    public ResponseEntity<?> deleteById(@PathVariable Integer appointmentId){
        appointmentService.deleteById(appointmentId);
        return ResponseEntity.ok().build();
    }

    @PostMapping(value="/{appointmentId}/confirm-schedule")
    public ResponseEntity<?> confirmSchedule(@PathVariable Integer appointmentId,
            @RequestBody ConfirmedScheduleDTO confirmedScheduleDTO){
        appointmentService.confirmScheduleForAppointment(appointmentId,confirmedScheduleDTO);
        return ResponseEntity.ok().build();
    }

    @PostMapping(value="/update-schedule")
    public ResponseEntity<?> updateSchedule(
                                             @RequestBody ConfirmedScheduleDTO updatedScheduleDTO){
        appointmentService.updateSchedule(updatedScheduleDTO);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/requests")
    public ResponseEntity<?> getAllAppointmentRequestsByOwner(){
        return ResponseEntity.ok(appointmentService.getAllAppointmentRequestsByOwner());
    }

    @DeleteMapping(value = "/request/{requestId}")
    public ResponseEntity<?> deleteRequest(@PathVariable Integer requestId){
        appointmentService.deleteAppointmentRequestById(requestId);
        return ResponseEntity.ok().build();
    }
}
