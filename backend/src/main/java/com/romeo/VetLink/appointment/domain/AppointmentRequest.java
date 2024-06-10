package com.romeo.VetLink.appointment.domain;

import com.romeo.VetLink.config.OwnedEntity;
import com.romeo.VetLink.patients.domain.Patient;
import jakarta.persistence.*;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "appoitment_request")
public class AppointmentRequest extends OwnedEntity {

    private String customerId;
    private String clinicId;
    private String customerEmail;
    private String customerPhoneNumber;
    private String details;
    @ManyToOne
    private Patient patient;


    @Override
    public void prePersist(){
        this.owner = Integer.valueOf(clinicId);
    }
}
