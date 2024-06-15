package com.romeo.VetLink.appointment.service;


import com.romeo.VetLink.appointment.domain.Appointment;
import com.romeo.VetLink.appointment.service.dtos.AppointmentDTO;
import com.romeo.VetLink.config.EmailSenderService;
import com.romeo.VetLink.vetClinic.domain.VetClinic;
import com.romeo.VetLink.vetClinic.service.dtos.VetClinicService;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;


@Component
public class SendEmailEventListener {

    private final EmailSenderService emailSenderService;
    private final VetClinicService vetClinicService;

    public SendEmailEventListener(EmailSenderService emailSenderService, VetClinicService vetClinicService) {
        this.emailSenderService = emailSenderService;
        this.vetClinicService = vetClinicService;
    }

    @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
    @Async
    public void onApplicationEvent(SendEmailEvent event) {

        VetClinic vetClinic = vetClinicService.getById(event.getClinicId());

       emailSenderService.sendEmail(event.getSendTo(),"Programare confirmata la clinica " + vetClinic.getName(),
               "Programarea dvs a fost confirmata pentru " + event.getDate() + " la dr. " + event.getDoctorName() +
               ". Va asteptam cu drag! ");
    }
}
