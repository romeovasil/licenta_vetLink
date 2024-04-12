package com.romeo.VetLink.appointment.domain;

import com.romeo.VetLink.config.OwnedEntity;
import com.romeo.VetLink.patients.domain.Patient;
import com.romeo.VetLink.user.User;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.List;


@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "appointment")
public class Appointment extends OwnedEntity {
    @Id
    @GeneratedValue
    private Integer id;

    private String job;
    private String eventLength;
    private Boolean unscheduled;
    @ManyToOne(optional = false)
    @JoinColumn(name = "patient_id", foreignKey = @ForeignKey(name = "FK_APPOINTMENT__PATIENT"))
    private Patient patient;

    @OneToOne()
    @JoinColumn(name = "confirmed_schedule_id", foreignKey = @ForeignKey(name = "FK_APPOINTMENT__CONFIRMED_SCHEDULED"))
    private ConfirmedSchedule confirmedSchedule;

    @Override
    public void prePersist(){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        this.owner = user.getClinicId();
        this.unscheduled = true;
    }

}
