package com.romeo.VetLink.appointment.domain;

import com.romeo.VetLink.config.OwnedEntity;
import com.romeo.VetLink.doctors.domain.Doctor;
import com.romeo.VetLink.patients.domain.Patient;
import com.romeo.VetLink.user.User;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.context.SecurityContextHolder;

import java.time.LocalDateTime;

@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "confirmed_schedule")
public class ConfirmedSchedule extends OwnedEntity {

    @Id
    @GeneratedValue
    private Integer id;

    private LocalDateTime start;
    private LocalDateTime endTime;
    @ManyToOne(optional = false)
    @JoinColumn(name = "doctor_number", foreignKey = @ForeignKey(name = "FK_CONFIRMED_SCHEDULE__DOCTOR"))
    private Doctor doctor;


    @Override
    public void prePersist(){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        this.owner = user.getClinicId();
    }

}
