package com.romeo.VetLink.appointment.service;
import com.romeo.VetLink.appointment.service.dtos.AppointmentDTO;
import org.springframework.context.ApplicationEvent;

public class SendEmailEvent extends ApplicationEvent {
    private final String sendTo;
    private final String date;
    private final Integer clinicId;
    private final String doctorName;

    public SendEmailEvent(Integer appointmentId, Integer clinicId, String sendTo,String date, String doctorName) {
        super(appointmentId);
        this.sendTo = sendTo;
        this.date = date;
        this.clinicId = clinicId;
        this.doctorName = doctorName;
    }

    public String getSendTo() {
        return sendTo;
    }

    public String getDate() {
        return date;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public Integer getClinicId() {
        return clinicId;
    }
}
