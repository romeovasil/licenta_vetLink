package com.romeo.VetLink.patients.domain;

import com.romeo.VetLink.config.OwnedEntity;
import com.romeo.VetLink.user.User;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;
import org.springframework.security.core.context.SecurityContextHolder;


@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Patient")
public class Patient extends OwnedEntity {
    @Id
    @GeneratedValue
    private Integer id;

    private String type;
    private String race;
    private String subRace;
    private String name;
    private Integer age;
    private String allergy;
    private String healthProblems;



    @Override
    public void prePersist(){
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        this.owner = user.getClinicId();
    }

}
