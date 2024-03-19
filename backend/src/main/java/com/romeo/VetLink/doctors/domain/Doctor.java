package com.romeo.VetLink.doctors.domain;

import com.romeo.VetLink.config.OwnedEntity;
import com.romeo.VetLink.user.User;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.context.SecurityContextHolder;


@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "doctor")
public class Doctor extends OwnedEntity {
    @Id
    @GeneratedValue
    private Integer id;

    private String firstName;
    private String lastName;
    private String speciality;



    @Override
    public void prePersist(){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        this.owner = user.getClinicId();
    }

}
