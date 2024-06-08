package com.romeo.VetLink.vetClinic.domain;

import com.romeo.VetLink.config.OwnedEntity;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "vet_clinic")
public class VetClinic extends OwnedEntity {
    @Id
    @GeneratedValue
    private Integer id;

    private String name;
    private String county;
    private String city;
    private String street;
    private String number;
    private String phoneNumber;
    private String shortDescription;


}
