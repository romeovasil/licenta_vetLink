package com.romeo.VetLink.appointment.domain;

import com.romeo.VetLink.config.OwnedEntity;
import com.romeo.VetLink.user.User;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
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
    private Integer doctorNumber;


    @Override
    public void prePersist(){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        this.owner = user.getClinicId();
    }

}
